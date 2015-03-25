//
//  CompareView.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/5/25.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "CompareView.h"
#import "FcProductButtonView1.h"
#import "Configure.h"
#import "QueryPattern.h"
#import "CompareObject.h"
#import "UIViewClearSubViews.h"

@implementation CompareView
@synthesize itemView1,itemView2,itemView3,itemView4,itemText1,itemText2,itemText3,itemText4,itemBtn1,itemBtn2,itemBtn3,itemBtn4,contentView;
@synthesize itemImageView1,itemImageView2,itemImageView3,itemImageView4;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dataArray=[[NSMutableArray arrayWithCapacity:4]retain];
        [dataArray addObjectsFromArray:[NSArray arrayWithObjects:[NSNull null],[NSNull null],[NSNull null],[NSNull null],nil]];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)removeItem1:(id)sender{
    [dataArray replaceObjectAtIndex:0 withObject:[NSNull null]];
    [itemText1 setText:@""];
    [itemView1 clearSubViews];
    FcProductButtonView1 *hideFrameView=(FcProductButtonView1*)[viewsArray objectAtIndex:0];
    if((NSNull*)hideFrameView!=[NSNull null])
        hideFrameView.frame.hidden=YES;
    [viewsArray replaceObjectAtIndex:0 withObject:[NSNull null]];
}
-(IBAction)removeItem2:(id)sender{
    [dataArray replaceObjectAtIndex:1 withObject:[NSNull null]];
    [itemText2 setText:@""];
    [itemView2 clearSubViews];
    FcProductButtonView1 *hideFrameView=(FcProductButtonView1*)[viewsArray objectAtIndex:1];
    if((NSNull*)hideFrameView!=[NSNull null])
        hideFrameView.frame.hidden=YES;
    [viewsArray replaceObjectAtIndex:1 withObject:[NSNull null]];
}
-(IBAction)removeItem3:(id)sender{
    [dataArray replaceObjectAtIndex:2 withObject:[NSNull null]];
    [itemText3 setText:@""];
    [itemView3 clearSubViews];
    FcProductButtonView1 *hideFrameView=(FcProductButtonView1*)[viewsArray objectAtIndex:2];
    if((NSNull*)hideFrameView!=[NSNull null])
        hideFrameView.frame.hidden=YES;
    [viewsArray replaceObjectAtIndex:2 withObject:[NSNull null]];
}
-(IBAction)removeItem4:(id)sender{
    [dataArray replaceObjectAtIndex:3 withObject:[NSNull null]];
    [itemText4 setText:@""];
    [itemView4 clearSubViews];
    FcProductButtonView1 *hideFrameView=(FcProductButtonView1*)[viewsArray objectAtIndex:3];
    if((NSNull*)hideFrameView!=[NSNull null])
        hideFrameView.frame.hidden=YES;
    [viewsArray replaceObjectAtIndex:3 withObject:[NSNull null]];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [itemImageView1 setImage:ninepatch(CGSizeMake(130, 180), @"frame_compare")];
    [itemImageView2 setImage:ninepatch(CGSizeMake(130, 180), @"frame_compare")];
    [itemImageView3 setImage:ninepatch(CGSizeMake(130, 180), @"frame_compare")];
    [itemImageView4 setImage:ninepatch(CGSizeMake(130, 180), @"frame_compare")];
    
    viewsArray=[[NSMutableArray arrayWithObjects:[NSNull null],[NSNull null],[NSNull null],[NSNull null], nil]retain];
    textArray=[[NSArray arrayWithObjects:itemText1,itemText2,itemText3,itemText4, nil]retain];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [viewsArray release];
    [textArray release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


-(IBAction)shiftViewPosition{
    [[NSNotificationCenter defaultCenter]postNotificationName:ShiftComparePanel object:self userInfo:nil];
}
-(void)refreshComparePanel:(NSInteger)numof{
    //clear all interface content
    UIView *buttonView;
    UITextView *textView;
    switch (numof) {
        case 0:
            buttonView=itemView1;
            textView=itemText1;
            break;
        case 1:
            buttonView=itemView2;
            textView=itemText2;
            break;
        case 2:
            buttonView=itemView3;
            textView=itemText3;
            break;
        case 3:
            buttonView=itemView4;
            textView=itemText4;
            break;
        default:
            break;
    }
    [buttonView clearSubViews];
    textView.text=@"";
    
    
    id tmpObject=[dataArray objectAtIndex:numof];
    if(tmpObject==[NSNull null])
        return;
    
    QueryPattern *tmpQuery=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
    CompareObject *thisObject=(CompareObject*)tmpObject;
    
    FcProductButtonView1 *thisView=[FcProductButtonView1 new];
    [thisView.view setFrame:CGRectMake(0, 0, 128, 178)];
    [thisView.name setText:thisObject.productName];
    [thisView.actionButton.titleLabel setText:thisObject.productId];
    [thisView.brand setText:thisObject.brand];
    [tmpQuery getImageData:thisObject.picURL withUIComponent:thisView.picture withNotificationName:nil];
    [thisView.price setText:[Tools formatMoneyString:thisObject.price]];
    [thisView tuneLayout];
    
    [buttonView addSubview:thisView.view];
    [textView setText:thisObject.description];
    textView.scrollsToTop=YES;
    [thisView release];
    [tmpQuery release];
     
}
-(void)addCompareProduct:(NSNotification*)notification{
    NSInteger num=0;
    BOOL isFind=NO;
    for(id o in dataArray){
        if (o==[NSNull null]) {
            isFind=YES;
            break;
        }
        num++;
    }
    if(!isFind) return;
    NSDictionary *tmpDic=(NSDictionary*)notification.userInfo;
    NSString *productId=(NSString*)[tmpDic valueForKey:@"ProductId"];
    FcProductButtonView1 *thisView=(FcProductButtonView1*)[tmpDic valueForKey:@"FcProductButtonView"];
    QueryPattern *query=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
    [query prepareDic:searchProductDetailInfo(productId)];
    CompareObject *dataObject=[CompareObject new];
    dataObject.brand=[NSString stringWithString:[query getValue:@"brand" withIndex:0]];
    dataObject.productId=[NSString stringWithString:productId];
    dataObject.productName=[NSString stringWithString:[query getValue:@"productName" withIndex:0]];
    dataObject.price=[NSString stringWithString:[query getValue:@"retailPrice" withIndex:0]];
    dataObject.picURL=picUrl([query getValue:@"image110" withIndex:0]);
    dataObject.description=@"";
    NSInteger numOfDes=[query getNumberUnderNode:@"specList" withKey:@"name"];
    for(int i=0;i<numOfDes;i++){
        dataObject.description=[dataObject.description stringByAppendingFormat:@"%@ %@%@",[query getValueUnderNode:@"specList" withKey:@"name" withIndex:i],[query getValueUnderNode:@"specList" withKey:@"value" withIndex:i],@"\n"];
    }
    [dataArray replaceObjectAtIndex:num withObject:dataObject];
    //[dataObject autorelease];
    [self refreshComparePanel:num];
    
    thisView.frame.hidden=NO;
    [viewsArray replaceObjectAtIndex:num withObject:thisView];
    [query release];
}
@end
