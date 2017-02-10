//
//  Place.h
//  JSONPlaces
//
//  Created by Adrian Kubała on 10.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Place : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) CLLocation *location;
@property (nonatomic) UIImage *pinImage;
@property (nonatomic) double distance;

-(instancetype)initWithName:(NSString *) name withLatitude:(double) latitude withLongitude:(double) longitude withPinImage:(UIImage *) pinImage withDistance:(double) distance;

@end
