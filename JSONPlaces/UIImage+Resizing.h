//
//  UIImage+Resizing.h
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resizing)

- (void)resizeWithNewWidth:(CGFloat)newWidth completion:(void (^ _Nonnull)(UIImage * _Nonnull))completion;

@end
 
