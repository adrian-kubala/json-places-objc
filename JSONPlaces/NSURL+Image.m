//
//  NSURL+Image.m
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import "NSURL+Image.h"
#import "SDWebImage/SDWebImageDownloader.h"

@implementation NSURL (Image)

- (void) getImage:(void (^)(UIImage *))completion {
  [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:self options:SDWebImageDownloaderHighPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
    completion(image);
  }];
}

@end
