//
//  Place.h
//  JSONPlaces
//
//  Created by Adrian Kubała on 10.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN
@interface Place : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) CLLocation *location;
@property (nonatomic, nullable) UIImage *pinImage;
@property (nonatomic) double distance;

- (instancetype)initWithName:(NSString *)name latitude:(double)latitude longitude:(double)longitude pinImage:(nullable UIImage *)pinImage;
- (instancetype)initWithName:(NSString *)name latitude:(double)latitude longitude:(double)longitude pinImage:(nullable UIImage *)pinImage distance:(double)distance;

@end
NS_ASSUME_NONNULL_END
