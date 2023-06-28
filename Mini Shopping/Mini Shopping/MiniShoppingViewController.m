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
    BOOL priceSortBtnTapped;
    BOOL categorySortBtnTapped;
}

# pragma ViewController lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    imageDownloader = [[ImageDownloader alloc]init];
    dataModel = [[MiniShoppingDataModel alloc] init];
    priceSortBtnTapped = false;
    categorySortBtnTapped = false;
    [self configResponseData];
}

# pragma DataSource delegate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"cellIdentifier";
    ItemCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(cell == nil) {
        cell = [[ItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"Spinner"];
    [self downloadImageUsingURL:[NSURL URLWithString:[responseData[indexPath.row] valueForKey:@"thumbnail"]] indexPath:indexPath];
    
    cell.itemTitle.text = [responseData[indexPath.row] valueForKey:@"title"];
    if([cell.itemTitle.text length] > 25)
    {
        NSUInteger stringLength = [cell.itemTitle.text length];
        NSUInteger halfLength = stringLength / 2;
        NSRange firstHalfRange = NSMakeRange(0, halfLength);
        NSRange secondHalfRange = NSMakeRange(halfLength, stringLength - halfLength);
        NSString *firstHalf = [cell.itemTitle.text substringWithRange:firstHalfRange];
        NSString *secondHalf = [cell.itemTitle.text substringWithRange:secondHalfRange];
        NSString * text = [NSString stringWithFormat:@"%@\n%@",firstHalf,secondHalf];
        cell.itemTitle.text = text;
    }
    
    cell.itemPrice.text = [NSString stringWithFormat:@"Price: $ %@",[responseData[indexPath.row] valueForKey:@"price"]];
    cell.itemCategory.text = [NSString stringWithFormat:@"Category: %@",[responseData[indexPath.row] valueForKey:@"category"]];
    cell.itemRating.text = [NSString stringWithFormat:@"Rating: %@ ⭐️",[responseData[indexPath.row] valueForKey:@"rating"]];
    
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return responseData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma  private

// Download image data and render it.
- (void)downloadImageUsingURL:(NSURL *)imageURL indexPath:(NSIndexPath *)indexPath {
    [imageDownloader downloadImagesFromURL:imageURL completion:^(UIImage *image, NSError *error){
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                ItemCell * cell = [self.miniShoppingTableView cellForRowAtIndexPath:indexPath];
                cell.imageView.image = image;
                [cell setNeedsLayout];
            });
           } else {
               NSLog(@"Unable to set image with erorr %@", error);
               return;
           }
    }];
}

// Add table view in UI.
- (void)makeTableView {
    if(self.miniShoppingTableView != nil){
        [self.miniShoppingTableView removeFromSuperview];
    }
    self.miniShoppingTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

    self.miniShoppingTableView.delegate = self;
    self.miniShoppingTableView.dataSource = self;

    [self.view addSubview:self.miniShoppingTableView];
}

// Perform tap action on category sort button.
- (void)categoryTappedCalled {
    categorySortBtnTapped = YES;
    priceSortBtnTapped = NO;
    
    [self configResponseData];
}

// Perform tap action on price sort button.
- (void)priceTappedCalled {
    priceSortBtnTapped = YES;
    categorySortBtnTapped = NO;
    
    [self configResponseData];
}

// Get and set response data in UI
- (void)configResponseData {
    __weak typeof(self) weakSelf = self;
       [dataModel fetchDataWithCompletion:^(NSDictionary * dataDictionary) {
           dispatch_async(dispatch_get_main_queue(), ^{
               __strong typeof(self) strongSelf = weakSelf;
               if(!strongSelf) {
                   return;
               }

               NSDictionary * keyValue = [[NSDictionary alloc] initWithDictionary:dataDictionary];
               
               
               strongSelf->responseData = [[NSArray alloc] initWithArray:keyValue[@"products"]];
               
               if(strongSelf->categorySortBtnTapped) {
                   strongSelf->responseData = [strongSelf->responseData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
                       return [obj1[@"category"] localizedCaseInsensitiveCompare:obj2[@"category"]];
                   }];
               }
               if(strongSelf->priceSortBtnTapped) {
                   strongSelf->responseData = [strongSelf->responseData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
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
                   
               [self makeTableView];

           });
       }];
}


@end
