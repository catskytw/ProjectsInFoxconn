//
//  MyfavoriteRootViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyfavoriteRootViewController.h"
#import "Vars.h"
#import "MyFavoriteTableCell.h"
#import "MyFavoriteBusObject.h"
#import "MyfavoritePListTool.h"
#import "ModifiedDirectoryNameViewController.h"
#import "AddDirectoryNameViewController.h"
#import "Tools.h"
#import "MyFavoriteModel.h"
#import "DirectoryObject.h"
#import "MyFavoriteDetailTable.h"
#import "MyFavoriteBusDetail.h"
@implementation MyfavoriteRootViewController
@synthesize myScrollView;
@synthesize myFavoriteTable;
@synthesize thisCategoryQueryType;
@synthesize categoryLabel;
//禁止繼承
- (id)initWithCategory:(NSInteger)categoryQueryType {
    if (self = [super init]) {
        // Custom initialization
		//MyFavorite.plist
		
		myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 66)];
		myScrollView.delegate=self;
		isEdit=NO;
		thisCategoryQueryType=categoryQueryType;
		[myFavoriteTable beginUpdates];
    }
    return self;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.title=AMLocalizedString(@"MyFavorite",nil);
	self.navigationItem.rightBarButtonItem=BARBUTTON(AMLocalizedString(@"Edit",nil),@selector(deleteData:));
	
	[self scrollViewSettingUp:thisCategoryQueryType];
	[self.navigationController.navigationBar setTintColor:DefaultTintNavigationButtonColor];
	
	
	[self reloadTableDic:thisCategoryQueryType];
	[self.myFavoriteTable reloadData];
}
- (void)dealloc {
	[myFavoriteTable endUpdates];
	[myScrollView release];
    [super dealloc];
}

#pragma mark 判斷程式

-(void)reloadTableDic:(NSInteger)queryType{
	dirArray=[MyFavoriteModel getFavoriteFolderList:queryType];
	[dirArray retain];
}

-(void)scrollViewSettingUp:(NSInteger)categoryType{
	lastClickButton=nil;
	
	int trafficQueryType[]={busQuery,parkingQuery};
	int lifeQueryType[]={govermentQuery,financeQuery,educationQuery,enterTainmentQuery,accommodationQuery,transportationQuery};
	NSMutableArray *allButton=[[NSMutableArray arrayWithObjects:nil]retain];
	
	myScrollView.frame=CGRectMake(0, 0, 320, 66);
	myScrollView.bounces=YES;
	NSMutableArray *picName;
	
	//判斷scrollView該有哪些按鍵
	if(categoryType==busQuery||categoryType==parkingQuery)
		picName=[NSMutableArray arrayWithObjects:
				 @"favoriteui_tabic_bus",
				 @"favoriteui_tabic_park",
				 nil];
	else
		picName=[NSMutableArray arrayWithObjects:
				 @"favoriteui_tabic_government",
				 @"favoriteui_tabic_banking",
				 @"favoriteui_tabic_education",
				 @"favoriteui_tabic_hobby",
				 @"favoriteui_tabic_food",
				 @"favoriteui_tabic_transit",
				 nil];
	
	//建立所有按鍵
	int count=0;
	for(NSString *thisPicName in picName){
		CustomUIButton *thisButton=[CustomUIButton buttonWithType:UIButtonTypeCustom];
		thisButton.originPicName=[NSString stringWithFormat:@"%@.png",thisPicName];
		thisButton.clickPicName=[NSString stringWithFormat:@"%@_i.png",thisPicName];
		thisButton.frame=CGRectMake(60*count+5*count, 3, 60, 60);
		[thisButton setImage:[UIImage imageNamed:thisButton.originPicName] forState:UIControlStateNormal];
		[thisButton addTarget:self action:@selector(scrollButtonAction:) forControlEvents:UIControlEventTouchDown];
		//給予該button一個query的參數
		thisButton.queryType=(categoryType==busQuery||categoryType==parkingQuery)?trafficQueryType[count]:lifeQueryType[count];
		
		if(thisButton.queryType==thisCategoryQueryType){
			[thisButton setImage:[UIImage imageNamed:thisButton.clickPicName] forState:UIControlStateNormal];
			lastClickButton=thisButton;
		}
		count++;
		[allButton addObject:thisButton];
	}
	
	//處理每個button的屬性

	//CGRect contextRect=CGRectMake(0, 0,[allButton count]*(60+4), 66);
	int totalLength=([allButton count]*(60+4) < 321)? 321: [allButton count]*(60+4);
	CGRect contextRect=CGRectMake(0, 0, totalLength, 66);
	UIView *content=[[[UIView alloc]initWithFrame:contextRect]autorelease];	
	for(UIButton *thisButton in allButton)
		[content addSubview:thisButton];
	content.userInteractionEnabled=YES;
	[myScrollView addSubview:content];
	myScrollView.contentSize=contextRect.size;
	myScrollView.scrollEnabled=YES;
	myScrollView.userInteractionEnabled=YES;
	[self.view addSubview:myScrollView];	
	
	[categoryLabel setText: [MyFavoriteModel getCategoryName:categoryType]];
	
	[allButton release];
}
#pragma mark -
#pragma mark ButtonAction
-(void)addLeftNavigationButton{
	UIButton *myAddButton=[UIButton buttonWithType:UIButtonTypeCustom];
	myAddButton.frame=CGRectMake(0,0,34,30);
	[myAddButton setBackgroundImage:[UIImage imageNamed:@"trafficui_ic_add_folder.png"] forState:UIControlStateNormal];
	[myAddButton setBackgroundImage:[UIImage imageNamed:@"trafficui_ic_add_folder_i.png"] forState:UIControlStateHighlighted];
	[myAddButton addTarget:self action:@selector(addData:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *leftButton=[[[UIBarButtonItem alloc]initWithCustomView:myAddButton]autorelease];
	self.navigationItem.leftBarButtonItem=leftButton;
}
-(void)addData:(id)sender{
	NSLog(@"addData!");
	isEdit=NO;
	[myFavoriteTable setEditing:isEdit];
	self.navigationItem.leftBarButtonItem=nil;
	AddDirectoryNameViewController *adnvc=[[AddDirectoryNameViewController alloc]initWithFavType:thisCategoryQueryType];
	[self.navigationController pushViewController:adnvc animated:YES];
	[adnvc release];
}
-(void)deleteData:(id)sender{
	if(isEdit==NO){
		[myFavoriteTable setEditing:YES animated:YES];
		[self addLeftNavigationButton];
		self.navigationItem.rightBarButtonItem=BARBUTTON(AMLocalizedString(@"End",nil),@selector(deleteData:));
		isEdit=YES;
	}else{
		[myFavoriteTable setEditing:NO animated:YES];
		self.navigationItem.leftBarButtonItem=nil;
		self.navigationItem.rightBarButtonItem=BARBUTTON(AMLocalizedString(@"Edit",nil),@selector(deleteData:));
		isEdit=NO;
	}
}
-(void)scrollButtonAction:(id)sender{
	if(lastClickButton!=nil){
		[lastClickButton setImage:[UIImage imageNamed:lastClickButton.originPicName] forState:UIControlStateNormal];
	}
	CustomUIButton *thisButton=(CustomUIButton*)sender;
	[thisButton setImage:[UIImage imageNamed:thisButton.clickPicName] forState:UIControlStateNormal];
	lastClickButton=thisButton;
	//判斷是否回上一頁
	if([self isKindOfClass:[MyFavoriteDetailTable class]]){
		MyfavoriteRootViewController *preViewController=(MyfavoriteRootViewController*)[Tools lastSecondUIViewController:self.navigationController];
		preViewController.thisCategoryQueryType=thisButton.queryType;
		[self.navigationController popViewControllerAnimated:YES];
	}else{	
		//查詢種類參數
		thisCategoryQueryType=thisButton.queryType;
		[self reloadTableDic:thisCategoryQueryType];
		[myFavoriteTable reloadData];
	}
	[categoryLabel setText: [MyFavoriteModel getCategoryName:thisCategoryQueryType]];
}
#pragma mark -
#pragma mark DelegateMethod
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	DirectoryObject *thisDataObject=(DirectoryObject*)[dirArray objectAtIndex:[indexPath row]];
	if(myFavoriteTable.editing==YES){
		
		ModifiedDirectoryNameViewController *mdnvc=[[ModifiedDirectoryNameViewController alloc]initWithFavType:thisCategoryQueryType];
		mdnvc.originKeyString=[NSString stringWithString:thisDataObject.folderId];
		mdnvc.folderName=[NSString stringWithString:thisDataObject.folderName];
		[self.navigationController pushViewController:mdnvc animated:YES];
		[mdnvc release];
	}
	else{
		MyFavoriteDetailTable *mfdt=[[MyFavoriteModel chooseFavoriteDetailViewController:thisCategoryQueryType withDataObject:thisDataObject]retain];
		[self.navigationController pushViewController:mfdt animated:YES];
		[mfdt release];
	}
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [dirArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	MyFavoriteTableCell *thisCell=(MyFavoriteTableCell*)[tableView dequeueReusableCellWithIdentifier:@"MyFavoriteTableCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"MyFavoriteTableCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[MyFavoriteTableCell class]]){
				thisCell=(MyFavoriteTableCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];

	}
	int myIndex=[indexPath row];
	DirectoryObject *thisCellDataObject=(DirectoryObject*)[dirArray objectAtIndex:myIndex];
	
	//內定之textLabel用來儲存真正的folderName
	[thisCell.textLabel setText:thisCellDataObject.folderId];
	[thisCell.textLabel setTextColor:[UIColor clearColor]];
	[thisCell.textLabel setHidden:YES];
	[thisCell.myFavoriteTableCellLabel setText:[NSString stringWithFormat:@"%@ (%@)",thisCellDataObject.folderName,thisCellDataObject.itemCount]];
	return thisCell;
}

-(BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath{
	return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	int row=[indexPath row];
	DirectoryObject *thisSelectedData=(DirectoryObject*)[dirArray objectAtIndex:row];
	[MyFavoriteModel deleteFavoriteFolder:thisSelectedData.folderId];
	
	[self reloadTableDic:thisCategoryQueryType];
	[myFavoriteTable reloadData];
}
#pragma mark -
@end
