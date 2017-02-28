//
//  PlacesViewController.m
//  JSONPlaces
//
//  Created by Adrian Kubała on 13.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import "PlacesViewController.h"
#import "JSONParser.h"
#import "NSURL+Image.h"
#import "UIImage+Resizing.h"
#import "Place.h"
#import "PlaceView.h"
#import "CLLocation+Distance.h"
#import "NearbyPlacesViewController.h"

@interface PlacesViewController ()

@end

@implementation PlacesViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setupArrays];
  [self setupParser];
}

- (void)setupParser {
  NSURL *jsonURL = [[NSURL alloc] initWithString:@"http://pastebin.com/raw/dTYu3jmN"];
  
  JSONParser *jsonParser = [[JSONParser alloc] initWithURL:jsonURL];
  [jsonParser fetch:^(NSArray *result, NSError *error) {
    if (error) {
      NSLog(@"%@", error.localizedDescription);
      return;
    }
    
    if (result) {
      [self fillPlacesWithJSON:result];
    }
  }];
}

- (void)setupArrays {
  self.places = [[NSMutableArray alloc] init];
  self.matchedPlaces = [[NSMutableArray alloc] init];
}

- (void)fillPlacesWithJSON:(NSArray *)jsonArray {
  for (NSDictionary *object in jsonArray) {
    NSString *name = object[@"name"];
    NSURL *imageURL = [[NSURL alloc] initWithString:object[@"pin_url"]];
    
    NSDictionary *coordinate = [[NSDictionary alloc] initWithDictionary:object[@"coordinate"]];
    double lat = [[coordinate objectForKey:@"latitude"] doubleValue];
    double lon = [[coordinate objectForKey:@"longitude"] doubleValue];
    
    [imageURL getImage:^(UIImage * image) {
      [image resizeWithNewWidth:30 completion:^(UIImage * scaledImage) {
        
        Place *place = [[Place alloc] initWithName:name latitude:lat longitude:lon pinImage:scaledImage];
        [self.places addObject:place];
        
        [self.tableView reloadData];
      }];
    }];
  }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.places.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  PlaceView *cell = (PlaceView *) [tableView dequeueReusableCellWithIdentifier:@"PlaceView" forIndexPath:indexPath];
  
  Place *place = self.places[indexPath.row];
  cell.label.text = place.name;
  cell.pinImageView.image = place.pinImage;
  
  return cell;
}

# pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.matchedPlaces removeAllObjects];
  
  Place *place = self.places[indexPath.row];
  CLLocation *location = place.location;
  [self getAllDistancesFrom:location atCellRow:indexPath.row];
  
  [self performSegueWithIdentifier:@"ShowNearbyPlaces" sender:self];
  
}

- (void)getAllDistancesFrom:(CLLocation *)location atCellRow:(NSInteger)cellRow {
  for (Place *place in self.places) {
    NSUInteger i = [self.places indexOfObject:place];
    
    if (i == cellRow) {
      continue;
    }
    
    CLLocation * otherLocation = place.location;
    double distance = [location distanceInKmTo:otherLocation];
    
    if (distance <= 2) {
      Place *matchedPlace = place;
      matchedPlace.distance = distance;
      [self.matchedPlaces addObject:matchedPlace];
    }
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NearbyPlacesViewController *nearbyPlacesViewController = (NearbyPlacesViewController *) segue.destinationViewController;
  nearbyPlacesViewController.nearbyPlaces = [[NSMutableArray alloc] initWithArray:self.matchedPlaces];
}

@end
