//
//  ItemCell.m
//  Mini Shopping
//
//  Created by ROHIT MISHRA on 15/04/23.
//

#import "ItemCell.h"

@implementation ItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self addAttributes];
    }
    return self;
}

- (void)addAttributes {
    [self configureItemImageView];
    [self configureItemTitle];
    [self configureItemPrice];
    [self configureItemRating];
    [self configureItemCategory];
}

- (void)configureItemPrice {
    self.itemPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.itemPrice.numberOfLines = 2;
    [self.itemPrice setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [self addSubview:self.itemPrice];
    [self configureItemPriceConstraints];
    
}
- (void)configureItemTitle {
    self.itemTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    self.itemTitle.numberOfLines = 3;
    
    [self.itemTitle setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];

    [self addSubview:self.itemTitle];
    [self configureItemTitleConstraints];
}
- (void)configureItemRating {
    self.itemRating = [[UILabel alloc] initWithFrame:CGRectZero];
    self.itemRating.numberOfLines = 2;
    [self.itemRating setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [self addSubview:self.itemRating];
    [self configureItemRatingConstraints];

}
- (void)configureItemCategory {
    self.itemCategory = [[UILabel alloc] initWithFrame:CGRectZero];
    self.itemCategory.numberOfLines = 3;

    [self.itemCategory setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [self fontSize];
    [self addSubview:self.itemCategory];
    [self configureItemCategoryConstaints];
}

- (CGFloat)fontSize {
    UIFont *bodyFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];

    // get the font size of the body text style
    CGFloat bodyFontSize = bodyFont.pointSize;

    return bodyFontSize;
}

- (void)configureItemImageView {
    self.itemImageView = [[UIImageView alloc]initWithFrame: CGRectZero];
    self.imageView.image = [UIImage imageNamed:@"Spinner"];

    // layout round
    self.imageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
    self.imageView.layer.cornerRadius=20;
    self.imageView.layer.borderWidth=1.0;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderColor=[[UIColor systemBlueColor] CGColor];

    [self addSubview:self.itemImageView];
    [self configureItemImageViewConstaints];
}

# pragma constrainst

-(void)configureItemImageViewConstaints {
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;

        // Activate the constraints
        [NSLayoutConstraint activateConstraints:@[
            [ self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:10.0],
            [ self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20.0],
            [ self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-20.0]
        ]];
    
}

- (void)configureItemTitleConstraints {
    self.itemTitle.translatesAutoresizingMaskIntoConstraints = NO;

    // Activate the constraints
    [NSLayoutConstraint activateConstraints:@[
        [ self.itemTitle.topAnchor constraintEqualToAnchor:self.topAnchor constant:20.0],
        [ self.itemTitle.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:18.0],
        [ self.itemTitle.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
    ]];
}

- (void)configureItemPriceConstraints {
    self.itemPrice.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topConstraint = [ self.itemPrice.topAnchor constraintEqualToAnchor:self.itemTitle.topAnchor constant:[self fontSize]+60];
    
    NSLayoutConstraint *leadingConstraint = [ self.itemPrice.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant: 18.0];
    
    NSLayoutConstraint *trailingConstraint = [ self.itemPrice.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
    
    // Activate the constraints
    NSArray *constraints = @[topConstraint, leadingConstraint, trailingConstraint];
    [NSLayoutConstraint activateConstraints:constraints];
    
    if([self fontSize]>=47) {
        topConstraint.active = NO;
        NSLayoutConstraint *updateTopConstraint = [ self.itemPrice.topAnchor constraintEqualToAnchor:self.itemTitle.topAnchor constant:[self fontSize]+120];
        updateTopConstraint.active = YES;
    }
}

- (void)configureItemRatingConstraints {
    self.itemRating.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Activate the constraints
    [NSLayoutConstraint activateConstraints:@[
        [ self.itemRating.topAnchor constraintEqualToAnchor:self.itemPrice.bottomAnchor constant:4.0],
        [ self.itemRating.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:18.0],
        [self.itemRating.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
    ]];
}

- (void)configureItemCategoryConstaints {
    self.itemCategory.translatesAutoresizingMaskIntoConstraints = NO;

    // Activate the constraints
    [NSLayoutConstraint activateConstraints:@[
        [ self.itemCategory.topAnchor constraintEqualToAnchor:self.itemRating.bottomAnchor constant:7.0],
        [ self.itemCategory.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant: 18.0],
        [ self.itemCategory.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
    ]];
}

@end
