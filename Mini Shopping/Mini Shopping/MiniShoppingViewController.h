//
//  MiniShoppingViewController.h
//  Mini Shopping
//
//  Created by ROHIT MISHRA on 15/04/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MiniShoppingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView * miniShoppingTableView;
@end

NS_ASSUME_NONNULL_END
