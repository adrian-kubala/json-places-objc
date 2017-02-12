//
//  NSURL+getImage.h
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSURL (getImage)

- (void)getImage:(void (^)(UIImage *))completion;

@end
