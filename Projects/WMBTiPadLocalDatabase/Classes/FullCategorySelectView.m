//
//  FullCategorySelectView.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FullCategorySelectView.h"
#import "FcTabBarItem.h"
#import "LocalizationSystem.h"
#import "AllCategoryObject.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "MCPBtnView.h"
#import "FcNSArray.h"
#import "FcCatalogTemplate1.h"
#import "LoginView.h"
#import "FcPopWindows.h"
#import "SignInObject.h"
#import "UIImage+Alpha.h"
#import "QuerySQLProcess.h"
#import "NSString+extension.h"
#import "SyncProcess.h"
#import "NinePatch.h"
#define AddTransparentBorderEdge @"AddTransparentBorderEdge"
@interface FullCategorySelectView(PrivateMethod)
-(IBAction)btnPress:(id)sender;
-(void)loadData;
-(void)popLogin;
-(void)loginSuccess:(NSNotification*)notification;
-(void)addTransparentBorderEdge:(NSNotification*)notification;
-(void)setAllCategoryRotatetion;
@end
@implementation FullCategorySelectView
@synthesize navibarTitleLabel;
@synthesize mainCategoryLabel;
@synthesize subCategoryLabel;
@synthesize subTable,cName,syncButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    /*
    for(MCPBtnView *thisCategory in mainCategoryPics){
        [thisCategory release];
    }*/
    [mainCategoryPics release];
    [super dealloc];
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
    [super viewDidLoad];
    mainCategoryPics=nil;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess:) name:SuccessLogin object:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addTransparentBorderEdge:) name:AddTransparentBorderEdge object:nil];
    subCategoryNum=0;
    FcTabBarItem *thisBarItem=[[FcTabBarItem alloc]initWithTitle:AMLocalizedString(@"ProductCatalog",nil) image:[UIImage imageNamed:@"content_ui_underbar_diary.png"] tag:0];
	thisBarItem.customStdImage=[UIImage imageNamed:@"content_ui_underbar_diary.png"];
	thisBarItem.customHighlightedImage=[UIImage imageNamed:@"content_ui_underbar_diary_i.png"];
	self.navigationController.tabBarItem=thisBarItem;
	[thisBarItem release];
	[self.tabBarController setSelectedIndex:0];
    
    [syncButton setBackgroundImage:[TUNinePatchCache imageOfSize:syncButton.frame.size forNinePatchNamed:@"button_normal"]
                forState:UIControlStateNormal];
    [syncButton setBackgroundImage:[TUNinePatchCache imageOfSize:syncButton.frame.size forNinePatchNamed:@"button_active"]
                forState:UIControlStateHighlighted];
    [syncButton setTitle:AMLocalizedString(@"sync", nil) forState:UIControlStateNormal];
  
    navibarTitleLabel.text=AMLocalizedString(@"FullCategory_Title", nil);
    mainCategoryLabel.text=AMLocalizedString(@"MainCategory", nil);
    subCategoryLabel.text=AMLocalizedString(@"SubCategory", nil);
    //建立所有的分類
    [AllCategoryObject share];
    
    [self loadData];
    subTable.delegate=self;
    subTable.dataSource=self;
    if([SignInObject share].isLogin==NO){
        [self popLogin];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    downloadCompletedNum=0;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:SuccessLogin object:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AddTransparentBorderEdge object:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
-(void)loadData{
    if(mainCategoryPics==nil)
        mainCategoryPics=[NSMutableArray new];
    else{
        for(MCPBtnView *emptyView in mainCategoryPics)
            [emptyView removeFromSuperview];
        [mainCategoryPics removeAllObjects];
    }
    QueryPattern *imageQuery=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
    [imageQuery prepareDicWithDictionary:[QuerySQLProcess queryProductType]];
    
    CGPoint positions [7]={
        CGPointMake(145, 199),CGPointMake(160, 420),
        CGPointMake(141, 628),CGPointMake(174, 818),
        CGPointMake(369, 246),CGPointMake(370, 442),
        CGPointMake(371, 714)
    };
    int rotateDegree[7]={
        -6,4,-8,7,8,-1,5  
    };
    for(int i=0;i<7;i++){
        MCPBtnView *thisCategory;
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"MCPBtnView" owner:self options:nil];
        for(id currentObject in  nib){
			if([currentObject isKindOfClass:[MCPBtnView class]]){
                thisCategory=(MCPBtnView*)currentObject;
                break;
            }
        }
        [thisCategory.btn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        //[imageQuery getImageData:picUrl([imageQuery getValue:@"primaryImage" withIndex:i]) withUIComponent:thisCategory.categoryImage withNotificationName:AddTransparentBorderEdge];
        //NSLog(@"%@",[imageQuery getValue:@"primaryImage" withIndex:i]);
        NSString *fileName=[NSString stringWithFormat:@"%@%@",
                            [NSString documentPath],
                            [imageQuery getValue:@"primaryImage" withIndex:i]];
        
        [thisCategory.categoryImage setImage:[[[[UIImage alloc]initWithContentsOfFile:fileName]transparentBorderImage:1] autorelease]];
        [thisCategory.gradientImage setImage:[thisCategory.gradientImage.image transparentBorderImage:1]];
        [thisCategory.btn setTitle:[imageQuery getValue:@"id" withIndex:i] forState:UIControlStateNormal];
        [thisCategory.categoryName setText:[imageQuery getValue:@"name" withIndex:i]];
        CGPoint thisPosition=positions[i];
        [thisCategory setFrame:CGRectMake(thisPosition.x-(CGFloat)195/2, thisPosition.y-(CGFloat)195/2, thisCategory.frame.size.width,thisCategory.frame.size.height)];
        [mainCategoryPics addObject:thisCategory];
        [thisCategory setRotation:rotateDegree[i]];
    }
    //由於不能遮住右下角,因為陣列要反過來貼 
    NSArray *r_Array=[mainCategoryPics reverseArray];
    for(UIView *tmpView in r_Array)
        [self.view addSubview:tmpView];
    [imageQuery release];
}

-(IBAction)btnPress:(id)sender{
    selectedIndex=-1; //任何次選項均不會變色
    NSString *idString=((UIButton*)sender).titleLabel.text;
    for(MCPBtnView *thisView in mainCategoryPics){
        if([idString isEqualToString:thisView.btn.titleLabel.text])
            [thisView.frameImage setImage:[UIImage imageNamed:@"photoframe_choose_big.png"]];
        else
            [thisView.frameImage setImage:[UIImage imageNamed:@"photoframe_big.png"]];
    }
    
    selectedMainCategoryKey=idString;
    NSDictionary *sDic=(NSDictionary*)[[AllCategoryObject share].m_SDic valueForKey:selectedMainCategoryKey];
    subCategoryNum=[[sDic allKeys]count];
    [cName setText:(NSString*)[[AllCategoryObject share].m_MDic valueForKey:selectedMainCategoryKey]];
    
    [subTable reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedIndex=[indexPath row];
    for(int i=0;i<subCategoryNum;i++){
        UITableViewCell *eachCell=[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [eachCell.textLabel setTextColor:(i==selectedIndex)?DefaultOrangeColor:[UIColor blackColor]];
    }
    UITableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    FcCatalogTemplate1 *nextView=[[FcCatalogTemplate1 alloc] init];
    nextView.sCategoryKey=[NSString stringWithString:selectedCell.detailTextLabel.text];
    [self.navigationController pushViewController:nextView animated:YES];
    [nextView autorelease];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return subCategoryNum;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=[indexPath row];
    NSDictionary *subDic=(NSDictionary*)[[AllCategoryObject share].m_SDic valueForKey:selectedMainCategoryKey];
    
    NSString *CellIdentifier = @"FullCategorySelectView";
    UITableViewCell *cell =(UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSString *subKey=(NSString*)[(NSArray*)[subDic allKeys] objectAtIndex:row];
    [cell.textLabel setText:(NSString*)[subDic valueForKey:subKey]];
    [cell.textLabel setFont:[UIFont fontWithName:DefaultFontName size:20.0f]];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    //借用detailTextLabel來存subcategory key
    [cell.detailTextLabel setTextColor:[UIColor clearColor]];
    [cell.detailTextLabel setText:subKey];
    return cell;
}
-(void)popLogin{
    LoginView *_m=[[LoginView alloc]initWithSuccessNotificationKey:SuccessLogin withFailedNotificationKey:nil withObserver:self];
    popWin=[[FcPopWindows alloc]initWithInnerFrame:_m.view.frame.size withPosition:CGPointMake(175,215) withContentViewController:_m withCloseBtnString:nil isAllowedClose:YES];
    [popWin show:self.view];
    [_m autorelease];
}
-(void)loginSuccess:(NSNotification*)notification{
    [popWin close];
    NSLog(@"login success,sessionId:%@",[SignInObject share].sessionId);
    SyncProcess *process=[SyncProcess new];
    [process syncDatabase];
    [process downloadAllPic];
    [process release];
               
    [self loadData];
    /*
    if([[[AllCategoryObject share].m_MDic allKeys]count]==0) //之前讀取失敗
    {
        [AllCategoryObject releaseSingleton];
        [AllCategoryObject share];
        [self loadData];
    }
     */
}
-(void)addTransparentBorderEdge:(NSNotification*)notification{
    downloadCompletedNum++;
    NSDictionary *dic=(NSDictionary*)notification.userInfo;
    UIImageView *thisView=(UIImageView*)[dic valueForKey:@"Component"];
    UIImage *newImage=[thisView.image transparentBorderImage:1];
    [thisView setImage:newImage];
    //if(downloadCompletedNum>6)
        //[self setAllCategoryRotatetion];
    
}
-(void)setAllCategoryRotatetion{
    int count=0;
    int rotateDegree[7]={
        -6,4,-8,7,8,-1,5  
    };
    for(MCPBtnView *thisCategory in mainCategoryPics){
        [thisCategory setRotation:rotateDegree[count]];
        count++;
    }
}

-(IBAction)syncAction{
    NSLog(@"sync....");
    [self popLogin];
}
@end
