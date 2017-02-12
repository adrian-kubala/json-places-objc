//
//  JSONParser.h
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONParser : NSObject

@property (nonatomic) NSURL *url;

- (instancetype)initWithURL:(NSURL *)url;

@end
