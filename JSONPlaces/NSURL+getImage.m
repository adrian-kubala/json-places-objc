//
//  NSURL+getImage.m
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import "NSURL+getImage.h"
@import AFNetworking;

@implementation NSURL (getImage)

- (void) getImage:(void (^)(UIImage *))completion {
  UIImageView *imageView = [[UIImageView alloc] init];
  [imageView setImageWithURL:self];
  
  completion(imageView.image);
}

@end
