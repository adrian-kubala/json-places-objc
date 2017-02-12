//
//  UIImage+resize.h
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (resize)

- (void)resizeWithNewWidth:(CGFloat)newWidth completion:(void (^)(UIImage *))completion;

@end
 
