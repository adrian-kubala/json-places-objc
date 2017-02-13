//
//  PlacesViewController.m
//  JSONPlaces
//
//  Created by Adrian Kubała on 13.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import "PlacesViewController.h"
#import "JSONParser.h"
#import "NSURL+getImage.h"
#import "UIImage+resize.h"
#import "Place.h"
#import "PlaceView.h"

@interface PlacesViewController ()

@end

@implementation PlacesViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
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


@end
