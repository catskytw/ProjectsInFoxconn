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
/**
 由外部取得查詢之NSDictionary
 */
-(BOOL)prepareDicWithDictionary:(NSDictionary*)outsideDic;
/**
 由urlString去server查詢JSON結果,並存為NSDictionary
 */
-(BOOL)prepareDic:(NSString*)urlString;
/**
 將JSON Value與某個ui元件作valueBinding
 */
-(BOOL)valueBinding:(id)uiComponents withKey:(NSString *)key withIndexArray:(NSUInteger)index;
/**
 將JSON Value與多個ui元件作valueBinding
 */
-(BOOL)valueBindings:(NSArray*)uiComponents withKey:(NSString*)key withIndexArray:(NSArray*)indexs;
/**
 取得某個JSON Value
 @param:key,該JSON Key值
 @param:index,符合該key值之第幾個
 */
-(NSString*)getValue:(NSString*)key withIndex:(NSUInteger)index;
/**
 取得原生JSON 字串結果
 @param:urlString
 */
-(id)getJSONRawResult:(NSString*)urlString;
/**
 將網路上圖片與ui結合,async傳輸
 @param:urlString
 @param:該ui元件,目前支援UIImageView,UIButton
 @param:若有指定notification,可於此指定
 */
-(void)getImageData:(NSString*)urlString withUIComponent:(id)uiComponent withNotificationName:(NSString*)notificationName;
/**
 符合該JSON key的個數
 @param:JSON Key
 */
-(NSInteger)getNumberForKey:(NSString*)key;
/**
 於某個node下,符合該JSON key個數
 @param:nodeName
 @param:JSON key
 */
-(NSInteger)getNumberUnderNode:(NSString*)nodeName withKey:(NSString*)key;
/**
 於某個node下,取得符合該JSON key之value
 @param:nodeName
 @param:JSON key
 @index:第幾個
 */
-(NSString*)getValueUnderNode:(NSString*)nodeName withKey:(NSString*)key withIndex:(NSUInteger)index;
/**
 取得資料結構,可能是NSDictionary或NSArray
 @param:nodeName
 @param:第幾個
 */
-(id)getObjectUnderNode:(NSString*)nodeName withIndex:(NSInteger)index;
//You shouldn't invoke these methods below.
-(id)objectWithUrl:(NSURL *)url;
-(NSString *)stringWithUrl:(NSURL *)url;
-(void)uiValueBinding:(id)uiComponent withValue:(NSString*)value;
@end
