//
//  NSURL+Image.h
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSURL (Image)

- (void)getImage:(void (^ _Nonnull)(UIImage * _Nullable))completion;

@end
