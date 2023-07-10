//
//  ImageDownloader.h
//  Mini Shopping
//
//  Created by ROHIT MISHRA on 18/04/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ImagesDownloadCompletionBlock)(UIImage *images, NSError *error);


@interface ImageDownloader : NSObject
- (void)downloadImagesFromURL:(nonnull NSURL *)url completion:(nonnull ImagesDownloadCompletionBlock)completion;
@end

