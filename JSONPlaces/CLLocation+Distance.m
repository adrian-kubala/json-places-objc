//
//  CLLocation+Distance.m
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import "CLLocation+Distance.h"

@implementation CLLocation (Distance)

- (double)distanceInKmTo:(CLLocation *)location {
  double distance = [location distanceFromLocation:self] / 1000;
  return distance;
}

@end
