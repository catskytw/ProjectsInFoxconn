//
//  AddDirectory	NameViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AddDirectoryNameViewController.h"
#import "MyfavoritePListTool.h"
#import "MyFavoriteModel.h"
#import "LocalizationSystem.h"
@implementation AddDirectoryNameViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"DirectoryNameViewController" bundle:nil]) {
		self.title=AMLocalizedString(@"AddCategory",nil);
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated{
	//uitextfile內不是空白,則建立一個分類
	if([directoryNameTextField.text compare:@""]!=NSOrderedSame){
		//[targetDictionary setObject:tmpArray forKey:directoryNameTextField.text];
		//TODO 錯誤要跳視窗警告
		[MyFavoriteModel createFavoriteFolder:queryType withName:directoryNameTextField.text];
	}	
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[super textFieldShouldReturn:textField];
	[self.navigationController popViewControllerAnimated:YES];
	return YES;
}
@end
