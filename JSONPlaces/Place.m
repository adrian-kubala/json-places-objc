//
//  Place.m
//  JSONPlaces
//
//  Created by Adrian Kubała on 10.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import "Place.h"

@implementation Place

- (instancetype)initWithName:(NSString *)name latitude:(double)latitude longitude:(double)longitude pinImage:(UIImage *)pinImage distance:(double)distance {
  self = [super init];
  
  if (self) {
    _name = name;
    _location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    _pinImage = pinImage;
    _distance = distance;
  }
  
  return self;
}

@end
