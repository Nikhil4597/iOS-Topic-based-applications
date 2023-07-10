//
//  MiniShoppingModel.h
//  Mini Shopping
//
//  Created by ROHIT MISHRA on 15/04/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MiniShoppingDataModel : NSObject
- (void)fetchDataWithCompletion:(void (^)(NSDictionary *))completion;
@end

NS_ASSUME_NONNULL_END
