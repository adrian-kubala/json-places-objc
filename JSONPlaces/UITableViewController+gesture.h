//
//  UITableViewController+gesture.h
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewController (gesture)

- (void) addLongPressGestureRecognizerWithSelector:(nonnull SEL)selector;

@end
