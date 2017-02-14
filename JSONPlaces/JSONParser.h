//
//  JSONParser.h
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface JSONParser : NSObject

@property (nonatomic) NSURL *url;

- (instancetype)initWithURL:(NSURL *)url;
- (void)fetch:(void (^)( NSArray * _Nullable,  NSError * _Nullable))completion;

@end
NS_ASSUME_NONNULL_END
