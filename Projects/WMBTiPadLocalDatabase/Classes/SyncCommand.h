#import <Foundation/Foundation.h>
#import "SyncSQL.h"

#pragma mark SyncMethod
NSString*(^testBlock)(NSString*)=
^(NSString* a){
    return a;  
};

void(^examValue)()=
^(){
    NSString *sql=[NSString stringWithFormat:@"select id, image46, image110, sort_number, ref_product from T_PRODUCT_IMAGE0 where ref_product = \"AF7A974D8CF84162974D495AEC31C9BA\" order by sort_number"];
    FMResultSet *rs = [[SingletonDBConnect share] executeQuery:sql];
    while([rs next]){
        NSLog(@"id:%@  sort:%i",[rs stringForColumn:@"id"], [rs intForColumn:@"sort_number"]);
    }
    [rs close];
};

id(^examTable)(NSString *searchKey, NSString *tableName)=
^(NSString *searchKey, NSString *tableName){
    NSMutableDictionary *rDic=[[NSMutableDictionary dictionary]retain];
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM %@",tableName];
    FMResultSet *rs = [[SingletonDBConnect share] executeQuery:sql];
    NSMutableArray *dataArray=[[NSMutableArray array]retain];
    while([rs next]){
        NSMutableDictionary *o=[NSMutableDictionary dictionary];
        [o setValue:[rs stringForColumn:searchKey] forKey:searchKey];
        [dataArray addObject:o];
    }
    [rDic setValue:dataArray forKey:@""];
    [rs close];
    return [rDic autorelease];   
};

void(^syncProduct)()=
^(){
    QueryPattern *syncPattern=[QueryPattern new];
    [syncPattern prepareDic:PRODUCT_SYNC];
    NSInteger total=[syncPattern getNumberUnderNode:@"productList" withKey:@"id"];
    BOOL r=[[SingletonDBConnect share]executeUpdate:@"DELETE FROM T_PRODUCT"];
    if (!r) {
        NSLog(@"deleting data in T_PRODUCT failed");
        return;
    }
    QueryPattern *tmpQuery=[QueryPattern new];
    NSArray *tmpArray=[syncPattern getObjectUnderNode:@"productList" withIndex:0];
    for(int i=0;i<total;i++){
        NSAutoreleasePool *myPool=[[NSAutoreleasePool alloc]init];
        NSDictionary *tmpDic=(NSDictionary*)[tmpArray objectAtIndex:i];
        [tmpQuery prepareDicWithDictionary:tmpDic];
        r=[[SingletonDBConnect share]executeUpdate:i_product,
           [tmpQuery getValue:@"id" withIndex:0],
           [NSNumber numberWithInt: [[tmpQuery getValue:@"retailPrice" withIndex:0]intValue]],
           [tmpQuery getValue:@"modelName" withIndex:0],
           [tmpQuery getValue:@"sys03" withIndex:0],
           [tmpQuery getValue:@"sys04" withIndex:0],
           [tmpQuery getValue:@"sys05" withIndex:0],
           [tmpQuery getValue:@"refProducttype" withIndex:0],
           [tmpQuery getValue:@"refBrand" withIndex:0],
           [tmpQuery getValue:@"sys02" withIndex:0],
           [tmpQuery getValue:@"code" withIndex:0],
           [tmpQuery getValue:@"sys01" withIndex:0],
           [tmpQuery getValue:@"productName" withIndex:0],
           [tmpQuery getValue:@"color" withIndex:0]
           ];
        
        if(!r) NSLog(@"update failure!");
        [myPool release];
    }
    //time cost:140 sec.
    NSLog((r)?@"commit success":@"commit failed!");
    [tmpQuery release];
    [syncPattern release];  
};

void(^syncProductBrand)()=
^(){
    QueryPattern *syncPattern=[QueryPattern new];
    [syncPattern prepareDic:PRODUCTBRAND_SYNC];
    NSInteger total=[syncPattern getNumberUnderNode:@"productBrandList" withKey:@"id"];
    BOOL r=[[SingletonDBConnect share]executeUpdate:@"DELETE FROM T_PRODUCT_BRAND0"];
    if(total==0) NSLog(@"There is no data to insert.");
    if (!r) {
        NSLog(@"deleting data in T_PRODUCTBRANE failed");
        return;
    }
    for(int i=0;i<total;i++){
        NSAutoreleasePool *myPool=[[NSAutoreleasePool alloc] init];
        r=[[SingletonDBConnect share]executeUpdate:i_productBrand,
           [syncPattern getValue:@"id" withIndex:i],
           [syncPattern getValue:@"sys03" withIndex:i],
           [syncPattern getValue:@"sys04" withIndex:i],
           [syncPattern getValue:@"name" withIndex:i],
           [syncPattern getValue:@"sys02" withIndex:i],
           [syncPattern getValue:@"sys01" withIndex:i]];
        if(!r) NSLog(@"executeUpdate failure!");
        [myPool release];
    }
    [syncPattern release];  
};

void(^syncProductType)()=
^(){
    QueryPattern *syncPattern=[QueryPattern new];
    [syncPattern prepareDic:PRODUCTTYPE_SYNC];
    NSInteger total=[syncPattern getNumberUnderNode:@"getProductTypeList" withKey:@"id"];
    BOOL r=[[SingletonDBConnect share]executeUpdate:@"DELETE FROM T_PRODUCT_TYPE0"];
    if(total==0) NSLog(@"There is no data to insert.");
    if (!r) {
        NSLog(@"deleting data in T_PRODUCT_TYPE0 failed");
        return;
    }
    for(int i=0;i<total;i++){
        NSAutoreleasePool *myPool=[[NSAutoreleasePool alloc] init];
        r=[[SingletonDBConnect share]executeUpdate:i_productType,
           [syncPattern getValue:@"id" withIndex:i],
           [syncPattern getValue:@"name" withIndex:i],
           [syncPattern getValue:@"sys02" withIndex:i],
           [syncPattern getValue:@"sys01" withIndex:i],
           [syncPattern getValue:@"primaryImage" withIndex:i]];
        if(!r) NSLog(@"executeUpdate failure!");
        [myPool release];
    }
    NSLog((r)?@"commit success":@"commit failed!");
    [syncPattern release];  
};

void(^syncProductImage)()=
^(){
    QueryPattern *syncPattern=[QueryPattern new];
    [syncPattern prepareDic:PRODUCTIMAGE_SYNC];
    NSInteger total=[syncPattern getNumberUnderNode:@"productImageList" withKey:@"id"];
    BOOL r=[[SingletonDBConnect share]executeUpdate:@"DELETE FROM T_PRODUCT_IMAGE0"];
    if(total==0) NSLog(@"There is no data to insert.");
    if (!r) {
        NSLog(@"deleting data in T_PRODUCT_IMAGE0 failed");
        return;
    }
    
    NSArray *dataArray=(NSArray*)[syncPattern getObjectUnderNode:@"productImageList" withIndex:0];
    NSAutoreleasePool *myPool=nil;
    int count=0;
    
    for(int i=0;i<total;i++){
        if(myPool==nil){
            myPool=[[NSAutoreleasePool alloc]init];
        }
        NSDictionary *dataDic=(NSDictionary*)[dataArray objectAtIndex:i];
        r=[[SingletonDBConnect share]executeUpdate:i_productImage,
           (NSString*)[dataDic valueForKey:@"id"],
           (NSString*)[dataDic valueForKey:@"image46"],
           (NSString*)[dataDic valueForKey:@"image110"],
           (NSString*)[dataDic valueForKey:@"image250"],
           (NSString*)[dataDic valueForKey:@"sys02"],
           (NSString*)[dataDic valueForKey:@"sys01"],
           [NSNumber numberWithInt: [(NSString*)[dataDic valueForKey:@"sortNumber"]intValue]],
           (NSString*)[dataDic valueForKey:@"productId"]];

        NSLog(@"insert image row %i",i);
        if(count>50){
            [myPool release];
            myPool=nil;
            count=0;
            [[SingletonDBConnect share]clearCachedStatements];
        }
        count++;
    }
    
    if(myPool!=nil)
        [myPool release];
    NSLog((r)?@"commit success":@"commit failed!");
    [syncPattern release];  
};

void(^syncProductScene)()=
^(){
    QueryPattern *syncPattern=[QueryPattern new];
    [syncPattern prepareDic:PRODUCTSCENE_SYNC];
    NSInteger total=[syncPattern getNumberUnderNode:@"getProductSceneList" withKey:@"id"];
    BOOL r=[[SingletonDBConnect share]executeUpdate:@"DELETE FROM T_PRODUCT_SCENE0"];
    if(total==0) NSLog(@"There is no data to insert.");
    if (!r) {
        NSLog(@"deleting data in T_PRODUCT_SCENE0 failed");
        return;
    }
    for(int i=0;i<total;i++){
        NSAutoreleasePool *myPool=[[NSAutoreleasePool alloc] init];
        r=[[SingletonDBConnect share]executeUpdate:i_productScene,
           [syncPattern getValue:@"id" withIndex:i],
           [syncPattern getValue:@"dockImage" withIndex:i],
           [syncPattern getValue:@"sceneImage" withIndex:i],
           [syncPattern getValue:@"name" withIndex:i],
           [syncPattern getValue:@"sys02" withIndex:i],
           [syncPattern getValue:@"sys01" withIndex:i],
           [NSNumber numberWithInt: [[syncPattern getValue:@"sort_number" withIndex:i]intValue]],
           [syncPattern getValue:@"primaryImage" withIndex:i]];
        if(!r) NSLog(@"executeUpdate failure!");
        [myPool release];
    }
    NSLog((r)?@"commit success":@"commit failed!");
    [syncPattern release];  
};

void(^syncProductSceneGroup)()=
^(){
    QueryPattern *syncPattern=[QueryPattern new];
    [syncPattern prepareDic:PRODUCTSCENEGROUP_SYNC];
    NSInteger total=[syncPattern getNumberUnderNode:@"getProductSceneGroupList" withKey:@"id"];
    BOOL r=[[SingletonDBConnect share]executeUpdate:@"DELETE FROM T_PRODUCT_SCENE_GROUP0"];
    if(total==0) NSLog(@"There is no data to insert.");
    if (!r) {
        NSLog(@"deleting data in T_PRODUCT_SCENE_GROUP0 failed");
        return;
    }
    for(int i=0;i<total;i++){
        NSAutoreleasePool *myPool=[[NSAutoreleasePool alloc] init];
        r=[[SingletonDBConnect share]executeUpdate:i_productSceneGroup,
           [syncPattern getValue:@"id" withIndex:i],
           [NSNumber numberWithInt: [[syncPattern getValue:@"pointX" withIndex:i]intValue]],
           [NSNumber numberWithInt: [[syncPattern getValue:@"pointY" withIndex:i]intValue]],
           [syncPattern getValue:@"sys02" withIndex:i],
           [syncPattern getValue:@"refScene" withIndex:i],
           [syncPattern getValue:@"sys01" withIndex:i],
           [NSNumber numberWithInt: [[syncPattern getValue:@"sort_number" withIndex:i]intValue]],
           [syncPattern getValue:@"refType" withIndex:i]];
        if(!r) NSLog(@"executeUpdate failure!");
        [myPool release];
    }
    NSLog((r)?@"commit success":@"commit failed!");
    [syncPattern release];  
};

void(^syncProductSpec)()=
^(){
    QueryPattern *syncPattern=[QueryPattern new];
    [syncPattern prepareDic:PRODUCTSPEC_SYNC];
    NSInteger total=[syncPattern getNumberUnderNode:@"productSpecList" withKey:@"id"];
    BOOL r=[[SingletonDBConnect share]executeUpdate:@"DELETE FROM T_PRODUCT_SPEC0"];
    if(total==0) NSLog(@"There is no data to insert.");
    if (!r) {
        NSLog(@"deleting data in T_PRODUCT_SPEC0 failed");
        return;
    }
    NSAutoreleasePool *myPool=nil;
    int count=0;
    NSArray *dataArray=[syncPattern getObjectUnderNode:@"productSpecList" withIndex:0];
    for(int i=0;i<total;i++){
        if(myPool==nil){
            myPool=[[NSAutoreleasePool alloc] init];
        }
        NSDictionary *dataDic=(NSDictionary*)[dataArray objectAtIndex:i];
        r=[[SingletonDBConnect share]executeUpdate:i_productSpec,
           (NSString*)[dataDic valueForKey:@"id"],
           (NSString*)[dataDic valueForKey:@"refProduct"],
           (NSString*)[dataDic valueForKey:@"sys03"],
           (NSString*)[dataDic valueForKey:@"sys04"],
           (NSString*)[dataDic valueForKey:@"name"],
           (NSString*)[dataDic valueForKey:@"value"],
           (NSString*)[dataDic valueForKey:@"sys02"],
           (NSString*)[dataDic valueForKey:@"sys01"],
           [NSNumber numberWithInt:[(NSString*)[dataDic valueForKey:@"sortNumber"]intValue]]];

        NSLog(@"insert spec row %i",i);
        if(!r) NSLog(@"executeUpdate failure!");
        if(count>50){
            [myPool release];
            myPool=nil;
            count=0;
        }
        count++;
    }
    
    if(myPool!=nil)
        [myPool release];
    NSLog((r)?@"commit success":@"commit failed!");
    [syncPattern release];  
};

//儲存圖片之method
void(^syncPic)(NSString *picSubPath,NSString *saveFileName)=
^(NSString *picSubPath,NSString *saveFileName){
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:saveFileName];
//    NSLog(@"url:%@",[NSString stringWithFormat:@"%@%@",SERVERPREFIX,picSubPath]);
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVERPREFIX,picSubPath]];
	NSData *data=[NSData dataWithContentsOfURL:url];
//    NSLog(@"download data length:%i",[data length]);
    [data writeToFile:appFile atomically:YES];
    
    NSLog(@"downloading file %@ to %@ %@",picSubPath,appFile,
          [[NSFileManager defaultManager] fileExistsAtPath:appFile isDirectory:NO]?@"success":@"failure");
};

id(^getImageNameFromImageTable)(int num, int offset)=
^(int num, int offset){
    NSMutableArray *rArray=[[NSMutableArray array] retain];
    FMResultSet *r=[[SingletonDBConnect share] executeQuery:[NSString stringWithFormat:@"SELECT IMAGE46,IMAGE110,IMAGE250 FROM T_PRODUCT_IMAGE0 LIMIT %i OFFSET %i",num,offset]];
    while([r next]){
        [rArray addObject:[r stringForColumn:@"IMAGE46"]];
        [rArray addObject:[r stringForColumn:@"IMAGE110"]];
        [rArray addObject:[r stringForColumn:@"IMAGE250"]];
    }
    [r close];
    return [rArray autorelease];
};

id(^getImageNameFromSceneTable)(int num, int offset)=
^(int num, int offset){
    NSMutableArray *rArray=[[NSMutableArray array] retain];
    FMResultSet *r=[[SingletonDBConnect share] executeQuery:[NSString stringWithFormat:@"SELECT DOCK,\"PRIMARY\" FROM T_PRODUCT_SCENE0 LIMIT %i OFFSET %i",num,offset]];
    while([r next]){
        [rArray addObject:[r stringForColumn:@"PRIMARY"]];
        [rArray addObject:[r stringForColumn:@"DOCK"]];
    }
    [r close];
    return [rArray autorelease];
};
#pragma mark -