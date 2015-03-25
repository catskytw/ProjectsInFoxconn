//
//  FcTabUIComponent.m
//  FcTabUIComponent
//
//  Created by 廖 晨志 on 2011/5/17.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcTabUIComponent.h"

@interface FcTabUIComponent (PrivateMethod)
-(void)pressTab:(id)sender;
-(void)SelectTab:(id)sender;
-(BOOL)constructWithTitleStrings;
-(BOOL)constructWithTitleViews;
@end

@implementation FcTabUIComponent
-(id)initWithTabStrings:(NSArray*)titles withRect:(CGRect)rect withContainerViews:(NSArray*)containers{
    if((self=[super init])){
        _titleViews=nil;
        _titleStrings=[[NSArray arrayWithArray:titles] retain];
        _tabViews=[[NSMutableArray arrayWithArray:containers]retain];
        _contentRect=rect;
    }
    return self;
}
-(id)initWithViews:(NSArray*)views withRect:(CGRect)rect withContainerViews:(NSArray*)containers{
    if((self=[super init])){
        _titleStrings=nil;
        _titleViews=[[NSArray arrayWithArray:views]retain];
        _tabViews=[[NSMutableArray arrayWithArray:containers]retain];
        _contentRect=rect;
    }
    return self;
}
- (void)dealloc
{
    [super dealloc];
    if(_titleStrings!=nil)
        [_titleStrings release];
    if(_titleViews!=nil)
        [_titleViews release];
    [_tabViews release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    mainContainer=[[UIView alloc]init];
    _btns=[NSMutableArray new];
    //高度小於20,該元件就不存在
    if (_contentRect.size.height<20) return;
    [self.view setFrame:_contentRect];
    (_titleStrings!=nil)?[self constructWithTitleStrings]:[self constructWithTitleViews];
    
}
-(BOOL)constructWithTitleViews{
    NSInteger startX=0;
    NSInteger tabHeight=0;
    NSInteger tag=0;
    //add title tab
    for (UIView *v in _titleViews) {
        UIButton *thisBtn=[[UIButton buttonWithType:UIButtonTypeCustom]retain];
        [thisBtn setTag:tag];
        CGSize btnSize=v.frame.size;
        [thisBtn setFrame:CGRectMake(startX, 0, btnSize.width, btnSize.height)];
        tabHeight=btnSize.height;
        (startX==0)?[thisBtn setSelected:YES]:[thisBtn setSelected:NO];
        [thisBtn setBackgroundColor:[UIColor clearColor]];
        [thisBtn.titleLabel setBackgroundColor:[UIColor clearColor]];
        [thisBtn setBackgroundImage:[TUNinePatchCache imageOfSize:btnSize forNinePatchNamed:@"tab_selected"] forState:UIControlStateSelected];
        [thisBtn setBackgroundImage:[TUNinePatchCache imageOfSize:btnSize forNinePatchNamed:@"tab_unselected"] forState:UIControlStateNormal];
        [thisBtn setBackgroundImage:[TUNinePatchCache imageOfSize:btnSize forNinePatchNamed:@"tab_press"] forState:UIControlStateHighlighted];
        
        [v setFrame:CGRectMake(0, 0, v.frame.size.width, v.frame.size.height)];
        [thisBtn addSubview:v];
        [thisBtn addTarget:self action:@selector(pressTab:) forControlEvents:UIControlEventTouchDown];
        [thisBtn addTarget:self action:@selector(SelectTab:) forControlEvents:UIControlEventTouchUpInside];
        [_btns addObject:thisBtn];
        [self.view addSubview:thisBtn];
        startX+=btnSize.width;
        tag++;
    }
    
    //add tab line
    CGSize lineSize=CGSizeMake(_contentRect.size.width, 5.0f);
    _lineView=[[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:CGSizeMake(lineSize.width, lineSize.height) forNinePatchNamed:@"tab_selected_bar_right"]];
    [_lineView setFrame:CGRectMake(0, tabHeight-5.0f, _lineView.frame.size.width,_lineView.frame.size.height)];
    NSLog(@"width:%f height:%f",_lineView.frame.size.width,_lineView.frame.size.height);
    [self.view addSubview:_lineView];
    
    //add main container
    [mainContainer setFrame:CGRectMake(0, tabHeight, _contentRect.size.width, _contentRect.size.height-tabHeight)];
    [self.view addSubview:mainContainer];
    selectedIndex=0;
    [mainContainer addSubview:(UIView*)[_tabViews objectAtIndex:selectedIndex]];
    return YES;
}

-(BOOL)constructWithTitleStrings{
    NSInteger startX=0;
    NSInteger tabHeight=0;
    NSInteger tag=0;
    for (NSString *s in _titleStrings) {
        UIButton *thisBtn=[[UIButton buttonWithType:UIButtonTypeCustom]retain];
        [thisBtn setTag:tag];
        CGSize tmpSize=[Tools estimateStringSize:s withFontSize:FontSize];
        CGSize btnSize=CGSizeMake(tmpSize.width+PADDINGSPACE, tmpSize.height+PADDINGSPACE);
        [thisBtn setFrame:CGRectMake(startX, 0, btnSize.width, btnSize.height)];
        tabHeight=btnSize.height;
        (startX==0)?[thisBtn setSelected:YES]:[thisBtn setSelected:NO];
        [thisBtn setBackgroundColor:[UIColor clearColor]];
        [thisBtn.titleLabel setBackgroundColor:[UIColor clearColor]];
        [thisBtn setBackgroundImage:[TUNinePatchCache imageOfSize:btnSize forNinePatchNamed:@"tab_selected"] forState:UIControlStateSelected];
        [thisBtn setBackgroundImage:[TUNinePatchCache imageOfSize:btnSize forNinePatchNamed:@"tab_unselected"] forState:UIControlStateNormal];
        [thisBtn setBackgroundImage:[TUNinePatchCache imageOfSize:btnSize forNinePatchNamed:@"tab_press"] forState:UIControlStateHighlighted];
        [thisBtn setTitle:s forState:UIControlStateNormal];
        [thisBtn.titleLabel setFont:[UIFont fontWithName:DefaultFontName size:FontSize]];
        [thisBtn addTarget:self action:@selector(pressTab:) forControlEvents:UIControlEventTouchDown];
        [thisBtn addTarget:self action:@selector(SelectTab:) forControlEvents:UIControlEventTouchUpInside];
        [_btns addObject:thisBtn];
        [self.view addSubview:thisBtn];
        startX+=btnSize.width;
        tag++;
    }
    
    CGSize lineSize=CGSizeMake(_contentRect.size.width, 5.0f);
    _lineView=[[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:CGSizeMake(lineSize.width, lineSize.height) forNinePatchNamed:@"tab_selected_bar_right"]];
    [_lineView setFrame:CGRectMake(0, tabHeight-5.0f, _lineView.frame.size.width,_lineView.frame.size.height)];
    [self.view addSubview:_lineView];
    
    //add main container
    [mainContainer setFrame:CGRectMake(0, tabHeight, _contentRect.size.width, _contentRect.size.height-tabHeight)];
    [self.view addSubview:mainContainer];
    selectedIndex=0;
    [mainContainer addSubview:(UIView*)[_tabViews objectAtIndex:selectedIndex]];
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [_lineView release];
    for (UIButton *b in _btns) {
        [b release];
    }
    [_btns release];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)pressTab:(id)sender{
    UIButton *senderBtn=(UIButton*)sender;
    [senderBtn setSelected:NO];
    [_lineView setImage:[TUNinePatchCache imageOfSize:CGSizeMake(_lineView.frame.size.width, _lineView.frame.size.height) forNinePatchNamed:@"tab_press_bar_right"]];
}
-(void)SelectTab:(id)sender{
    UIButton *senderBtn=(UIButton*)sender;
    for(UIButton *b in _btns){
        BOOL result=[b.titleLabel.text isEqualToString:senderBtn.titleLabel.text];
        if(result)
            [b setSelected:YES];
        else
            [b setSelected:NO];
    }
    [_lineView setImage:[TUNinePatchCache imageOfSize:CGSizeMake(_lineView.frame.size.width, _lineView.frame.size.height) forNinePatchNamed:@"tab_selected_bar_right"]];
    
    //清除mainContainer裡的views
    for (UIView *subView in mainContainer.subviews) {
        if(subView!=nil)
            [subView removeFromSuperview];
    }
    selectedIndex=senderBtn.tag;
    [mainContainer addSubview:(UIView*)[_tabViews objectAtIndex:selectedIndex]];
}
@end
