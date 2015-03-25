//
//  FloraExpoDescriptionController.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FloraExpoDescriptionController.h"
#import "DescriptionObject.h"
#import "Vars.h"

@implementation FloraExpoDescriptionController

/**
 deprecated!
 取得描述頁面之內容
 */
-(NSMutableArray*)getDescriptionDataArray:(NSString*)key{
	BOOL isTitle=YES;
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:
								 nil
								 ];
	NSMutableArray *dataArray;
	switch ([key intValue]) {
		case 0:
			dataArray=[NSMutableArray arrayWithObjects:
					   @"花博濃濃東洋味　日本華道國寶大師來台獻藝",
					   @"【大台灣旅遊網TTNews記者林信宏】\n由臺北市政府主辦的「2010臺北國際花卉博覽會」將於花博寰宇庭園及爭艷館綻放台灣花卉園藝實力。花博爭艷館在六個月的展期中，將有16檔展覽規劃，其中具有神秘東洋色彩的「爭艷館東洋花藝大賞」邀請到日本最古老的華道流派「池坊」來台展覽。「池坊」現任領導人專永家元於2010年6月18日專程來到臺北市花木批發市場為年底展覽暖身宣傳，現場除了展出華道家元池坊共十四件大小型插花作品，並與臺北市副市長林建元一同將最後的花束插入作品中，並交換紀念品，代表「2010臺北國際花卉博覽會」與日本池坊合作的象徵意義。身為第四十五代池坊專永家元表示，池坊在日本已經有五百五十年的歷史，明年2月的「爭艷館東洋花藝大賞」當中，大家可以欣賞到池坊華(花)道五百多年來歷史傳承的精髓。雖然花不能保存，但池坊的花藝精神將在每位來賓心中留下永恆的記憶。臺北市林副市長表示，臺北市能舉辦國際級的大型博覽會是非常難得的一件事，民眾來花博不單單只是觀賞花卉而已，更重要的是其中的藝術涵養。非常感謝日本池坊專永家元來台舉辦比賽，不但增加花博內涵的藝術養分，更增加花博的吸引力，展現「2010臺北國際花卉博覽會」美麗的力量。「爭艷館東洋花藝大賞」將於明年2011年2月19日展開，屆時將會有超過300名來自日本全國各大城市的華道家元池坊會員齊聚台灣。值得一提的是，由池坊提案的兩大主題區：池坊感恩ECO.-Ecology Friendly及遊心之花。將帶領民眾體會生活中華道的樂趣，不需費心思考，只要將華道的精神落實在日常生活及環保意識中，信手捻來、俯拾皆是趣味，花卉的表現將會更加貼近人心。\n（圖／花博營運總部提供）\n大台北旅遊網http://taipei.tranews.com/",
					   nil];
			break;
		case 1://花博源由
			dataArray=[NSMutableArray arrayWithObjects:
					   @"國際上申請認証之博覽會有兩大系統",
					   @"國際上需申請認證之博覽會有兩大系統，一為國際展覽局（BIE），二為國際園藝生產者協會(AIPH)。AIPH目前有33個會員機構，分屬於25個國家，經AIPH認證之國際園藝博覽會，為國際上最高級別的園藝專業型博覽會，展現主辦國之花卉產業、文化成就與科技成果。本府協同臺灣區花卉發展協會於95年4月，義大利熱內亞舉辦之國際園藝生產者協會(AIPH)春季會議，提出申辦2010年A2/B1級國際花卉博覽會之意願，由於臺灣花卉在國際上頗負盛名，經審查後大會一致通過申請提案，並於2006年11月正式發函，審查通過2010臺北國際花卉博覽會之申辦。「2010臺北國際花卉博覽會」是臺灣第一次正式獲得國際授權舉辦，也是亞洲第7個城市經AIPH正式授權舉辦的國際園藝博覽會。初步預估辦理「2010臺北國際花卉博覽會」將有國內外約600萬觀光人次參與，不僅對內促進本市觀光產業發展、國內花卉產業成長，更可對外促進國際交流，提升我國國際形象。",
					   nil];
			break;
		case 2://參觀時間
			dataArray=[NSMutableArray arrayWithObjects:
					   @"試營運期",
					   @"預計於2010年10月期間會進行試營運",
					   @"營運期",
					   @"2010年11月6日至2011年4月25日",
					   @"開放時間",
					   @"每天上午09:00~晚上10:00",
					   @"展區",
					   @"1.大佳河濱公園\n2.美術公園區\n3.圓山公園區\n4.新生公園區",
					   nil];
			break;
		case 3://參觀須知
			isTitle=NO;
			dataArray=[NSMutableArray arrayWithObjects:@"1.請勿攜帶打火機,尖銳危險物品入展場內\n2.請勿摘取毀損展場內的植物和設施\n3.請勿赤膊或穿著汗衫,拖鞋等不雅服裝入館\n4.全館禁煙,禁食口香糖及檳榔\n5.大件行李或物品,請寄放服務人員處\n6.請遵守參觀秩序,共同維護展覽品質\n7.展場內請勿將垃圾隨地亂丟棄\n8.活動期間交通擁擠,請多多利用接駁車來參觀\n",
					   nil];
			break;
		case 4://票價資訊
			dataArray=[NSMutableArray arrayWithObjects:
					   @"預售票-200元",
					   @"第一階段預售票\n(2009/10/01~2010/03/31)\n第二階段預售票\n(2010/04/01~2010/08/31)",
					   @"全票-300元",
					   @"一般民眾",
					   @"優待票-200元",
					   @"1.在校學生(國中以上須持有學生証)\n2.孕婦(得要求出示孕婦手冊)\n3.低收入戶(持有台北市政府核發之低收入戶証明者)",
					   nil];
			break;
		case 5://聯絡資訊
			dataArray=[NSMutableArray arrayWithObjects:
					   @"地址",
					   @"11008 台北市信義區市府路一號",
					   @"台北市市民熱線",
					   @"1999",
					   @"客服電話",
					   @"02-2720-8889",
					   @"傳真",
					   @"02-27225076",
					   @"信箱",
					   @"ea-2010expo@mail.taipei.gov.tw",
					   nil];
			break;
		case 6://接駁車資訊
			dataArray=[NSMutableArray arrayWithObjects:
					   @"捷運接駁",
					   @"花博會場週邊捷運線包括淡水線、蘆洲線、木柵內湖線、為避開捷運圓山站人潮，欲於捷運民權西路站或捷運劍潭站轉乘淡水線之民眾，建議直接搭乘免費花博專車接駁至會場，而搭乘木柵線之民眾可由捷運松山機場站轉搭花博專車接駁至會場。",
					   @"停車場接駁",
					   @"假日期間花博會之停車場均落於會場外圍，如松山機場停車場、內湖地區停車場等，我們提供外圍停車場至會場的接駁車服務。",
					   nil];
			break;
		case 7:
			dataArray=[NSMutableArray arrayWithObjects:
					   @"華南料理",
					   @"",
					   @"介紹:",
					   @"askdfhaksdfhakdfgakdsygfakdgfajkuydsgfkuyagfkuaygsdfkuadfkuyagsdkuyfgasdkufgadsfgaksdygfkasydgfkasdgfkagsdf",
					   @"地址：",
					   @"asdfkajdsfhaskdjfhakjfhaksjdf",
					   @"電話:",
					   @"02-2345789",
					   nil];
			break;
			
		case 8:
			dataArray=[NSMutableArray arrayWithObjects:
					   @"ELLE夏日品牌服裝特賣會",
					   @"優惠活動說明：炎炎夏日,服裝特賣會在台北南京店搶鮮開跑囉!各式各樣的免費抽獎,問卷,試用,折扣,特賣會等好康的獎品,大家趕快來店就可以撿便宜唷!\n\n地點:台北南京東路3段248號3F\n\n時間:2010/5/24至5/28,每日10:00-19:00",
					   nil];
			break;
		case 9:
			dataArray=[NSMutableArray arrayWithObjects:
					   @"學名:",
					   @"icoris aurea",
					   @"英名:",
					   @"riental spider lily, Go Iden-spider lily",
					   @"中文別名(擇常見三例):",
					   @"東方蜘蛛百合,龍爪花,忽地笑",
					   @"科名:",
					   @"Amarylidance ae 石蒜科",
					   @"園藝分類:",
					   @"多年生球根花卉",
					   @"花色:",
					   @"黃,紅,白,橘,粉紅",
					   @"花期:",
					   @"7~11月",
					   @"花語:",
					   @"甜蜜的回憶",
					   nil];
			break;
		default:
			break;
	}
	
	for (NSString *eachString in dataArray) {
		DescriptionObject *thisObject=[[DescriptionObject alloc]init];
		thisObject.descriptionType=(isTitle)?DescriptionTypeTitle:DescriptionTypeContent;
		thisObject.textString=[NSString stringWithFormat:@"%@",eachString];
		[returnArray addObject:thisObject];
		[thisObject release];
		isTitle=!isTitle;
	}
	return returnArray;
}


/**
 取得描述頁面之title
 */
-(NSString*)getDescriptionTitle:(NSString*)key{
	NSInteger keyValue=[key intValue];
	NSString *returnString;
	switch (keyValue) {
		case 0:
			returnString=@"";
			break;
		case 1:
			returnString=AMLocalizedString(@"FloraOrigin",nil);
			break;
		case 2:
			returnString=AMLocalizedString(@"VisitTime",nil);
			break;
		case 3:
			returnString=AMLocalizedString(@"VisitNotice",nil);
			break;
		case 4:
			returnString=AMLocalizedString(@"TicketInfo",nil);
			break;
		case 5:
			returnString=AMLocalizedString(@"ContactInfo",nil);
			break;
		case 6:
			returnString=AMLocalizedString(@"Transpostation",nil);
			break;
		case 7:
			returnString=AMLocalizedString(@"DetailInfo",nil);
			break;
		case 8:
			returnString=AMLocalizedString(@"ActionContent",nil);
			break;
		default:
			returnString=@"Debug Message";
			break;
	}
	return returnString;
}
@end
