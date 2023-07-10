//
//  ViewController.m
//  Mini Shopping
//
//  Created by ROHIT MISHRA on 16/04/23.
//

#import "MainViewController.h"
#import "MiniShoppingView.h"
#import "MiniShoppingViewController.h"

@interface MainViewController ()
@end

@implementation MainViewController {
    MiniShoppingViewController * shoppingVC;
    UILabel * sliderLabal;
}

#pragma viewController lifeCycle
- (instancetype)init {
    self = [super init];
    if(self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
   [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize shopping view controller.
    shoppingVC = [[MiniShoppingViewController alloc]init];

    [self configureUpperView];
    [self configureSlider];
    [self configureTableVC];
    
    // Add accessibility info.
    self.view.isAccessibilityElement = NO;
}

# pragma  Delegate
- (void)shoppingViewController:(UIViewController *)viewController didUpdateData:(NSString* )value {
    [self configureSlideValue:value];
}

#pragma private method
- (void)configureSlideValue:(NSString *)value {
    if(sliderLabal != nil) {
        [sliderLabal removeFromSuperview];
    }

    sliderLabal = [[UILabel alloc] initWithFrame:CGRectMake(320, 200, 50, 20)];
    sliderLabal.text = value;
    
    // Accessbility value for slider.
    self.slider.accessibilityValue = sliderLabal.text;

    // Add accessibility label from slider with updated value.
    self.slider.accessibilityLabel = [NSString stringWithFormat:@"Filter slider, value: %@", value];
    [self.view addSubview:sliderLabal];
}

- (void)configureUpperView {
   self.shoppingView = [[MiniShoppingView alloc] initWithFrame:CGRectZero];
    [self.shoppingView.categorySortButton addTarget:shoppingVC action:@selector(categoryTappedCalled) forControlEvents:UIControlEventTouchUpInside];
    [self.shoppingView.priceSortButton addTarget:shoppingVC action:@selector(priceTappedCalled) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.shoppingView];
    [self configureUpperViewContraint];
}

- (void)configureSlider {
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(10,200, 300, 20)];

    self.slider.minimumValue = 1;
    self.slider.maximumValue = 1800;
    
    self.slider.minimumTrackTintColor = [UIColor greenColor];
    
    // Set accessibility info.
    self.slider.isAccessibilityElement = YES;
    self.slider.accessibilityTraits = UIAccessibilityTraitAdjustable;
    
    // Action on changing value.
    [self.slider addTarget:shoppingVC action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    
    [self configureSlideValue:@"1"];
    [self.view addSubview:self.slider];
}

- (void)configureTableVC {
    shoppingVC.delegate = self;

    [self addChildViewController:shoppingVC];
    [self.view addSubview:shoppingVC.view];
    
    [self configureTableViewConstraints];
}

- (void)configureUpperViewContraint {
    self.shoppingView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Activate the constraints
    [NSLayoutConstraint activateConstraints:@[
        [ self.shoppingView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:10.0],
        [ self.shoppingView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [ self.shoppingView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [ self.shoppingView.heightAnchor constraintEqualToConstant:180.0]
    ]];
}

- (void)configureTableViewConstraints {
    shoppingVC.view.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [ shoppingVC.view.topAnchor constraintEqualToAnchor: self.slider.bottomAnchor constant:10.0],
        [ shoppingVC.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10.0],
        [ shoppingVC.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-5.0],
        [shoppingVC.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-50]
    ]];
}
@end
