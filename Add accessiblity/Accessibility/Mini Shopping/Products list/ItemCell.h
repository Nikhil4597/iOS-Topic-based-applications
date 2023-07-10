//
//  ItemCell.h
//  Mini Shopping
//
//  Created by ROHIT MISHRA on 15/04/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemCell : UITableViewCell
@property (nonatomic,strong) UIImageView * itemImageView;
@property (nonatomic,strong) UILabel * itemTitle;
@property (nonatomic,strong) UILabel * itemRating;
@property (nonatomic,strong) UILabel * itemPrice;
@property (nonatomic,strong) UILabel * itemCategory;
@end

NS_ASSUME_NONNULL_END
