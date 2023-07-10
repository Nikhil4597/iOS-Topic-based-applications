//
//  MiniShoppingModel.m
//  Mini Shopping
//
//  Created by ROHIT MISHRA on 15/04/23.
//

#import "MiniShoppingDataModel.h"

@implementation MiniShoppingDataModel

- (void)fetchDataWithCompletion:(void (^)(NSDictionary *))completion {
    // Fetch data asynchronously.
    NSURL *url = [NSURL URLWithString:@"https://dummyjson.com/products"];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // Parse the data.
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];

        if (error) {
            NSLog(@"Error fetching data: %@", error.localizedDescription);
            completion(@{});
        }
        
        completion(dataDictionary);
    }];
    [task resume];
}
@end
