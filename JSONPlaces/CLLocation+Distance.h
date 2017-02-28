//
//  CLLocation+Distance.h
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (Distance)

- (double)distanceInKmTo:(nonnull CLLocation *)location;

@end
