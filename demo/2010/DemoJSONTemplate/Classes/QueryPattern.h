//
//  QueryPattern.h
//  FoxconnQueryLib
//
//  Created by 廖 晨志 on 2010/12/2.
//  Copyright 2010 foxconn. All rights reserved.
//
//	This class is used to fetching datas from JSON structure and binding the value
//	with ui components on the view.
//
//	How to use:
//	1.create an instance of QueryPattern.
//	2.invoke 'prepareDic' with the url, which could reponse the json string, for 
//	  makeing a datastructure in NSDictionary style.
//	3.invoke 'valueBindings'; the key is the attribute-name in json, which's 
//	  attribute-value you accquire for some purposes.
//	4.repeat invoking 'valueBindings' until each UI component is satisfied.
//	5.release the instance.
//
//	Notes:
//	1.In valueBindings method, the object-type in indexs-array should be NSNumber
//	  class.
//	2.In valueBindings method, you coulde give a nil for the parameter 'indexs'.
//	  Let's say:
//
//		valueBindings:uiComponents withKey:yourKey withIndexArray:nil
//
//	  while the indexs is nil, the method will fetch the values from json datastructure
//	  sequencially from index 0.
//	3.In valueBindings method, if you give an index which is out-of-range, 
//	  the return value will give you '-', instead of nil or any exception.
//	4.The supported ui components int valueBindings are: UILabel,UITextFiled,
//	  UITextView,UIImageView,UIButton.
//	
//	  IMPORTANT: 
//	  If the value, binding for an UIButton, is starting with 'http:',
//	  we presume that the value is an image and we will establish an async-download
//	  as the button's background. Otherwise, the value should be used for the 
//	  button's title, for UIControlStatusNormarl.


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QueryPattern : NSObject {
@private
	NSDictionary *jsonDic;
}
-(BOOL)prepareDic:(NSString*)urlString;
-(BOOL)valueBinding:(id)uiComponents withKey:(NSString *)key withIndexArray:(NSUInteger)index;
-(BOOL)valueBindings:(NSArray*)uiComponents withKey:(NSString*)key withIndexArray:(NSArray*)indexs;
-(NSString*)getValue:(NSString*)key withIndex:(NSUInteger)index;
-(id)getJSONRawResult:(NSString*)urlString;
-(void)getImageData:(NSString*)urlString withUIComponent:(id)uiComponent withNotificationName:(NSString*)notificationName;

//You shouldn't invoke these methods below.
-(id)objectWithUrl:(NSURL *)url;
-(NSString *)stringWithUrl:(NSURL *)url;
-(void)uiValueBinding:(id)uiComponent withValue:(NSString*)value;
@end