//
//  NearbyPlacesViewController.m
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import "NearbyPlacesViewController.h"
#import "UITableViewController+Gestures.h"
#import "PlaceView.h"
#import "Place.h"
#import "PlaceViewController.h"

@implementation NearbyPlacesViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self addLongPressGestureRecognizerWithSelector:@selector(showPlaceDetails:)];
}

# pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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

- (void)showPlaceDetails:(UIGestureRecognizer *)recognizer {
  if (recognizer.state == UIGestureRecognizerStateBegan) {
    CGPoint pressLocation = [recognizer locationInView:self.tableView];
    NSIndexPath *pressedIndexPath = [self.tableView indexPathForRowAtPoint:pressLocation];
    
    Place *place = self.nearbyPlaces[pressedIndexPath.row];
    CLLocation *location = place.location;
    CLLocationDegrees latitude = location.coordinate.latitude;
    CLLocationDegrees longitude = location.coordinate.longitude;
    double distance = place.distance;
    
    NSString *message = [NSString stringWithFormat:@"Szerokość: %f\nDługość: %f\nOdległość: %.2f km", latitude, longitude, distance];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Współrzędne" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:true completion:nil];
  }
}

@end
