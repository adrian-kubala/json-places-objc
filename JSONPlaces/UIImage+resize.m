//
//  UIImage+resize.m
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import "UIImage+resize.h"

@implementation UIImage (resize)

- (void)resizeWithNewWidth:(CGFloat)newWidth completion:(void (^)(UIImage *))completion {
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_async(queue, ^{
    
    CGFloat scale = newWidth / self.size.width;
    CGFloat newHeight = self.size.height * scale;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [self drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
      completion(newImage);
    });
  });
}

@end
