//
//  Place.m
//  JSONPlaces
//
//  Created by Adrian Kubała on 10.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import "Place.h"

@implementation Place

- (instancetype)initWithName:(NSString *)name latitude:(double)latitude longitude:(double)longitude pinImage:(UIImage *)pinImage {
  self = [super init];
  
  if (self) {
    _name = name;
    _location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    _pinImage = pinImage;
  }
  
  return self;
}

- (instancetype)initWithName:(NSString *)name latitude:(double)latitude longitude:(double)longitude pinImage:(UIImage *)pinImage distance:(double)distance {
  self = [self initWithName:name latitude:latitude longitude:longitude pinImage:pinImage];
  
  if (self) {
    _distance = distance;
  }
  
  return self;
}

@end
