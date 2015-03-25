//
//  Hello_SOAPViewController.h
//  Hello_SOAP
//
//  Created by Dave McAnall on 11/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Hello_SOAPViewController : UIViewController<NSXMLParserDelegate>
{
	IBOutlet UITextField *nameInput;
	IBOutlet UILabel *greeting;
	NSMutableData *webData;
	NSMutableString *soapResults;
	NSXMLParser *xmlParser;
	BOOL recordResults;
}

@property(nonatomic, retain) IBOutlet UITextField *nameInput;
@property(nonatomic, retain) IBOutlet UILabel *greeting;
@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;

-(IBAction)buttonClick: (id) sender;
-(void)showContent:(NSNotification*)notification;
@end

