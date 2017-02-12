//
//  JSONParser.m
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import "JSONParser.h"

@implementation JSONParser

- (instancetype)initWithURL:(NSURL *)url {
  self = [super init];
  
  if (self) {
    _url = url;
  }
  
  return self;
}

- (void)fetch:(void (^)(NSArray *, NSError *))completion {
  NSError *error;
  NSData *data = [NSData dataWithContentsOfURL: self.url];
  NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
  
  completion(json, error);
}

@end
