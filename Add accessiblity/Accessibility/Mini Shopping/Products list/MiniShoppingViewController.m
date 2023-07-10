//
//  MiniShoppingViewController.m
//  Mini Shopping
//
//  Created by ROHIT MISHRA on 15/04/23.
//

#import "MiniShoppingViewController.h"
#import "MiniShoppingDataModel.h"
#import "ItemCell.h"
#import "ImageDownloader.h"

@interface MiniShoppingViewController ()

@end

@implementation MiniShoppingViewController {
    MiniShoppingDataModel * dataModel;
    ImageDownloader * imageDownloader;
    NSArray * responseData;
    BOOL priceSortButtonTapped;
    BOOL categorySortButtonTapped;
    int sliderValue;
}

# pragma ViewController lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Add accessibility info.
    self.view.isAccessibilityElement = NO;

    imageDownloader = [[ImageDownloader alloc]init];
    dataModel = [[MiniShoppingDataModel alloc] init];
    
    priceSortButtonTapped = false;
    categorySortButtonTapped = false;
    sliderValue = 0;
    [self configureResponseData];
    
    // Notify cell about text size chnage.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredContentSizeChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

# pragma DataSource delegate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"cellIdentifier";
    ItemCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(cell == nil) {
        cell = [[ItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //configure product item
    [self downloadImageUsingURL:[NSURL URLWithString:[responseData[indexPath.row] valueForKey:@"thumbnail"]] indexPath:indexPath];
    
    cell.itemTitle.text = [self modifyTitle:[responseData[indexPath.row] valueForKey:@"title"]];
    
    cell.itemPrice.text = [self modifyPrice:[NSString stringWithFormat:@"Price: $ %@",[responseData[indexPath.row] valueForKey:@"price"]]];

    cell.itemCategory.text = [self modifyCateogory:[NSString stringWithFormat:@"Category: %@",[responseData[indexPath.row] valueForKey:@"category"]]];

    cell.itemRating.text = [self modifyRating:[NSString stringWithFormat:@"Rating: %@",[responseData[indexPath.row] valueForKey:@"rating"]]];

    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);

    // accessibility
    cell.isAccessibilityElement = YES;
    cell.accessibilityLabel = [NSString stringWithFormat:@"product name: %@,  %@ , %@ , %@",
                               cell.itemTitle.text,cell.itemPrice.text,
                               cell.itemRating.text,
                               cell.itemCategory.text];
    cell.accessibilityTraits = UIAccessibilityTraitNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.imageView.image = [UIImage imageNamed:@"Spinner"];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return responseData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIFont *bodyFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];

    
    CGFloat bodyFontSize = bodyFont.pointSize;

    if(bodyFontSize < 40 || bodyFontSize >= 47) {
        return bodyFontSize*12;
    }
    return bodyFontSize*8;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma  private

/*
 *Download image data and render it.
 */
- (void)downloadImageUsingURL:(NSURL *)imageURL indexPath:(NSIndexPath *)indexPath {
    [imageDownloader downloadImagesFromURL:imageURL completion:^(UIImage *image, NSError *error){
        if (image != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                ItemCell * cell = [self.miniShoppingTableView cellForRowAtIndexPath:indexPath];
                
                cell.imageView.image = image;
                [cell setNeedsLayout];
            });
           } else {
               NSLog(@"Unable to set image with erorr %@ at index %ld", error,indexPath.row);
               return;
           }
    }];
}

/*
 * Add table view in UI.
 */
- (void)makeTableView {
    if(self.miniShoppingTableView != nil){
        [self.miniShoppingTableView removeFromSuperview];
    }
    self.miniShoppingTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

    self.miniShoppingTableView.delegate = self;
    self.miniShoppingTableView.dataSource = self;

    [self.view addSubview:self.miniShoppingTableView];
}

/*
 * Perform tap action on category sort button.
 */
- (void)categoryTappedCalled {
    categorySortButtonTapped = YES;
    priceSortButtonTapped = NO;
    
    [self configureResponseData];
}

- (void)priceTappedCalled {
    priceSortButtonTapped = YES;
    categorySortButtonTapped = NO;
    
    [self configureResponseData];
}

/*
 * Get and set response data in UI.
 */
- (void)configureResponseData {
    __weak typeof(self) weakSelf = self;
       [dataModel fetchDataWithCompletion:^(NSDictionary * dataDictionary) {
           dispatch_async(dispatch_get_main_queue(), ^{
               __strong typeof(self) strongSelf = weakSelf;
               if(!strongSelf) {
                   return;
               }

               NSDictionary * keyValue = [[NSDictionary alloc] initWithDictionary:dataDictionary];
               
               
               strongSelf->responseData = [[NSArray alloc] initWithArray:keyValue[@"products"]];
               
               if(strongSelf->categorySortButtonTapped) {
                   strongSelf->responseData = [strongSelf->responseData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                       return [obj1[@"category"] localizedCaseInsensitiveCompare:obj2[@"category"]];
                   }];
               }
               if(strongSelf->priceSortButtonTapped) {
                   strongSelf->responseData = [strongSelf->responseData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                       int int1 = [obj1[@"price"] intValue];
                       int int2 = [obj2[@"price"] intValue];
                       if (int1 < int2) {
                           return NSOrderedAscending;
                       } else if (int1 > int2) {
                           return NSOrderedDescending;
                       } else {
                           return NSOrderedSame;
                       }
                   }];
              }
            
               if(strongSelf->sliderValue > 1 ) {
                   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"price <= %d", strongSelf->sliderValue];
                   strongSelf->responseData = [strongSelf->responseData filteredArrayUsingPredicate:predicate];
               }
                   
               [self makeTableView];

           });
       }];
}

- (void)sliderValueChange:(UISlider *)sender {
    sliderValue = sender.value;
    [self.delegate shoppingViewController:self
                            didUpdateData:[NSString stringWithFormat:@"%d", sliderValue]];
    [self configureResponseData];
}

- (void)preferredContentSizeChanged:(NSNotification *)notification {
    [[UILabel appearance] setFont:
     [UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
}

- (NSString *)modifyTitle:(NSString *)iniText {

    NSArray * words = [iniText componentsSeparatedByString:@" "];
    if([words count] > 2) {
        return [NSString stringWithFormat:@"%@\n%@",words[0],[self breakStringIfNeeded:words[1]]];
    }
    return words[0];
}

- (NSString *)modifyCateogory:(NSString *)iniText {

    NSArray * words = [iniText componentsSeparatedByString:@"-"];
    if([words count] > 2) {
        return [NSString stringWithFormat:@"%@:\n%@",words[0],[self breakStringIfNeeded:words[1]]];
    }
    return [self breakStringIfNeeded:words[0]];
}

- (NSString *)breakStringIfNeeded:(NSString * )text {
    UIFont *bodyFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    NSUInteger length = [text length];
    if(bodyFont.pointSize >= 47 && length >= 10) {
        NSUInteger halfway = length / 2;
        NSString *firstPart = [text substringToIndex:halfway];
        NSString *secondPart = [text substringFromIndex:halfway];
        return [NSString stringWithFormat:@"%@\n%@",firstPart,secondPart];
    }
    return text;
}

- (NSString *)modifyRating:(NSString *)iniText {
    UIFont *bodyFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];

    if( bodyFont.pointSize == 53) {
        NSArray * words = [iniText componentsSeparatedByString:@"."];
        if([words count] >= 2) {
            return [NSString stringWithFormat:@"%@\n.%@",words[0],words[1]];
        }
        return words[0];
    }
    return iniText;
}

- (NSString *)modifyPrice:(NSString *)iniText {
    UIFont *bodyFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    if( bodyFont.pointSize >= 47) {
        NSArray * words = [iniText componentsSeparatedByString:@"$"];
        return [NSString stringWithFormat:@"%@\n$ %@",words[0],words[1]];
    }
    return iniText;
}

@end
