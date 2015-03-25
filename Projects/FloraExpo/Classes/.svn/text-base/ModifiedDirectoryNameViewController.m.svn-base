//
//  ModifiedDirectoryNameViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModifiedDirectoryNameViewController.h"
#import "MyFavoriteModel.h"
#import "LocalizationSystem.h"
@implementation ModifiedDirectoryNameViewController
@synthesize folderName;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"DirectoryNameViewController" bundle:nil]) {
		self.title=AMLocalizedString(@"FixFileName",nil);
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[directoryNameTextField setText:folderName];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	//若欄位為空
	if([textField.text compare:@""]==NSOrderedSame || [textField.text compare:originKeyString]==NSOrderedSame){
		//TODO 跳出視窗,欄位不可為空
		[textField setText:folderName];
	}
	else{
		NSLog(@"%@",textField.text);
		//TODO edit
		[MyFavoriteModel editFavoriteFolder:originKeyString withDirName:textField.text];
		[self.navigationController popViewControllerAnimated:YES];
	}
	[super textFieldShouldReturn:textField];
	return YES;
}
@end
