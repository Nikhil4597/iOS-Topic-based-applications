//
//  ImageDownloader.m
//  Mini Shopping
//
//  Created by ROHIT MISHRA on 18/04/23.
//

#import "ImageDownloader.h"

@implementation ImageDownloader


- (void)downloadImagesFromURL:(nonnull NSURL *)url completion:(nonnull ImagesDownloadCompletionBlock)completion {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (error) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        NSData *imageData = [NSData dataWithContentsOfURL:location];
        UIImage *image = [self reduceImageSize:imageData];
        
        if (completion) {
            completion(image, nil);
        }
    }];
    [task resume];
}

/*
 * Reduce image size by 100x100
 */
- (UIImage *)reduceImageSize:(NSData * )imageData {
    CGSize targetSize = CGSizeMake(100, 100);
    UIImage *originalImage = [UIImage imageWithData:imageData];
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0);
    [originalImage drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return scaledImage;
}
@end
