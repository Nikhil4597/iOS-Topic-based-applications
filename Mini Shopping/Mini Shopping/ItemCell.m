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
    if(self){
        [self addAttributes];
    }
    return self;
}

- (void)addAttributes {
    [self configItemImageView];
    [self configItemTitle];
    [self configItemPrice];
    [self configItemRating];
    [self configItemCategory];
}

- (void)configItemPrice {
    self.itemPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.itemPrice setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
    
    [self addSubview:self.itemPrice];
    [self configItemPriceConstraints];
    
}
- (void)configItemTitle {
    self.itemTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    self.itemTitle.numberOfLines = 2;

    [self addSubview:self.itemTitle];
    [self configItemTitleConstraints];
}
- (void)configItemRating {
    self.itemRating = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.itemRating];
    [self configItemRatingConstraints];

}
- (void)configItemCategory {
    self.itemCategory = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.itemCategory];
    [self configItemCategoryConstaints];
}
- (void)configItemImageView {
    //default image
    self.itemImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    self.itemImageView.backgroundColor = [UIColor greenColor];

    [self addSubview:self.itemImageView];
    [self configItemImageViewConstaints];
}

- (void)configItemPriceConstraints {
    self.itemPrice.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topConstraint = [ self.itemPrice.topAnchor constraintEqualToAnchor:self.itemTitle.bottomAnchor constant:10.0];
    
    NSLayoutConstraint *leadingConstraint = [ self.itemPrice.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant: 10.0];
    
    NSLayoutConstraint *trailingConstraint = [ self.itemPrice.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10.0];
    
    // Activate the constraints
    NSArray *constraints = @[topConstraint, leadingConstraint, trailingConstraint];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)configItemTitleConstraints {
    self.itemTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topConstraint = [ self.itemTitle.topAnchor constraintEqualToAnchor:self.topAnchor constant:10.0];
    
    NSLayoutConstraint *leadingConstraint = [ self.itemTitle.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:10.0];
    
    NSLayoutConstraint *trailingConstraint = [ self.itemTitle.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10.0];
    
    // Activate the constraints
    NSArray *constraints = @[topConstraint, leadingConstraint, trailingConstraint];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)configItemRatingConstraints {
    self.itemRating.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topConstraint = [ self.itemRating.topAnchor constraintEqualToAnchor:self.itemPrice.bottomAnchor constant:10.0];
    
    NSLayoutConstraint *leadingConstraint = [ self.itemRating.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:10.0];
    
    NSLayoutConstraint *trailingConstraint = [ self.itemRating.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10.0];
    
    // Activate the constraints
    NSArray *constraints = @[topConstraint, leadingConstraint,  trailingConstraint];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)configItemCategoryConstaints {
    self.itemCategory.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topConstraint = [ self.itemCategory.topAnchor constraintEqualToAnchor:self.itemRating.bottomAnchor constant:10.0];
    
    NSLayoutConstraint *leadingConstraint = [ self.itemCategory.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant: 10.0];
    
    NSLayoutConstraint *trailingConstraint = [ self.itemCategory.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10.0];
    
    // Activate the constraints
    NSArray *constraints = @[topConstraint, leadingConstraint, trailingConstraint];
    [NSLayoutConstraint activateConstraints:constraints];
}

-(void)configItemImageViewConstaints {
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topConstraint = [ self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:10.0];
    
    NSLayoutConstraint *leadingConstraint = [ self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20.0];
    
    NSLayoutConstraint *bottomConstraint = [ self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-20.0];
    
    // Activate the constraints
    NSArray *constraints = @[topConstraint,leadingConstraint,bottomConstraint];

    [NSLayoutConstraint activateConstraints:constraints];
}

@end
