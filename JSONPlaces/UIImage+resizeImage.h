//
//  UIImage+resizeImage.h
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (resizeImage)

- (void)resizeImage:(CGFloat)newWidth completion:(void (^)(UIImage *))completion;

@end
 
