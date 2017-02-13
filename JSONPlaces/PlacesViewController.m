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
  return 0;
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
