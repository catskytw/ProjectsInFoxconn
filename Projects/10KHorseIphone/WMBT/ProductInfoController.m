//
//  ProductInfoController.m
//  WMBT
//
//  Created by link on 2011/4/1.
//  Copyright 2011年 Foxconn. All rights reserved.
//

#import "ProductInfoController.h"
#import "Configure.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "NinePatch.h"
#import "ColorPickerView.h"
#import "ColorDataObject.h"
#import "ShoppingListController.h"
#import "MainMenuViewController.h"
#import "FcUIView.h"
#import "Tools.h"
#import <QuartzCore/QuartzCore.h>
@implementation ProductInfoController
@synthesize colorFrameView;
@synthesize mainController,imgProduct,lblName,imgScore,lblPrice,lblBrand,lblMemberPrice,lblMemberPriceLable,sID,picker,colorView,btnCart,btnColor,contentScrollView,pageController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        colorDic = [[NSMutableDictionary dictionaryWithObjects:nil forKeys:nil]retain];
        colorArray = [[NSMutableArray new]retain];
        self.navigationItem.title = AMLocalizedString(@"productInfo_title",nil);
        shoppingCartDao = [[ShoppingCartCellDataObject new]retain]; 
    }
    return self;
}

- (void)dealloc
{
    [btnCart release];
    [shoppingCartDao release];
    if(colorArray)
        [colorArray release];
    [colorFrameView release];
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
    contentScrollView.delegate=self;
    // Do any additional setup after loading the view from its nib.
    NSLog(@"ProductInfo_Price %@",AMLocalizedString(@"ProductInfo_Price",nil));
    lblPriceLable.text = AMLocalizedString(@"ProductInfo_Price",nil) ;
    [btnColor setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(105,30) forNinePatchNamed:@"contentui_btn_commons_push"] forState:UIControlStateNormal];
    [btnColor setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(105,30) forNinePatchNamed:@"contentui_btn_commons_push_i"] forState:UIControlStateHighlighted];
    [btnCart setBackgroundImage:[UIImage imageNamed:@"contentui_icon_add_to_cart"] forState:UIControlStateNormal];
    [btnCart setBackgroundImage:[UIImage imageNamed:@"contentui_icon_add_to_cart_i"] forState:UIControlStateHighlighted];
    lblName.textColor = [UIColor colorWithRed:(float)134/255.0f green:(float)84/255.0f blue:(float)34/255.0f alpha:1]; 
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];

    [self loadProductData];
}

- (void)viewDidUnload
{
    [btnCart release];
    btnCart = nil;
    [self setColorFrameView:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)loadProductData{
    btnColor.hidden = YES;
    colorView.hidden = YES;
    colorFrameView.hidden = YES;
    
	QueryPattern *mProductQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
	[mProductQuery prepareDic:searchProductDetailInfo(sID)];
    NSLog(@"searchProductDetailInfo %@",searchProductDetailInfo(sID));
    @try {
        float fPrice=0.0;
        if ([mProductQuery getNumberForKey:@"id"]>0) {
            [mProductQuery uiValueBinding:imgProduct withValue:picUrl([mProductQuery getValue:@"image110" withIndex:0])];
            [imgProduct.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
            [imgProduct.layer setBorderWidth: 1.0];
            lblName.text = [mProductQuery getValue:@"productName" withIndex:0];
            fPrice = [[mProductQuery getValue:@"retailPrice" withIndex:0] floatValue];
            lblPrice.text = [Tools getMoneyString:[mProductQuery getValue:@"retailPrice" withIndex:0]];
            lblBrand.text = [mProductQuery getValue:@"brand" withIndex:0];
            [self setScore:[[mProductQuery getValue:@"score" withIndex:0] floatValue]];
            [self constructContentSubView:mProductQuery];
            if(colorArray==nil)
                colorArray=[[NSMutableArray array]retain];
            else {
                [colorArray removeAllObjects];
            }
            NSString *colorDefault = @"#00dd00";
            if ([mProductQuery getNumberForKey:@"colorList"]>1&& ([mProductQuery getNumberUnderNode:@"colorList" withKey:@"id"]== [mProductQuery getNumberUnderNode:@"colorList" withKey:@"color"])) {
                
                for(int i=0;i<[mProductQuery getNumberUnderNode:@"colorList" withKey:@"id"];i++){
#ifdef TEST_MODE
                    ColorDataObject *colorDo= [ColorDataObject new];
                    colorDo.colorId =[mProductQuery getValueUnderNode:@"colorList" withKey:@"id" withIndex:i];
                    colorDo.Name =[mProductQuery getValueUnderNode:@"colorList" withKey:@"Name" withIndex:i];
                    colorDo.colorRGB =[mProductQuery getValueUnderNode:@"colorList" withKey:@"color" withIndex:i];
                    if (!colorDo.colorRGB || [colorDo.colorRGB length]<7) {
                        colorDo.colorRGB=@"#000000";
                    }
                    [colorArray addObject:colorDo];
                    [colorDo release];
#else
                    ColorDataObject *colorDo= [ColorDataObject new];
                    colorDo.colorId =[mProductQuery getValueUnderNode:@"colorList" withKey:@"id" withIndex:i];
                    colorDo.Name =[mProductQuery getValueUnderNode:@"colorList" withKey:@"Name" withIndex:i];
                    colorDo.colorRGB =[mProductQuery getValueUnderNode:@"colorList" withKey:@"color" withIndex:i];
                    if (!colorDo.colorRGB || [colorDo.colorRGB length]<7) {
                        colorDo.colorRGB=@"#0000gg";
                    }
                    [colorArray addObject:colorDo];
                    [colorDo release];
#endif                
                }
                colorDefault =[mProductQuery getValueUnderNode:@"colorList" withKey:@"color" withIndex:0];
                NSString *colorDefaultName =[mProductQuery getValueUnderNode:@"colorList" withKey:@"Name" withIndex:0];
                
                if (!colorDefault|| [colorDefault length]<7) {
                    colorDefault=@"#00dd00";
                }
                [colorView setBackgroundColor:[UITuneLayout colorWithHexString:colorDefault]];
                //test
#ifdef TEST_MODE
                ColorDataObject *colorDo= [ColorDataObject new];
                colorDo.colorId =@"FB2DCD2B74354999B9D6996ABC17DA2E";
                colorDo.Name =@"藍色";
                colorDo.colorRGB =@"#ff000d";
                [colorArray addObject:colorDo];
                
                ColorDataObject *colorDo1= [ColorDataObject new];
                colorDo1.colorId =@"E7D90A55EB7743C8B395E1579FC3F844";
                colorDo1.Name =@"綠色";
                colorDo1.colorRGB =@"#40ff00";
                [colorArray addObject:colorDo1];
                
                ColorDataObject *colorDo2= [ColorDataObject new];
                colorDo2.colorId =@"C0819249318A4254804D8C29202D77DD";
                colorDo2.Name =@"紫色";
                colorDo2.colorRGB =@"#0e3443";
                [colorArray addObject:colorDo2];
                
                [colorDo release];
                [colorDo1 release];
                [colorDo2 release];
                [colorView setBackgroundColor:[UITuneLayout colorWithHexString:@"#ff0000"]];
#endif
                shoppingCartDao.productName = lblName.text;
                shoppingCartDao.productId =sID;
                shoppingCartDao.price = fPrice;
                shoppingCartDao.quantity = 1;
                shoppingCartDao.imgUrl = [mProductQuery getValue:@"image110" withIndex:0];
                shoppingCartDao.dlImg.imgURLString = picUrl([mProductQuery getValue:@"image46" withIndex:0]);
                if (!colorDefaultName) {
                    colorDefaultName =@"";
                }
                shoppingCartDao.color = colorDefaultName;
                
                //add your image as a subview of the button's view
                //[btnColor addSubview:colorView];
                btnColor.hidden = NO;
                colorView.hidden = NO;
                colorFrameView.hidden = NO;
            }
            else
            {
                btnColor.hidden = YES;
                colorView.hidden = YES;
                colorFrameView.hidden = YES;
            }
            shoppingCartDao.productName = lblName.text;
            shoppingCartDao.productId =sID;
            shoppingCartDao.price = fPrice;
            shoppingCartDao.quantity = 1;
            shoppingCartDao.imgUrl = [mProductQuery getValue:@"image110" withIndex:0];
            shoppingCartDao.dlImg.imgURLString = picUrl([mProductQuery getValue:@"image46" withIndex:0]);
        }

    }
    @catch (NSException * e) {
        NPLogException(e);
    }
    @finally {
        [mProductQuery release];
    }
        
	
}


// takes 0x123456
- (UIColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}
// takes @"#123456"
- (UIColor *)colorWithHexString:(NSString *)str {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [self colorWithHex:x];
}
-(NSMutableString*) getspecList:(QueryPattern*)qP{
    int cnt = [qP getNumberUnderNode:@"specList" withKey:@"name"];
    NSMutableString* sReturn = [[NSMutableString alloc] init];
    for (int i = 0; i<cnt; i++) {
        [sReturn appendFormat:@"%@",[qP getValueUnderNode:@"specList" withKey:@"name" withIndex:i]];
        [sReturn appendFormat:@"%@",[qP getValueUnderNode:@"specList" withKey:@"value" withIndex:i]];
    }
    return [sReturn autorelease];
}
-(void)setScore:(CGFloat)ratingScore{
	int xSpace=10;
	NSString *picName;
	for(int i=0;i<5;i++){
		if(ratingScore>=1)
			picName=@"content_ui_star_on.png";
		else if(ratingScore>0 && ratingScore<1){
			picName=@"content_ui_star_half.png";
		}else {
			picName=@"content_ui_star_off.png";
		}
		
		UIImageView *star=[[UIImageView alloc]initWithImage:[UIImage imageNamed:picName]];
		//The rating ice must be 15x15
		[star setFrame:CGRectMake(i*(xSpace+2), 0, 13, 11)];
		[imgScore addSubview:star];
		[star release];
		ratingScore--;
	}
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [colorArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	ColorDataObject* colorDo = [colorArray objectAtIndex:row];
	NSString * sColor = colorDo.Name;
	
	return sColor;
    
}

- (IBAction)togglePicker:(id) button {

	if(picker.hidden && [colorArray count]>1){
		
		picker.hidden = NO;
        
         [self.view addSubview:picker];
		[picker reloadAllComponents];
		return;
	}
    
}

- (IBAction)addToShoppingCart:(id)sender {
    
    [ShoppingCartCellDataObject setProcessData:shoppingCartDao];
    
   self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
    [self.navigationController popViewControllerAnimated:NO];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    ColorDataObject* colorDo = [colorArray objectAtIndex:row];
    ColorPickerView *colorpv =(ColorPickerView *)[[[NSBundle mainBundle] loadNibNamed:@"ColorPickerView" owner:self options:nil] objectAtIndex:0];
    [colorpv setColor:colorDo.colorRGB andTitle:colorDo.Name];
	
	return colorpv;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //NSLog(@"selected color %@", [colorArray objectAtIndex:row]);
    picker.hidden = YES;
    ColorDataObject* colorDo = [colorArray objectAtIndex:row];
	NSString * sNewId = colorDo.colorId;
    if (![sNewId isEqualToString:sID]) {
        sID = sNewId;
        [self loadProductData];
    }
    
}
-(void)constructContentSubView:(QueryPattern*)query{
    int contentWidth=296;
    int index=0;
    [self.contentScrollView removeAllSubViews];
    for (int i=0; i<4; i++) {
        NSString *_r=[self contentString:index
                        withQueryPattern:query];
        if([_r isEqualToString:@"-"]) continue;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(contentWidth*index+7, 0, 280, 12)];
        switch (i) {
            case 0:
                titleLabel.text =AMLocalizedString(@"ProductDescription", nil);
                break;
            case 1:
                titleLabel.text =AMLocalizedString(@"ProductSpec", nil);
                break;
            case 2:
                titleLabel.text =AMLocalizedString(@"ProductAccessory", nil);
                break;
            case 3:
                titleLabel.text =AMLocalizedString(@"ProductService", nil);
                break;
            default:
                titleLabel.text =AMLocalizedString(@"ProductDescription", nil);
                break;
        }
        [titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:14.0]];
        titleLabel.textColor = [UIColor colorWithRed:134/255.f green:84/255.f blue:34/255.f alpha:1];
        UITextView *thisContentView=[[UITextView alloc]initWithFrame:CGRectMake(contentWidth*index, 12, 294, 156)];
        [thisContentView setText:_r];
        [thisContentView setBackgroundColor:[UIColor clearColor]];
        thisContentView.editable = NO;
        [thisContentView setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:13.0]];
        [contentScrollView addSubview:titleLabel];
        [contentScrollView addSubview:thisContentView];
        [thisContentView release];
        [titleLabel release];
        index++;
    }
    [contentScrollView setContentSize:CGSizeMake(index*contentWidth, 166)];
    pageController.numberOfPages=index;
    pageController.currentPage=0;
}
-(NSString*)contentString:(NSInteger)index withQueryPattern:(QueryPattern*)query{
    NSMutableString *contentString;
    contentString=(NSMutableString*)@"";
    switch (index) {
        case 0:
            contentString=(NSMutableString*)[query getValue:@"description" withIndex:0];
            break;
        case 1:
            contentString=[NSMutableString string];
            NSInteger count=[query getNumberUnderNode:@"specList" withKey:@"name"];
            for(int i=0;i<count;i++){
                [contentString appendFormat:@"%@ %@\n",[query getValueUnderNode:@"specList" withKey:@"name" withIndex:i],[query getValueUnderNode:@"specList" withKey:@"value" withIndex:i]];
            }
            break;
        case 2:
            contentString=(NSMutableString*)[query getValue:@"accessories" withIndex:0];
            break;
        case 3:
            contentString=(NSMutableString*)[query getValue:@"service" withIndex:0];;
            break;
    }
    
    return contentString ;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}
// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate==YES)
        pageControlUsed=YES;
    else
        [self changePage:nil];
}
- (IBAction)changePage:(id)sender{
    [contentScrollView scrollRectToVisible:CGRectMake(296*pageController.currentPage, 0, 296, 166) animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        [self changePage:nil];
        return;
    }
    CGFloat pageWidth = contentScrollView.frame.size.width;
    int page = floor((contentScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageController.currentPage = page;
}


@end
