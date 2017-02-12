//
//  UITableViewController+gesture.m
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import "UITableViewController+gesture.h"

@implementation UITableViewController (gesture)

-(void)addLongPressGestureRecognizer:(SEL)selector {
  UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:selector];
  [self.tableView addGestureRecognizer:recognizer];
}

@end
