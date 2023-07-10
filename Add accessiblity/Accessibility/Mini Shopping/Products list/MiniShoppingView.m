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

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _headerTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [self configureView];
    }
    return self;
}

/*
 * Configure mini shopping view.
 */
- (void)configureView {
    [self configureHeaderTitle];
    [self configureStackView];
}

/*
 * Configure sorting buttons.
 */
- (void)configureStackView {
   stackView = [[UIStackView alloc] initWithFrame:CGRectZero];

    // Arrangement for buttons.
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    
    // Add stack view.
    [self addSubview:stackView];
    
    [self configureStackViewConstraints];
    
    
    [self configurePriceSortingButton];
    [self configureCategorySortingButton];
    
    [stackView addArrangedSubview:self.priceSortButton];
    [stackView addArrangedSubview:self.categorySortButton];
}

- (void)configureStackViewConstraints {
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [stackView.topAnchor constraintEqualToAnchor:self.headerTitle.bottomAnchor constant:10],
        [stackView.leadingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leadingAnchor constant:10],
        [stackView.trailingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.trailingAnchor constant:-10]
    ]];
    
}

- (void)configurePriceSortingButton {
    self.priceSortButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.priceSortButton setTitle:@"Sort by Price" forState:UIControlStateNormal];
    self.priceSortButton.backgroundColor = [UIColor systemBlueColor];
    [self configurePriceSortingButtonConstraints];
}

- (void)configurePriceSortingButtonConstraints {
    self.priceSortButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.priceSortButton.widthAnchor constraintEqualToConstant:150].active = YES;
    [self.priceSortButton.heightAnchor constraintEqualToConstant:75].active = YES;
}

- (void)configureCategorySortingButton {
    self.categorySortButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.categorySortButton setTitle:@"Sort by Category" forState:UIControlStateNormal];
    self.categorySortButton.backgroundColor = [UIColor systemBlueColor];
    [self configureCategorySortingButtonContraints];
}

- (void)configureCategorySortingButtonContraints {
    self.categorySortButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self.categorySortButton.widthAnchor constraintEqualToConstant:150].active = YES;
    [self.categorySortButton.heightAnchor constraintEqualToConstant:75].active = YES;
}

- (void)configureHeaderTitle {
    self.headerTitle.text = @"Mini shopping";
    self.headerTitle.backgroundColor = [UIColor systemBlueColor];
    self.headerTitle.textColor = [UIColor whiteColor];
    self.headerTitle.textAlignment = NSTextAlignmentCenter;

    // Bold header title text
    [self.headerTitle setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];

    [self addSubview:self.headerTitle];
    [self configureHeaderTitleConstraints];
}

- (void)configureHeaderTitleConstraints {
    self.headerTitle.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.headerTitle.topAnchor constraintEqualToAnchor:self.topAnchor constant:50.0],
        [self.headerTitle.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.headerTitle.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.headerTitle.heightAnchor constraintEqualToConstant:30.0]
    ]];
}
@end
