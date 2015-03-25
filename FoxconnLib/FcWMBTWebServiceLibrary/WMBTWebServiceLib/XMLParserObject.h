//
//  XMLParserObject.h
//  Hello_SOAP
//
//  Created by 廖 晨志 on 2011/6/2.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMLParserObject : NSObject <NSXMLParserDelegate>{
    NSXMLParser *parser;
    NSArray *searchKeys;
    BOOL recordResults;
    NSMutableString *results;
    NSMutableDictionary *rDic;
}
@property(nonatomic,retain)NSMutableDictionary *rDic;
-(id)initWithXMLString:(NSString*)xmlString withSearchKeys:(NSArray*)keys;
@end
