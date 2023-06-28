//
//  MIniShoppingView.m
//  Mini Shopping
//
//  Created by ROHIT MISHRA on 15/04/23.
//

#import "MiniShoppingView.h"

@implementation MiniShoppingView {
    UIStackView * stackView;
}

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _headerTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [self configView];
    }
    return self;
}

// configure view
- (void)configView {
    [self configHeaderTitle];
    [self configStackView];
}

// config sort buttons
- (void)configStackView {
   stackView = [[UIStackView alloc] initWithFrame:CGRectZero];

    // Arrangement for buttons.
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    
    // Add stack view.
    [self addSubview:stackView];
    
    [self configStackViewConstraints];
    
    
    [self configPriceSortingBtn];
    [self configCategorySortingBtn];
    
    [stackView addArrangedSubview:self.priceSortBtn];
    [stackView addArrangedSubview:self.categorySortBtn];
    
//    [self configPriceSortBtnConstraints];
//    [self configCategorySortingBtnContraints];
}

- (void)configStackViewConstraints {
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [stackView.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor constant:10].active = YES;
    [stackView.leadingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leadingAnchor constant:10].active = YES;
    [stackView.trailingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.trailingAnchor constant:-10].active = YES;
    
}

- (void)configPriceSortingBtn {
    self.priceSortBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.priceSortBtn setTitle:@"Sort by Price" forState:UIControlStateNormal];
    self.priceSortBtn.backgroundColor = [UIColor systemBlueColor];
    [self configPriceSortBtnConstraints];
}

- (void)configPriceSortBtnConstraints {
    self.priceSortBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.priceSortBtn.widthAnchor constraintEqualToConstant:150].active = YES;
    [self.priceSortBtn.heightAnchor constraintEqualToConstant:75].active = YES;
}

- (void)configCategorySortingBtn {
    self.categorySortBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.categorySortBtn setTitle:@"Sort by Category" forState:UIControlStateNormal];
    self.categorySortBtn.backgroundColor = [UIColor systemBlueColor];
    [self configCategorySortingBtnContraints];
}

- (void)configCategorySortingBtnContraints {
    self.categorySortBtn.translatesAutoresizingMaskIntoConstraints = NO;

    [self.categorySortBtn.widthAnchor constraintEqualToConstant:150].active = YES;
    [self.categorySortBtn.heightAnchor constraintEqualToConstant:75].active = YES;
}

- (void)configHeaderTitle {
    self.headerTitle.text = @"Mini shopping";
    self.headerTitle.backgroundColor = [UIColor systemBlueColor];
    self.headerTitle.textColor = [UIColor whiteColor];
    self.headerTitle.textAlignment = NSTextAlignmentCenter;

    // Bold header title text
    [self.headerTitle setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];

    [self addSubview:self.headerTitle];
    [self configHeaderTitleConstraints];
}

- (void)configHeaderTitleConstraints {
    self.headerTitle.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *topConstraint = [self.headerTitle.topAnchor constraintEqualToAnchor:self.topAnchor constant:50.0];
    NSLayoutConstraint *leadingConstraint = [self.headerTitle.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
    NSLayoutConstraint *trailingConstraint = [self.headerTitle.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
    NSLayoutConstraint *heightConstraint = [self.headerTitle.heightAnchor constraintEqualToConstant:30.0];

    // Activate the constraints
    NSArray *constraints = @[topConstraint, leadingConstraint, trailingConstraint, heightConstraint];

    [NSLayoutConstraint activateConstraints:constraints];
}
@end
