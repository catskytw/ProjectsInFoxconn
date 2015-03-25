//
//  Tools.m
//  LotteryProject
//
//  Created by 廖 晨志 on 2011/3/3.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "Tools.h"
#import "GameConfig.h"

@implementation Tools
+(NSString*)caculatePriceString:(ParametersObject*)currentParameters{
	NSString *returnString;
	if([currentParameters.ticketOfD count]!=0)
		returnString=[NSString stringWithFormat:@"%@%@",currentParameters.priceName,DClassName];
	else if([currentParameters.ticketOfC count]!=0)
		returnString=[NSString stringWithFormat:@"%@%@",currentParameters.priceName,CClassName];
	else if([currentParameters.ticketOfB count]!=0)
		returnString=[NSString stringWithFormat:@"%@%@",currentParameters.priceName,BClassName];
	else if([currentParameters.ticketOfA count]!=0)
		returnString=[NSString stringWithFormat:@"%@%@",currentParameters.priceName,AClassName];
	else {
		returnString=noneLottery;
	}
	return returnString;
}

+(NSString*)caculateTotalNumberString:(NSDictionary*)dic withParametersObject:(ParametersObject*)currentParameters{
	NSString *returnString;
	if([currentParameters.ticketOfD count]!=0)
		returnString=[NSString stringWithFormat:@"共%d位",[(NSNumber*)[dic valueForKey:@"dTotal"] intValue]];
	else if([currentParameters.ticketOfC count]!=0)
		returnString=[NSString stringWithFormat:@"共%d位",[(NSNumber*)[dic valueForKey:@"cTotal"] intValue]];
	else if([currentParameters.ticketOfB count]!=0)
		returnString=[NSString stringWithFormat:@"共%d位",[(NSNumber*)[dic valueForKey:@"bTotal"] intValue]];
	else if([currentParameters.ticketOfA count]!=0)
		returnString=[NSString stringWithFormat:@"共%d位",[(NSNumber*)[dic valueForKey:@"aTotal"] intValue]];
	else {
		returnString=@"";
	}
	return returnString;
}

/*
+(BOOL)isPresidentPrice:(ParametersObject*)currentParameters{
	BOOL returnResult=NO;
	if([currentParameters.ticketOfD count]!=0)
		returnResult=NO;
	else if([currentParameters.ticketOfC count]!=0)
		returnResult=NO;
	else if([currentParameters.ticketOfB count]!=0)
		returnResult=NO;
	else if([currentParameters.ticketOfA count]!=0)
		returnResult=YES;
	else {
		returnResult=NO;
	}
	return returnResult;
}
 */
@end
