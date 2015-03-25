//
//  DummyData.m
//  HealthCare
//
//  Created by Chang Link on 11/11/8.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import "DummyData.h"
#import "ServiceDataObject.h"
#import "RegisterRecListDataObject.h"
#import "CustomerInfo.h"
@implementation DummyData
+(void)addServiceIntroData:(NSMutableArray*) _dataArray{
    ServiceDataObject *m_sdo = [ServiceDataObject new];
    m_sdo.name = @"會員服務內容";
    m_sdo.serviceId = @"1";
    [_dataArray addObject:m_sdo];
    [m_sdo release];
    
    ServiceDataObject *m_sdo1 = [ServiceDataObject new];
    m_sdo1.name = @"企業用戶";
    m_sdo1.serviceId = @"2";
    [_dataArray addObject:m_sdo1];
    [m_sdo1 release];
    
    ServiceDataObject *m_sdo2 = [ServiceDataObject new];
    m_sdo2.name = @"一般民眾";
    m_sdo2.serviceId = @"3";
    [_dataArray addObject:m_sdo2];
    [m_sdo2 release];
}
+(NSString*)addServiceInfoData:(NSString*) _serviceId{
    NSString *sRetrun = @"";
    if ([_serviceId isEqualToString:@"1"]) {
        sRetrun = @"服務中心提供會員個人及企業進行健康管理與第一線的諮詢服務與客訴，如24小時監控其生理量測狀態並主動追蹤，若評估有需要就醫時，進行回診安排。除平時健康管理外，設有緊急醫療服務協助與諮詢，若會員有醫療上或用藥安全的問題時，提供即時的諮詢服務。除醫療上的問題外，中心可協助連結生活資源資訊及訂購醫療耗材，給予會員即時的資訊與服務，簡化尋求資源的繁雜程序。若照護硬體設備有異常時，亦可藉由諮詢中心進行線上排除。 \n\n一、24小時生理監測與主動追蹤\n 透過服務中心資訊系統的建置，完成與其他醫療照護機構的資訊系統及照護設備的介接，服務中心可統一接收介面，蒐集會員個案相關電子照護紀錄，並完成對個案生理量測資料自動化的蒐集。透過監測系統設定，當會員有量測異常狀況時，服務中心人員將第一時間獲得資訊並主動追蹤，直到事件結案終止，以確保會員之健康與安全，並留下事件追蹤管理紀錄以備日後查詢處理。\n 生理訊號異常指的是各個會員未符合區域中心照護平台所設定「生理訊號數據監控」之上下閾值之內。在服務流程規劃中，當服務中心系統監測到生理量測異常時，值班人員即時去電關心詢問是否有身體不適之情形，若會員無身體不適則建議休息後持續觀察待再度量測正常後即可結案，但若會員反映身體不適則先給予衛教，若情況較為複雜，值班護理師將去電諮詢值班醫師詢問建議之處置後回覆會員，當判斷需提早回診或急診則通知主責醫院處理後續照護事宜。\n除了監測生理量測結果外，值班人員每日例行確認未量測名單，去電確認未量測原因，再將原因與處理結果通報主責醫院進行後續服務。\n\n二、緊急醫療服務 \n遠距量測照護盒中設有緊急按鈕，會員發生緊急事件時可按壓緊急鈕，通知服務中心，中心值班人員將立即主動去電了解狀況，判斷狀況為會員誤壓、需問題諮詢或生理徵象異常。\n(1) 若是誤壓者則直接紀錄結案。\n(2) 假設需問題諮詢者，則由護理人員於線上回覆，但會員狀況複雜者進一步諮詢值班醫師或其他專業人員再行回覆給會員。\n(3) 出現生理徵象異常者，轉介值班醫師評估是否需急診或提早回診。若為判斷需急診，即刻通知119警消單位，啟動急診就醫流程；醫師判定提早回診者，中心人員通報主責護理師進行後續服務。\n當會員進入急診流程時，中心人員需通報急診檢傷分類櫃檯與家屬，告知會員狀況。之後以簡訊發送方式聯絡該會員主責護理師進行後續服務，待主責護理師追蹤了解狀況，留下事件追蹤管理紀錄後才可登錄結案。\n\n三、會員健康管理\n區域服務中心掌握完整會員就醫紀錄、第一手生理量測紀錄與用藥紀錄，可追蹤會員健康狀況。為養成會員自我健康管理，服務中心固定每月月初以電子郵件方式寄發上個月生量測生理曲線圖月報表供會員及主責醫師參考，醫師可以從中得知病患長期以來生理狀況的穩定性與變化，更能精準的了解病患的病患狀況，甚至了解上次所開立藥物的療效，使後續醫師在進行相關治療的醫令、醫囑與處方籤的開立上能對病患更有幫助。\n\n四、用藥安全指導\n慢性疾病的患者，必需要透過長期服用藥物控制病情，在無法任意停藥的情況下，若因為其他臨時引發的疾病，而導致需要服用多種藥物，此時這些藥物是否有交互作用是服用時不可疏忽的事項，也是區域服務中心可以提供之服務項目。藉由整合不同醫療機構間同一會員的用藥紀錄，專業藥師可從整合後的用藥紀錄，進行會員用藥安全評估，必要時可以給予適時的用藥建議，提升用藥安全。\n會員有任何關於藥物之問題可撥打區域服務中心諮詢電話，值班護理師會依照會員問題複雜程度與狀況判斷諮詢值班藥師。\n\n五、即時諮詢服務\n中心設有24小時值班護理師提供即時諮詢服務機制，由護理師提供會員第一線衛教諮詢、護理指導等，服務人員依照標準流程根據話術指引系統內建之知識庫內容，回答會員。如會員狀況較為複雜須醫師提供即時諮詢時，進一步諮詢第一線值班醫師或其他專業人員，回覆時間限定於一小時內回覆，若諮詢複製擴散承作醫院的第二線醫師，則需於四小時內回覆完畢。\n\n六、生活資源轉介諮詢\n區域服務中心除了提供健康照護相關服務之外，彙整各區域生活資源相關資訊，與生活服務業者合作進行生活資源轉介之服務，提供會員各種居家生活上的服務，並開放會員上網瀏覽廠商資訊、訂購生活服務以及轉介生活支援服務，服務項目包含：送餐、家事清潔服務、陪同外出、交通接送、協助送藥、協助沐浴、代購用品及輔具租借等至少15家業者並與廠商簽約，確保服務內容與品質。\n當會員需要生活照顧支援時，可來電洽詢或於網路上訂購相關服務，使會員能在最短時間內獲得支援，且追蹤服務是否到位後才可結案。\n\n七、回診安排\n當會員自覺不舒服或是經過生理監測系統評估過後覺得需要就診時(非急診)，值班人員會通知主責醫院護理師協助掛號，掛號完畢之後由主責醫院護理師需回覆病患掛號結果與就診時間，再登入平台通知中心值班人員掛號結果與就診時間後才可結案。\n\n八、設備異常諮詢服務\n設備異常影響的層面不僅在於會員生理監控中斷，當會員有緊急狀況時會導致無法緊急醫療諮詢與後送的問題，因此即時的設備異常排除是重要的服務項目。\n當中心人員發現設備異常或會員來電反應設備異常時，值班人員先判斷狀況為血壓血糖設備故障、照護盒無法傳輸或網路問題，服務人員先於線上協助處理，若是設備問題且線上無法處理者，聯絡資訊人員，並回覆會員處理方法與時間。假設為網路異常者請會員聯繫電信業者協助處理，並追蹤後續處理狀況直到功能恢復正常。\n九、受理客訴\n當會員對於遠距照護服務或區域服務中心任一環節提出抱怨、不滿等意見時，中心第一線服務人員需仔細聆聽並紀錄後上呈單位主管進行問題釐清，若為區域服務中心內之問題，則召開內部討論會議商討因應對策，若為複製擴散承做醫院/生活支援廠商等服務端的問題則由區域服務中心聯絡通知，必要時召開會議進行檢討。相關會議討論結果下達指示給第一線人員回覆客訴對象，若問題較為複雜則由主管級人員進行回覆。";
    }else if ([_serviceId isEqualToString:@"2"]) {
        sRetrun = @"企業型態、環境與工作壓力間接影響員工的健康，再加上個人的不良生活習慣，例如：抽菸、過量飲酒、運動習慣以及飲食習慣等問題潛藏著更多疾病風險。優良的企業組織雖然每年均會提撥相關的經費比例來提供其內部員工，在各醫院進行健康檢查，但健康檢查終究是人體特定時期的短暫生理或甚至於心理狀況的評估與檢測。人體是持續變化的有機體，其健康檢查結果的有效參考時間是極其有限的，相對於一次全面的健康檢查，日常的生理狀況的簡易觀測也是有其重大的意義，尤其是對佔現代社會人士大多數的亞健康、慢性病患者等族群而言，更是如此。\n 企業健康管理模式主要分為企業員工個人以及整體企業等兩個主軸，詳細說明如下：\n\n一、企業員工個人健康管理\n(1) 遠距生理監控：透過遠距血壓、血糖量測監控，加以記錄追蹤員工健康狀況。\n(2) 警示通報處理：架構緊急醫療行動，使員工有緊急情況發生時可獲得即時醫療建議與協助。\n(3) 員工健康管理：當員工生理量測狀況異常時，將透過簡訊或電子郵件通知員工量測異常，並適時提供衛教資訊，期望藉此方式提高員工自主健康管理。\n(4) 生活資源轉介及諮詢：區域服務中心與生活資源業者合作，提供生活資源轉介服務，企業員工可上網瀏覽廠商資訊，訂購生活服務。\n(5) 領藥協助：若員工有慢性處方籤需領藥，則透過與社區藥局合作提供送藥服務，由藥師送藥到廠區，減少員工到醫院領藥程序及交通往返時間。\n(6) 個人衛教諮詢：員工對自我健康問題有任何疑慮可電洽區域服務中心，由護理師提供 24小時即時衛教諮詢。當若員工問題較為複雜者，則進一步諮詢二線值班醫師後再回覆員工。若諮詢問題為用藥議題則轉介由社區藥局提供諮詢服務。\n(7) 個人健康摘要報告：定期提供員工個人健康摘要報告，其內容包含：生理量測歷史曲線圖、用藥紀錄、就醫紀錄、健康異常提醒、日常生活健康管理注意事項等，視狀況給予健康檢查建議。\n\n二、企業整體健康管理\n(1) 企業整體健康摘要報告：針對整體員工健康資料進行分析，例如：健康異常比例、交叉分析評估危險族群。\n(2) 健康檢查項目建議：提供企業勞工健康檢查項目建議，建議檢查指標包含：廠區環境風險因子、心理層面以及歸納整體員工生理狀態之風險因子。\na. 針對廠區環境風險因子評估各家企業廠區環境健康危險因子、工作型態等，例如：噪音、高溫環境、粉塵作業等，建議特殊檢查項目。\nb. 心理層面之檢測，例如：恐慌症檢測、憂鬱量表等。\nc. 整體員工生理狀態風險因子，例如:員工平均年齡較高之企業進行更高階的檢查項目。 \n(3) 健康促進方案建議：評估整體員工健康狀況後，提供企業專屬健康促進建議方案，例如：當企業員工檢測結果整體壓力大，則規劃心理諮商方案介入，服務內容預包含：\na. 自我心理評估：提供各類心理測驗，供員工免費使用，增進對自己心理健康之了解。\nb. 心靈處方：由醫師、心理師、職能復健師等專業人員，規劃各類心理及精神相關課程，供員工線上自我學習。\nc. 線上心理諮商區：員工可在此預約心理諮商時間，不用出門就可與專業合格的諮商人員進行線上即時會談；諮商人員並可視員工問題需要，提供就醫轉介服務。\nd. 健康新知：由醫師、心理師、職能復健師等專業人員，定期於網上張貼有關身心保健之文章，供員工瀏覽與討論。\ne. 互動留言區：設置主題討論區，提供電子郵件及留言討論的功能，並有專人負責管理及回應，使員工與諮商人員可以很方便而充分地進行互動溝通。";
    }else if([_serviceId isEqualToString:@"3"]) {
        sRetrun = @"一般民眾服務內容可分為五大項目：服務宣傳、受理入會、生活照顧資源轉介、即時諮詢與用藥安全指導，詳細說明如下： \n\n一、服務說明與宣傳\n區域服務中心掌握各區域健康照護與生活照顧資源，但若無適當的宣傳，將無法將服務資訊傳達給民眾。因此，本中心將透過不同宣傳媒介包含：DM單張、期刊雜誌、網際網路等方式傳播遠距健康照護網絡，若民眾有對於遠距照護服務有不了解之處亦可撥打電話至中心，將有專人解說。\n\n二、辦理會員服務註冊\n本中心受理遠距照護服務入會申請，民眾可直接撥打服務專線或透過服務健康照護網站聯絡服務中心，服務人員將於24小時內回覆並辦理入會手續，並依照會員所在地之複製擴散承做醫院資料供會員參考，由會員選擇承做醫院做為遠距照護主責醫院。\n\n三、生活資源轉介諮詢\n區域服務中心彙整各區域生活資源相關資訊及廠商於平台並與廠商簽約，確保服務內容與品質。當民眾需要生活照顧支援時，可來電洽詢或於網路上訂購相關服務，使民眾能在最短時間內獲得支援。\n\n四、用藥安全指導\n當民眾來電需藥物諮詢者，第一線服務人員將評估問題嚴重度，若民眾問題需專業藥師評估時，將即時轉介與中心合作之社區藥局藥師提供即時諮詢服務，緊急問題一小時內回覆，其他非緊急議題於四小時內回覆完畢。\n\n五、即時諮詢服務\n中心設有24小時值班護理師提供疾病衛教諮詢，若民眾之問題超過話術指引系統內建之知識庫時或會員狀況較為特殊複雜並非護理師可解答時，進一步諮詢值班醫師或其他專業人員，回覆時間限定同藥品安全諮詢，緊急問題一小時內回覆，其他非緊急議題於四小時內回覆完畢。";
    }
    return sRetrun;
}

+(void)addRegisterRecData:(NSMutableArray*) _dataArray{
    RegisterRecListDataObject *m_rdo = [RegisterRecListDataObject new];
    m_rdo.doctorName = @"蕭玉芳";
    m_rdo.hospitalName = @"高雄醫學大學附設中和紀念醫院";
    m_rdo.recordId = @"1";
    m_rdo.departmentName=@"內科";
    m_rdo.status=0;
    [_dataArray addObject:m_rdo];
    [m_rdo release];
    
    RegisterRecListDataObject *m_rdo1 = [RegisterRecListDataObject new];
    m_rdo1.doctorName = @"李政經";
    m_rdo1.hospitalName = @"高雄市立小港醫院";
    m_rdo1.recordId = @"2";
    m_rdo1.departmentName=@"復健科";
    m_rdo1.status=1;
    [_dataArray addObject:m_rdo1];
    [m_rdo1 release];
    
    RegisterRecListDataObject *m_rdo2 = [RegisterRecListDataObject new];
    m_rdo2.doctorName = @"蕭玉芳";
    m_rdo2.hospitalName = @"高雄醫學大學附設中和紀念醫院";
    m_rdo2.recordId = @"3";
    m_rdo2.departmentName=@"內科";
    m_rdo2.status=1;
    [_dataArray addObject:m_rdo2];
    [m_rdo2 release];
    
    RegisterRecListDataObject *m_rdo3 = [RegisterRecListDataObject new];
    m_rdo3.doctorName = @"蕭玉芳";
    m_rdo3.hospitalName = @"高雄醫學大學附設中和紀念醫院";
    m_rdo3.recordId = @"4";
    m_rdo3.status=1;
    m_rdo3.departmentName=@"內科";
    [_dataArray addObject:m_rdo3];
    [m_rdo3 release];
    
    RegisterRecListDataObject *m_rdo4 = [RegisterRecListDataObject new];
    m_rdo4.doctorName = @"李政經";
    m_rdo4.hospitalName = @"高雄市立小港醫院";
    m_rdo4.recordId = @"5";
    m_rdo4.departmentName=@"復健科";
    m_rdo4.status=1;
    [_dataArray addObject:m_rdo4];
    [m_rdo4 release];

}
+(void)setRegisterRecInfoData:(NSArray*) _dataArray{
    
    ((UILabel*)[_dataArray objectAtIndex:0]).text = @"高雄醫學大學附設中和紀念醫院";
    ((UILabel*)[_dataArray objectAtIndex:1]).text = @"2011/11/12週六";
    ((UILabel*)[_dataArray objectAtIndex:2]).text = @"上午";
    ((UILabel*)[_dataArray objectAtIndex:3]).text = @"內科";
    ((UILabel*)[_dataArray objectAtIndex:4]).text = @"第304診間";
    ((UILabel*)[_dataArray objectAtIndex:5]).text = @"蕭玉芳";
    ((UILabel*)[_dataArray objectAtIndex:6]).text = @"15";
    ((UILabel*)[_dataArray objectAtIndex:7]).text = @"3";
}

+(CustomerInfo*)getCustomerInfo
{
    CustomerInfo *m_customer = [CustomerInfo new];
    [m_customer setUserId:@"123456"];
    [m_customer setFirstName:@"Reach"];
    [m_customer setLastName:@"Hu"];
    [m_customer setPhoneNum:@"0911321821"];
    [m_customer setEmail:@"reach.hu@gmail.com"];
    [m_customer setAddress:@"高雄市"];
    [m_customer setEmergencyContact:@"Jessamine"];
    [m_customer setNote:@"......"];
    [m_customer autorelease];
    return m_customer;
}
@end
