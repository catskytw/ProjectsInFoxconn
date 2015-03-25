//
//  ExhibitorListFromMap_viewController.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ExhibitorListFromMap_viewController.h"
#import "MapViewController.h"
#import "FeatureCtrlCollections.h"
#import "FcConfig.h"
#import "ExhibitorListDataObject.h"
@implementation ExhibitorListFromMap_viewController
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ExhibitorListDataObject *dao= [filteredArray objectAtIndex:indexPath.row];
    MapDAO *mapdao=[MapDAO new];
    LocationInfoObject *thisLocation=[mapdao getLocationFromExhibitorId:dao.exhibitorId];
    [[FeatureCtrlCollections current] loadMapData:[thisLocation.mapId intValue]];
    NSArray *viewControllers=self.navigationController.viewControllers;
    MapViewController *mapViewController=(MapViewController*)[viewControllers  objectAtIndex:([viewControllers count]-2)];
    [mapViewController settingFloor:[thisLocation.mapId intValue]];
    [mapViewController showExhibitorInfo:thisLocation.locationId isFacility:NO];
    [self.navigationController popViewControllerAnimated:YES];
    [mapdao release];
}

@end
