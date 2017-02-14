//
//  PlacesViewController.h
//  JSONPlaces
//
//  Created by Adrian Kubała on 13.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlacesViewController : UITableViewController

@property (nonatomic, nonnull) NSMutableArray *places;
@property (nonatomic, nonnull) NSMutableArray *matchedPlaces;

@end
