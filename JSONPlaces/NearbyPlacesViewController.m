//
//  NearbyPlacesViewController.m
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import "NearbyPlacesViewController.h"
#import "UITableViewController+gesture.h"
#import "PlaceView.h"
#import "Place.h"
#import "PlaceViewController.h"

@interface NearbyPlacesViewController ()

@end

@implementation NearbyPlacesViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
//  self addLongPressGestureRecognizerWithSelector:
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.nearbyPlaces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  PlaceView *cell = (PlaceView *) [self.tableView dequeueReusableCellWithIdentifier:@"NearbyPlaceView" forIndexPath:indexPath];
  
  
  Place *place = self.nearbyPlaces[indexPath.row];
  cell.pinImageView.image = place.pinImage;
  cell.label.text = place.name;
  
  return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  PlaceViewController *placeViewController = (PlaceViewController *) segue.destinationViewController;
  UITableViewCell *cell = (UITableViewCell *) sender;
  long row = [self.tableView indexPathForCell:cell].row;
  placeViewController.place = self.nearbyPlaces[row];
}

@end
