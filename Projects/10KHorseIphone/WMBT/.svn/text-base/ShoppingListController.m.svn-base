//
//  ShoppingListController.m
//  WMBT
//
//  Created by link on 2011/6/6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ShoppingListController.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "ShoppingCartCellDataObject.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"

#import "MainMenuViewController.h"
#import "NinePatch.h"
#import "Tools.h"
#import "StoreDataObject.h"
#import "storePickerView.h"
#import "OrderDtlObject.h"
#import "WMBTWebService.h"
#import "ProductInfoController.h"
#import "LoginDataObject.h"
#import "DownloadImg.h"
@implementation ShoppingListController
@synthesize storePicker;
@synthesize totalLabel;
@synthesize OrderButton;
@synthesize continueShoppingButton;
@synthesize ShoppingListTable;
@synthesize storeButton;
@synthesize currentNavigationController;
@synthesize hideKeyboardButton;
@synthesize imageDownloadsInProgress;
static NSMutableDictionary* ShoppingCartDic=nil;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        shoppingCartArray = [[NSMutableArray arrayWithObjects:nil]retain];	
        storeArray = [[NSMutableArray arrayWithObjects:nil]retain];
        imageDownloadsInProgress = [[NSMutableDictionary alloc]init];	
        self.navigationItem.title = AMLocalizedString(@"shoppingCart_title",nil);
        self.navigationItem.backBarButtonItem.title = AMLocalizedString(@"title_backhome",nil);
        if (ShoppingCartDic ==nil) {
            ShoppingCartDic=[[NSMutableDictionary dictionaryWithObjects:nil forKeys:nil]retain];
        }
        bKeyboardMoveup = NO;
        cellHeight = 65;
        [self getPlistInfo];
        
    }
    return self;
}

- (void)dealloc
{
    [ShoppingListTable release];
    [continueShoppingButton release];
    [OrderButton release];
    if(shoppingCartArray!=nil)
		[shoppingCartArray release];
    [storeButton release];
    [totalLabel release];
    [hideKeyboardButton release];
    [editTableButton release];
    [storePicker release];
    [storeArray release];
    if (imageDownloadsInProgress!=nil) {
        [imageDownloadsInProgress release];
    }
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
    [OrderButton setTitle: AMLocalizedString(@"ShoppingCart_OK",nil)  forState:UIControlStateNormal];
    [continueShoppingButton setTitle: AMLocalizedString(@"ShoppingCart_Continue",nil)  forState:UIControlStateNormal];
    LoginDataObject *lDO = [LoginDataObject sharedInstance];

    [storeButton setTitle:[NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"ShoppingCart_Store", nil),lDO.storeName]  forState:UIControlStateNormal];
    [OrderButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(152,45) forNinePatchNamed:@"contentui_btn_commons_push"] forState:UIControlStateNormal];
    [OrderButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(152,45) forNinePatchNamed:@"contentui_btn_commons_push_i"] forState:UIControlStateHighlighted];
    [continueShoppingButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(152,45) forNinePatchNamed:@"contentui_btn_commons_push"] forState:UIControlStateNormal];
    [continueShoppingButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(152,45) forNinePatchNamed:@"contentui_btn_commons_push_i"] forState:UIControlStateHighlighted];
    [storeButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(308,45) forNinePatchNamed:@"contentui_btn_commons_push"] forState:UIControlStateNormal];
    [storeButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(308,45) forNinePatchNamed:@"contentui_btn_commons_push_i"] forState:UIControlStateHighlighted];

    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
    hideKeyboardButton.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wsReturn:) name:webserviceNotif object:nil];
    [self addEditTableButton];
    
    [self processData];
    [self updateTotal];
    //[self loadStoreData];
    //
    //[self writePlist];
    //[self readPlist];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [self processData];
    [self updateTotal];
    [ShoppingListTable reloadData];
}
- (void)viewDidUnload
{
    [self setOrderButton:nil];
    [self setContinueShoppingButton:nil];
    [self setShoppingListTable:nil];
    [self setStoreButton:nil];
    [self setTotalLabel:nil];
    [self setHideKeyboardButton:nil];
    [self setStorePicker:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:webserviceNotif object:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self getShoppingListCell:tableView andIndexPath:indexPath];	
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
    return cellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[ShoppingCartDic allKeys]count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
    ProductInfoController *productInfoController = [[ProductInfoController alloc] initWithNibName:@"ProductInfoController" bundle:nil];
   ShoppingCartCellDataObject *cellDO = [ShoppingCartDic valueForKey:[[ShoppingCartDic allKeys] objectAtIndex:indexPath.row]] ;
	productInfoController.sID = cellDO.productId;
	[self.navigationController  pushViewController:productInfoController animated:YES];
    [productInfoController release];
    
}
- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath{
	
	if(editingStyle == UITableViewCellEditingStyleDelete){
        //NSLog(@"key :%@", [[ShoppingCartDic allKeys] objectAtIndex:indexPath.row]);
        [ShoppingCartDic removeObjectForKey:[[ShoppingCartDic allKeys] objectAtIndex:indexPath.row]];
		[ShoppingListTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBadgeValue" object:nil userInfo:ShoppingCartDic];
        [self updateTotal];
	}
}
-(UITableViewCell *)getShoppingListCell:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
	
    ShoppingCartTableCell *cell = (ShoppingCartTableCell*)[tableView dequeueReusableCellWithIdentifier:@"ShoppingCartTableCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ShoppingCartTableCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
	}
    cellHeight = cell.frame.size.height;
    //NSLog(@"key :%@", [[ShoppingCartDic allKeys] objectAtIndex:indexPath.row]);
    ShoppingCartCellDataObject *cellDO = [[ShoppingCartDic valueForKey:[[ShoppingCartDic allKeys] objectAtIndex:indexPath.row]] retain];
    //[cell.productImg setImage:[UIImage imageNamed:@"no_photo46.png"]];
    [cell setInfoDO:cellDO];
    cell.unitTextField.delegate =self;
    //tableViewImageDownload *imgDowmloader = [imageDownloadsInProgress objectForKey:indexPath];
    //if (imgDowmloader != nil)
    {
        //ShoppingCartTableCell *cellDl = (ShoppingCartTableCell*) [ShoppingListTable cellForRowAtIndexPath:imgDowmloader.indexPathInTableView];
        //ShoppingCartCellDataObject *cellDO = (ShoppingCartCellDataObject*)[shoppingCartArray objectAtIndex:indexPath.row];
        tableViewImageDownload *imgDowmloader = [imageDownloadsInProgress objectForKey:indexPath];
        if (!imgDowmloader.bLoaded)
        {
            if (ShoppingListTable.dragging == NO && ShoppingListTable.decelerating == NO)
            {
                [self startImgDownload:cellDO.dlImg forIndexPath:indexPath];
            }
            // if a download is deferred or in progress, return a placeholder image
            [cell.productImg setImage:[UIImage imageNamed:@"no_photo46.png"]];                
        }
        else
        {
            cell.productImg.image = imgDowmloader.downloadImg.img;
        }
    }

    [cellDO release];
	return cell;
}

-(void)addEditTableButton{
    editTableButton = [[UIBarButtonItem alloc]initWithTitle:AMLocalizedString(@"tableVeiew_edit", nil) style:UIBarButtonSystemItemEdit target:self action:@selector(editTable)];
    self.navigationItem.rightBarButtonItem = editTableButton;
    
}


-(IBAction)editTable{
    
    if([editTableButton.title isEqualToString:AMLocalizedString(@"tableVeiew_edit", nil)] == YES){
        [editTableButton setTitle:AMLocalizedString(@"tableVeiew_done", nil)];
        [ShoppingListTable setEditing:YES animated:YES];
    }
    else {
        [editTableButton setTitle:AMLocalizedString(@"tableVeiew_edit", nil)];
        [ShoppingListTable setEditing:NO animated:YES];
    }
    
   
}
-(void)processData{
    [imageDownloadsInProgress removeAllObjects];
    ShoppingCartCellDataObject *data = [ShoppingCartCellDataObject getProcessData];
    if (data!=nil) {
        ShoppingCartCellDataObject* daoInDic = [ShoppingCartDic valueForKey:data.productId];
        if (daoInDic !=nil) {
            data.quantity = data.quantity + daoInDic.quantity;   
        }
        //data.dlImg.imgURLString = picUrl(data.imgUrl);
        [ShoppingCartDic setValue:data forKey:data.productId];
    }
    [ShoppingCartCellDataObject cleanProcessData];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBadgeValue" object:nil userInfo:ShoppingCartDic];
}
-(void)updateTotal{
    Float32 fTotal=0;
    for (ShoppingCartCellDataObject* dao in [ShoppingCartDic allValues]) {
        fTotal += dao.quantity *dao.price;
    }
    totalLabel.text = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"shoppingCart_Total", nil),[Tools getMoneyStringF32:fTotal]];
}
- (IBAction)hideKeyboard:(id)sender {
    [currentTextField resignFirstResponder];
    hideKeyboardButton.hidden = YES;
    if (bKeyboardMoveup)
    {
        [self setViewMovedUp:NO]; 
    }
        
}
-(void)addToCart:(ShoppingCartCellDataObject*)cellDO{

    ShoppingCartCellDataObject* daoInDic = (ShoppingCartCellDataObject*)[ShoppingCartDic valueForKey:cellDO.productId];
    if (daoInDic !=nil) {
        cellDO.quantity = cellDO.quantity + daoInDic.quantity;   
       [ShoppingCartDic setValue:cellDO forKey:cellDO.productId];
    }
    [ShoppingCartDic setValue:cellDO forKey:cellDO.productId];

}

- (IBAction)continueShopping:(id)sender {
    //[self writePlist];
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)chooseStore:(id)sender {
    if(storePicker.hidden && [storeArray count]>1){		
		storePicker.hidden = NO;        
		[storePicker reloadAllComponents];
		return;
	}
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    currentTextField = (ShoppingCartTableCellTextField*)textField;
    ShoppingCartCellDataObject* daoInDic = (ShoppingCartCellDataObject*)[ShoppingCartDic valueForKey:currentTextField.productId];
    if (daoInDic !=nil) {
        daoInDic.quantity = [currentTextField.text intValue];   
    }
    [ShoppingCartDic setValue:daoInDic forKey:daoInDic.productId];
    [ShoppingListTable reloadData];
    [self updateTotal];
    //NSLog(@"textFiled productId:%@ amount  %lu", currentTextField.productId, daoInDic.amount);
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    currentTextField = (ShoppingCartTableCellTextField*)textField;
    hideKeyboardButton.hidden = NO;
    CGPoint p =[currentTextField.superview convertPoint:currentTextField.frame.origin fromView:nil];
    if  (self.view.frame.origin.y >= 0 && p.y<-200)
    {
        [self setViewMovedUp:YES];
    }
    //NSLog(@"textField pos %f %f",p.x,p.y);
}

-(void)getPlistInfo{
    /*
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"shoppingCart.plist"]; //3
    plistPath = path;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: plistPath]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"shoppingCart" ofType:@"plist"]; //5
        [fileManager copyItemAtPath:bundle toPath: plistPath error:&error]; //6
    }
     */
}
-(void)readPlist{
    /*if (ShoppingCartDic!=nil) {
        [ShoppingCartDic release];
    }
    ShoppingCartDic = [[NSMutableDictionary alloc] initWithContentsOfFile: plistPath];
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile: plistPath];
    
    //load from savedStock example int value
    int value;
    value = [[savedStock objectForKey:@"value"] intValue];
    
    [savedStock release];*/
}
-(void)writePlist{
    //[ShoppingCartDic writeToFile:plistPath atomically:YES];
    /*NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: plistPath];
    
    //here add elements to data file and write data to file
    int value = 5;
    
    [data setObject:[NSNumber numberWithInt:value] forKey:@"value"];
    
    [data writeToFile: plistPath atomically:YES];
    [data release];*/
}
- (IBAction)checkOrder:(id)sender{
    if ([[ShoppingCartDic allKeys]count]==0) {
        return;
    }
    OrderDtlObject *o=[OrderDtlObject new];
    NSMutableArray *wsArray=[NSMutableArray arrayWithObjects: nil];
    for (int i= 0; i< [[ShoppingCartDic allKeys]count]; i++) {
        ShoppingCartCellDataObject *cellDO =[ShoppingCartDic valueForKey:[[ShoppingCartDic allKeys] objectAtIndex:i]];
        o.prodId=cellDO.productId;
        o.prodPrice=[[NSString alloc]initWithFormat:@"%f",cellDO.price];
        o.prodQty=[[NSString alloc]initWithFormat:@"%d",cellDO.quantity];
        [wsArray addObject:o];
    }
    
    WMBTWebService *webService=[[WMBTWebService alloc]initWithNotificationName:webserviceNotif withURLPrefix:WebServiceURLPrefix];
    LoginDataObject *lDO = [LoginDataObject sharedInstance];
    if ([lDO.memberType isEqualToString:TYPE_MEMBER]) {
        [Tools addWaitCursor];
#ifdef TEST_WEBSERVICE
        [webService createAdvance:wsArray withCpy:lDO.storeId withMember:@"972960480AA1216501453A298D296B44"];
#else
        [webService createAdvance:wsArray withCpy:lDO.storeId withMember:lDO.memberId];
#endif
    }else{
        NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"order_forbit_title",nil)]; 
        NSString *alertMessage =[NSString stringWithFormat:@"%@", AMLocalizedString(@"order_forbit_msg",nil)]; 
        NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"order_alert_ok", nil)]; 
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
        [alert show];
    }
    [o release];
    [webService release];
}   

-(void)wsReturn:(NSNotification*)notification{
    NSDictionary *dic=notification.userInfo;
    NSLog(@"web service notif %@", (NSString*)[dic valueForKey:@"out"]);
    [Tools delWaitCursor];
    if ([((NSString*)[dic valueForKey:@"out"]) isEqualToString:@"0"]) {
        NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"order_success_alert_title",nil)]; 
        NSString *alertMessage =[NSString stringWithFormat:@"%@", AMLocalizedString(@"order_success_alert_msg",nil)]; 
        NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"order_alert_ok", nil)]; 
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
        [alert show];
        [ShoppingCartDic removeAllObjects];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBadgeValue" object:nil userInfo:ShoppingCartDic];
        [ShoppingListTable reloadData];
        [self updateTotal];
    }else{
        NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"order_fail_alert_title",nil)]; 
        NSString *alertMessage =[NSString stringWithFormat:@"%@", AMLocalizedString(@"order_fail_alert_msg",nil)]; 
        NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"order_alert_ok", nil)]; 
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
        [alert show];
    }

}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [storeArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	StoreDataObject* storeDo = [storeArray objectAtIndex:row];
	NSString * storeName = storeDo.name;
	
	return storeName;
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    StoreDataObject* storeDo = [storeArray objectAtIndex:row];
    storePickerView *storepv =(storePickerView *)[[[NSBundle mainBundle] loadNibNamed:@"storePickerView" owner:self options:nil] objectAtIndex:0];
    [storepv setName:storeDo.name];
	
	return (UIView *)storepv;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //NSLog(@"selected color %@", [colorArray objectAtIndex:row]);
    storePicker.hidden = YES;
    StoreDataObject* storeDo = [storeArray objectAtIndex:row];
    [storeButton setTitle:[NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"ShoppingCart_Store", nil),storeDo.name]  forState:UIControlStateNormal];
    //NSLog(@"selected storeDo %@", storeDo.name);
}
-(void)loadStoreData{
    LoginDataObject *lDO = [LoginDataObject sharedInstance];
    StoreDataObject* storeDo = [StoreDataObject new];
    storeDo.name = lDO.storeName;
    storeDo.storeId = lDO.storeId;
    [storeArray addObject:storeDo];
    
    StoreDataObject* storeDo1 = [StoreDataObject new];
    storeDo1.name = @"上海黃興路店";
    storeDo1.storeId =@"2";
    [storeArray addObject:storeDo1];
    
    StoreDataObject* storeDo2 = [StoreDataObject new];
    storeDo2.name = @"上海甘河店";
    storeDo2.storeId =@"3";
    [storeArray addObject:storeDo2];
    
    StoreDataObject* storeDo3 = [StoreDataObject new];
    storeDo3.name = @"上海大連路店";
    storeDo3.storeId =@"4";
    [storeArray addObject:storeDo3];
    
    StoreDataObject* storeDo4 = [StoreDataObject new];
    storeDo4.name = @"上海曹楊店";
    storeDo4.storeId =@"5";
    [storeArray addObject:storeDo4];
    
    StoreDataObject* storeDo5 = [StoreDataObject new];
    storeDo5.name = @"上海吳江路店";
    storeDo5.storeId =@"6";
    [storeArray addObject:storeDo5];
    
    StoreDataObject* storeDo6 = [StoreDataObject new];
    storeDo6.name = @"上海延長路店";
    storeDo6.storeId =@"7";
    [storeArray addObject:storeDo6];
    
    [storeDo release];
    [storeDo1 release];
    [storeDo2 release];
    [storeDo3 release];
    [storeDo4 release];
    [storeDo5 release];
    [storeDo6 release];
}

+(void)removeallShoppingCart{
    [ShoppingCartDic removeAllObjects];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBadgeValue" object:nil userInfo:ShoppingCartDic];
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp && !bKeyboardMoveup)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD*2.5;
        rect.size.height += kOFFSET_FOR_KEYBOARD*2.5;
        bKeyboardMoveup = YES;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD*2.5;
        rect.size.height -= kOFFSET_FOR_KEYBOARD*2.5;
        bKeyboardMoveup = NO;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)keyboardWillShow:(NSNotification *)notif
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
    
    if ([currentTextField isFirstResponder] && self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (![currentTextField isFirstResponder] && self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}
- (void)keyboardWillHide:(NSNotification *)notif
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
    
    if (!bKeyboardMoveup)
    {
        [self setViewMovedUp:NO];
    }
}
- (void)startImgDownload:(DownloadImg *)downlaodImg forIndexPath:(NSIndexPath *)indexPath
{
    tableViewImageDownload *imgDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (imgDownloader == nil) 
    {
        imgDownloader = [[tableViewImageDownload alloc] init];
        imgDownloader.downloadImg = downlaodImg;
        imgDownloader.indexPathInTableView = indexPath;
        imgDownloader.delegate = self;
        [imageDownloadsInProgress setObject:imgDownloader forKey:indexPath];
        [imgDownloader startDownload];
        [imgDownloader release];   
    }
}

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    if ([ShoppingCartDic count] > 0)
    {
        NSArray *visiblePaths = [ShoppingListTable indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            ShoppingCartCellDataObject *cellDO = [ShoppingCartDic valueForKey:[[ShoppingCartDic allKeys] objectAtIndex:indexPath.row]];
            tableViewImageDownload *imgDowmloader = [imageDownloadsInProgress objectForKey:indexPath];
            if (!imgDowmloader.bLoaded){
                [self startImgDownload:cellDO.dlImg forIndexPath:indexPath];
            }
        }
    }
}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)imageDidLoad:(NSIndexPath *)indexPath
{
    tableViewImageDownload *imgDowmloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (imgDowmloader != nil)
    {
        ShoppingCartTableCell *cell = (ShoppingCartTableCell*) [ShoppingListTable cellForRowAtIndexPath:imgDowmloader.indexPathInTableView];
        
        // Display the newly loaded image
        cell.productImg.image = imgDowmloader.downloadImg.img;
    }
}


#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}


@end
