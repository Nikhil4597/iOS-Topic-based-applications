//
//  ViewController.h
//  Mini Shopping
//
//  Created by ROHIT MISHRA on 16/04/23.
//

#import <UIKit/UIKit.h>
#import "MiniShoppingView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController<NSUserActivityDelegate>
@property (nonatomic,strong) MiniShoppingView * shoppingView;
@property (nonatomic,strong) UISlider * slider;
@end

NS_ASSUME_NONNULL_END
