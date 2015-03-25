//
//  ChattingViewController.m
//  iPhoneXMPP
//
//  Created by 廖 晨志 on 2011/6/29.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ChattingViewController.h"
#import "MessageQueue.h"
#import "XMPPMessage.h"
#import "FcNSArray.h"
#import "Tools.h"
#import "ChatingViewCell.h"
@implementation ChattingViewController
@synthesize _contentTable,_messageField,targetJid,targetDisplayName;
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
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.我
}

#pragma mark - View lifecycle
-(void)reloadConversationTable:(NSNotification*)notification{
    [self strangeReload];
}
-(void)strangeReload{
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
    [self performSelectorOnMainThread:@selector(reloadTableData) withObject:nil waitUntilDone:false];
    [pool release];
}
-(void)reloadTableData{
    [_contentTable reloadData];
}
-(void)backView{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.toolbar setHidden:YES];
    backItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backView)];
    self.navigationItem.leftBarButtonItem=backItem;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadConversationTable:) name:@"reloadConversationTable" object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [backItem release];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadConversationTable" object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:textField.text forKey:@"_message"];
    [dic setValue:targetJid forKey:@"_jid"];
    //送出sendMessage
    [[NSNotificationCenter defaultCenter]postNotificationName:@"sendMessageNotification" object:nil userInfo:dic];
    //重新描繪table
    [self strangeReload];
    [textField resignFirstResponder];
    textField.text=@"";
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count:%i",[[MessageQueue share] count]);
    return [[MessageQueue share] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *reverseArray=[[MessageQueue share] reverseArray];
    XMPPMessage *_payload=(XMPPMessage*)[reverseArray objectAtIndex:[indexPath row]];
    NSArray *bodys=[_payload elementsForName:@"body"];
    CGSize rSize=[Tools estimateStringSize:[[bodys objectAtIndex:0]stringValue] withFontSize:18.0f withMaxSize:CGSizeMake(280, 2000000)];
    return rSize.height+40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *reverseArray=[[MessageQueue share] reverseArray];
    XMPPMessage *_payload=(XMPPMessage*)[reverseArray objectAtIndex:[indexPath row]];
    static NSString *CellIdentifier = @"Conversation";
	
	ChatingViewCell *cell = (ChatingViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ChatingViewCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[ChatingViewCell class]]){
                cell=(ChatingViewCell*)currentObject;
                break;
            }
        }

	}
    NSArray *bodys=[_payload elementsForName:@"body"];
    BOOL isSendOut=([[_payload toStr]rangeOfString:targetDisplayName].length<=0)?YES:NO;
    CGSize rSize=[Tools estimateStringSize:[[bodys objectAtIndex:0]stringValue] withFontSize:18.0f withMaxSize:CGSizeMake(280, 2000000)];
    [cell.content setFrame:CGRectMake(cell.content.frame.origin.x, cell.content.frame.origin.y, rSize.width, rSize.height+10)];
    [cell.content setTextColor:[UIColor blackColor]];
    [cell.content setText:[[bodys objectAtIndex:0]stringValue]];
    [cell.content setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:18.0f]];
    NSString *name=[NSString stringWithFormat:@"%@:",(isSendOut)?self.navigationItem.title:@"我"];
    [cell.name setText:name];
    
    [cell.name setTextColor:(isSendOut)?[UIColor grayColor]:[UIColor blueColor]];
    [cell.content setTextColor:(isSendOut)?[UIColor grayColor]:[UIColor blueColor]];
    return cell;
}
@end
