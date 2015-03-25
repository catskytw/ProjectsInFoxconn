//
//  FloorSelectionViewController.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FloorSelectionViewController.h"
#import "PSListByDateTableViewCell.h"
#import "LocalizationSystem.h"
#import "MapViewController.h"
#import "UITuneLayout.h"
#import "NinePatch.h"
#import "FcConfig.h"
#define cellHeight 45
@interface FloorSelectionViewController(PrivateMethod)
-(void)customBackNavigationBar;
@end

@implementation FloorSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"PersonalScheduleListViewController" bundle:nibBundleOrNil];
    if (self) {
        floorStrings=[[NSArray arrayWithObjects:
                      AMLocalizedString(@"A_floor2", nil), 
                      AMLocalizedString(@"A_floor3", nil),
                      AMLocalizedString(@"B_floor1", nil),
                      AMLocalizedString(@"B_floor2", nil),
                      nil] retain];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self setTitle:AMLocalizedString(@"floorPlan", nil)];
    [UITuneLayout setNaviTitle:self];
    [[self navigationController]setNavigationBarHidden:NO];
}

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)leftItemAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    [floorStrings release];
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	//NSLog("numberOfRowsInSection: %i",[[mCategoryDic allKeys]count]);
    return [floorStrings count];
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PSListByDateTableViewCell *cell = (PSListByDateTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PSListByDateTableViewCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PSListByDateTableViewCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        
	}
    [cell setUIDefault];
    cell.contentLabel.text = [floorStrings objectAtIndex:[indexPath row]];    
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row=[indexPath row];
    FeatureCtrlCollections *featureCtrl=[FeatureCtrlCollections current];
    MapViewController *map=[MapViewController current];
    [map cleanShortestPathItem];
    //讀取不同圖資
    switch (row) {
        case 0:
            [featureCtrl loadMapData:A_2F];
            [map settingFloor:A_2F];
            break;
        case 1:
            [featureCtrl loadMapData:A_3F];
            [map settingFloor:A_3F];
            break;
        case 2:
            [featureCtrl loadMapData:B_1F];
            [map settingFloor:B_1F];
            break;
        case 3:
            [featureCtrl loadMapData:B_2F];
            [map settingFloor:B_2F];
            break;
    }
    [map setBackItem:self.title];
    [map setRightItem:AMLocalizedString(@"exhibitorSearch", nil)];
    [self.navigationController pushViewController:map animated:YES];
}

@end
