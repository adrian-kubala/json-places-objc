//
//  PlaceViewController.m
//  JSONPlaces
//
//  Created by Adrian Kubała on 12.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

#import "PlaceViewController.h"

@interface PlaceViewController ()

@end

@implementation PlaceViewController

- (void)loadView {
  CLLocationDegrees latitude = self.place.location.coordinate.latitude;
  CLLocationDegrees longitude = self.place.location.coordinate.longitude;
  
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:16];
  GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
  [mapView setMyLocationEnabled:true];
  self.view = mapView;
  
  GMSMarker *marker = [[GMSMarker alloc] init];
  marker.position = CLLocationCoordinate2DMake(latitude, longitude);
  
  marker.title = self.place.name;
  marker.icon = self.place.pinImage;
  marker.map = mapView;
  mapView.selectedMarker = marker;
}


@end
