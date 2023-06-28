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
    UIViewController * shoppingVC;
}

#pragma viewController lifeCycle
- (instancetype)init {
    self = [super init];
    if(self){
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // init mini shopping view controller.
    shoppingVC = [[MiniShoppingViewController alloc]init];

    self.shoppingView = [[MiniShoppingView alloc] initWithFrame:CGRectZero];
    [self configureUpperView];
    [self configTableVC];
}

#pragma private method
- (void)configureUpperView {
    [self.shoppingView.categorySortBtn addTarget:shoppingVC action:@selector(categoryTappedCalled) forControlEvents:UIControlEventTouchUpInside];
    [self.shoppingView.priceSortBtn addTarget:shoppingVC action:@selector(priceTappedCalled) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.shoppingView];
    [self configureUpperViewContraint];
}

- (void)configTableVC {
    [self addChildViewController:shoppingVC];
    [self.view addSubview:shoppingVC.view];
    
    [self configTableViewConstraints];
}

- (void)configureUpperViewContraint {
    self.shoppingView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topConstraint = [ self.shoppingView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:10.0];
    
    NSLayoutConstraint *leadingConstraint = [ self.shoppingView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    
    NSLayoutConstraint *trailingConstraint = [ self.shoppingView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    
    NSLayoutConstraint *heightConstraint = [ self.shoppingView.heightAnchor constraintEqualToConstant:180.0];
    
    // Activate the constraints
    NSArray *constraints = @[topConstraint, leadingConstraint, trailingConstraint, heightConstraint];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)configTableViewConstraints {
    shoppingVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topConstraint = [ shoppingVC.view.topAnchor constraintEqualToAnchor:self.shoppingView.bottomAnchor constant:10.0];
    NSLayoutConstraint *leadingConstraint = [ shoppingVC.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10.0];
    NSLayoutConstraint *trailingConstraint = [ shoppingVC.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-5.0];
    NSLayoutConstraint *heightConstraint = [ shoppingVC.view.heightAnchor constraintEqualToConstant:700.0];
    
    // Activate the constraints
    NSArray *constraints = @[topConstraint, leadingConstraint  ,trailingConstraint,heightConstraint];
    [NSLayoutConstraint activateConstraints:constraints];
}
@end
