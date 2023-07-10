//
//  MiniShoppingViewController.h
//  Mini Shopping
//
//  Created by ROHIT MISHRA on 15/04/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MiniShoppingDataProtocol <NSObject>

- (void)shoppingViewController:(UIViewController *)viewController didUpdateData:(NSString* )value;

@end

@interface MiniShoppingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * miniShoppingTableView;
@property (nonatomic, weak) id<MiniShoppingDataProtocol> delegate;
@end

NS_ASSUME_NONNULL_END
