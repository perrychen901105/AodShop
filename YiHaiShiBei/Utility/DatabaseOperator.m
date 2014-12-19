//
//  DatabaseOperator.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/23.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "DatabaseOperator.h"
#import "FMDB.h"
#import "AppDelegate.h"

#import "LocationModel.h"
#import "InformationListModel.h"
#import "MsgListModel.h"
#import "MerchantModel.h"
#import "RequirePurchaseModel.h"
#import "GrouponModel.h"
#import "ProductModel.h"

@implementation DatabaseOperator
{
}

+ (DatabaseOperator *)getInstance
{
    static DatabaseOperator *instance;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - 首页
#pragma mark - Locations
- (void)insertAllLocations:(NSArray *)arrAllLocations
{
    [self deleteAllDistricts];
    NSMutableArray *arrProvinces = [@[] mutableCopy];
    NSMutableArray *arrCitys = [@[] mutableCopy];
    for (NSDictionary *dicLocation in arrAllLocations) {
        [arrProvinces addObject:dicLocation[@"Province"]];
        NSLog(@"dic loaction city is %@",[dicLocation[@"City"] objectAtIndex:0]);
//        [arrCitys addObject:[dicLocation[@"City"] objectAtIndex:0]];
        [arrCitys addObjectsFromArray:dicLocation[@"City"]];
    }
    
    FMDatabaseQueue *databaseQueue = [FMDatabaseQueue databaseQueueWithPath:[AppDelegate getCacheDatabasePath]];
    [databaseQueue inDatabase:^(FMDatabase *db){
        for (NSDictionary *dicPro in arrProvinces) {
            NSString *strProvinceId = dicPro[@"id"];
            NSString *strProvinceName = dicPro[@"name"];
            BOOL dbSuccess = [db executeUpdate:@"insert or replace into ProvinceList(id, name) values (?,?)",strProvinceId, strProvinceName];
            if (dbSuccess) {
                NSLog(@"success");
            }
        }
        
        for (NSDictionary *dicCity in arrCitys) {
            NSLog(@"the dic city is %@",dicCity);
            NSString *strCityId = dicCity[@"id"];
            NSString *strCityName = dicCity[@"name"];
            NSString *strProvinceId = dicCity[@"province_id"];
            BOOL dbSuccess = [db executeUpdate:@"insert or replace into CityList(id, name, provinceId) values (?,?,?)",strCityId, strCityName, strProvinceId];
            if (dbSuccess) {
                NSLog(@"success");
            }
            NSArray *arrDistrict = dicCity[@"District"];
            for (NSDictionary *dicDistrict in arrDistrict) {
                NSString *strDisId = dicDistrict[@"id"];
                NSString *strDisName = dicDistrict[@"name"];
                NSString *strCityId = dicDistrict[@"city_id"];
                BOOL dbSuccess = [db executeUpdate:@"insert or replace into DistrictList(id, name, cityId) values (?,?,?)",strDisId, strDisName, strCityId];
                if (dbSuccess) {
                    NSLog(@"success");
                }
            }
        }
        
    }];
    [databaseQueue close];
    databaseQueue = nil;
}

- (NSMutableArray *)getAllProvinces
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return [@[] mutableCopy];
    }
    // ...
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM ProvinceList"];
    FMResultSet *rs = [db executeQuery:strSql];
    NSMutableArray *arrProvinces = [@[] mutableCopy];
    while ([rs next]) {
        ProvinceModel *model = [[ProvinceModel alloc] init];
        model.provinceID = [rs intForColumn:@"id"];
        model.name = [rs stringForColumn:@"name"];
#ifdef DEBUG
        NSLog(@"model is %@",model);
#endif
        [arrProvinces addObject:model];
    }
    [db close];
    return arrProvinces;
}

- (NSMutableArray *)getAllCitysWithProvinceId:(NSInteger)provinceId
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return [@[] mutableCopy];
    }
    // ...
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM CityList where provinceId = %d",provinceId];
#ifdef DEBUG
    NSLog(@"sql is %@",strSql);
#endif
    FMResultSet *rs = [db executeQuery:strSql];
    NSMutableArray *arrCitys = [@[] mutableCopy];
    while ([rs next]) {
        CityModel *model = [[CityModel alloc] init];
        model.cityID = [rs intForColumn:@"id"];
        model.name = [rs stringForColumn:@"name"];
#ifdef DEBUG
        NSLog(@"model is %@",model);
#endif
        [arrCitys addObject:model];
    }
    [db close];
    return arrCitys;
}
- (NSMutableArray *)getAllDistrictsWithCityId:(NSInteger)cityId
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return [@[] mutableCopy];
    }
    // ...
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM DistrictList where cityId = %d",cityId];
#ifdef DEBUG
    NSLog(@"sql is %@",strSql);
#endif
    FMResultSet *rs = [db executeQuery:strSql];
    NSMutableArray *arrDistricts = [@[] mutableCopy];
    while ([rs next]) {
        DistrinctModel *model = [[DistrinctModel alloc] init];
        model.districtID = [rs intForColumn:@"id"];
        model.name = [rs stringForColumn:@"name"];
#ifdef DEBUG
        NSLog(@"model is %@",model);
#endif
        [arrDistricts addObject:model];
    }
    [db close];
    return arrDistricts;
}

- (void)deleteAllDistricts
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    // ...
    NSString *strSql1 = [NSString stringWithFormat:@"DELETE * FROM DistrictList"];
    NSString *strSql2 = [NSString stringWithFormat:@"DELETE * FROM CityList"];
    NSString *strSql3 = [NSString stringWithFormat:@"DELETE * FROM ProvinceList"];
    BOOL dbSuccess = [db executeUpdate:strSql1];
    dbSuccess = [db executeUpdate:strSql2];
    dbSuccess = [db executeUpdate:strSql3];
    if (dbSuccess) {
        NSLog(@"success");
    }

    [db close];
    return ;

}

#pragma mark - Informations
- (void)insertAllInformations:(NSMutableArray *)arrInfors withDistrictId:(NSInteger)districtid
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    NSMutableArray *arrValues = [@[] mutableCopy];
    for (InformationModel *modelInfo in arrInfors) {
        NSString *strValues = [NSString stringWithFormat:@"(%d,'%@','%@','%@','%@',%d,%d,'%@')",modelInfo.infoId,modelInfo.title, modelInfo.content,modelInfo.release_date, modelInfo.picture,modelInfo.district_id,modelInfo.user_id,modelInfo.userName];
        [arrValues addObject:strValues];
    }
    NSString *strAllValue = [arrValues componentsJoinedByString:@","];
    NSString *strExec = [NSString stringWithFormat:@"insert or replace into Information(id, title, content, release_date, picture, district_id, user_id, username) values %@",strAllValue];
    BOOL dbSuccess = [db executeUpdate:strExec];
    if (dbSuccess) {
        NSLog(@"success");
    }
    [db close];
    db = nil;
}
- (NSMutableArray *)getAllInformationsWithDistrictId:(NSInteger)districtid
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return [@[] mutableCopy];
    }
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM Information where district_id = %d",districtid];
#ifdef DEBUG
    NSLog(@"sql is %@",strSql);
#endif
    FMResultSet *rs = [db executeQuery:strSql];
    NSMutableArray *arrInfos = [@[] mutableCopy];
    while ([rs next]) {
        InformationModel *model = [[InformationModel alloc] init];
        model.infoId = [rs intForColumn:@"id"];
        model.title = [rs stringForColumn:@"title"];
        model.content = [rs stringForColumn:@"content"];
        model.release_date = [rs stringForColumn:@"release_date"];
        model.picture = [rs stringForColumn:@"picture"];
        model.district_id = [rs intForColumn:@"district_id"];
        model.user_id = [rs intForColumn:@"user_id"];
        model.userName = [rs stringForColumn:@"username"];
#ifdef DEBUG
        NSLog(@"model is %@",model);
#endif
        [arrInfos addObject:model];
    }
    [db close];
    return arrInfos;

}
- (void)removeAllInforsWithDistrictId:(NSInteger)districtid
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    // ...
    NSString *strSql1 = [NSString stringWithFormat:@"DELETE * FROM Information where district_id = %d",districtid];
    BOOL dbSuccess = [db executeUpdate:strSql1];
    if (dbSuccess) {
        NSLog(@"success");
    }
    
    [db close];
    return ;

}

#pragma mark - Message
- (void)insertAllMessages:(NSMutableArray *)arrMsgs withDistrictId:(NSInteger)districtid
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    NSMutableArray *arrValues = [@[] mutableCopy];
    for (MsgModel *modelMsg in arrMsgs) {
        NSString *strValues = [NSString stringWithFormat:@"(%d,'%@','%@','%@','%@',%d,%d,'%@')",modelMsg.msgId,modelMsg.title, modelMsg.content,modelMsg.release_date, modelMsg.picture,modelMsg.district_id,modelMsg.user_id,modelMsg.userName];
        [arrValues addObject:strValues];
    }
    NSString *strAllValue = [arrValues componentsJoinedByString:@","];
    NSString *strExec = [NSString stringWithFormat:@"insert or replace into Message(id, title, content, release_date, picture, district_id, user_id, username) values %@",strAllValue];
    BOOL dbSuccess = [db executeUpdate:strExec];
    if (dbSuccess) {
        NSLog(@"success");
    }
    [db close];
    db = nil;

}
- (NSMutableArray *)getAllMessagesWithDistrictId:(NSInteger)districtid
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return [@[] mutableCopy];
    }
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM Message where district_id = %d",districtid];
#ifdef DEBUG
    NSLog(@"sql is %@",strSql);
#endif
    FMResultSet *rs = [db executeQuery:strSql];
    NSMutableArray *arrInfos = [@[] mutableCopy];
    while ([rs next]) {
        MsgModel *model = [[MsgModel alloc] init];
        model.msgId = [rs intForColumn:@"id"];
        model.title = [rs stringForColumn:@"title"];
        model.content = [rs stringForColumn:@"content"];
        model.release_date = [rs stringForColumn:@"release_date"];
        model.picture = [rs stringForColumn:@"picture"];
        model.district_id = [rs intForColumn:@"district_id"];
        model.user_id = [rs intForColumn:@"user_id"];
        model.userName = [rs stringForColumn:@"username"];
#ifdef DEBUG
        NSLog(@"model is %@",model);
#endif
        [arrInfos addObject:model];
    }
    [db close];
    return arrInfos;
}
- (void)removeAllMessagesWithDistrictId:(NSInteger)districtid
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    // ...
    NSString *strSql1 = [NSString stringWithFormat:@"DELETE * FROM Message where district_id = %d",districtid];
    BOOL dbSuccess = [db executeUpdate:strSql1];
    if (dbSuccess) {
        NSLog(@"success");
    }
    [db close];
    return ;
}

/**
 求购
 */
- (void)insertAllRequirePurchase:(NSMutableArray *)arrData
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    NSMutableArray *arrValues = [@[] mutableCopy];
    for (RequirePurchaseModel *model in arrData) {
        NSString *strValues = [NSString stringWithFormat:@"(%d,%d,'%@','%@','%@',%d,'%@','%@',%d,'%@','%@','%@','%@','%@',%d,%d,'%@','%@')",model.purchaseID,model.purchaseUserID,model.purchaseTitle,model.purchaseInfo,model.purchaseTime,model.purchaseIsPass,model.purchasePassTime,model.backup,model.purchaseDistrictID,model.purchaseDistrictName,model.purchaseUsrName,model.purchaseAvatar,model.purchaseUsrEmail,model.purchaseUsrPhone,model.purchaseUsrIsPass,model.purchaseCatID,model.purchaseCatName,model.purchaseCatPic];
        [arrValues addObject:strValues];
    }
    NSString *strAllValue = [arrValues componentsJoinedByString:@","];
    NSString *strExec = [NSString stringWithFormat:@"insert or replace into RequirePurchaseList(id, userID, title, info, purchaseTime, ispass, passTime, backup, distirctID, districtName, username, avatar, email, phone, userIsPass, catID, catName, catPic) values %@",strAllValue];
    BOOL dbSuccess = [db executeUpdate:strExec];
    if (dbSuccess) {
        NSLog(@"success");
    }
    [db close];
    db = nil;
}
- (NSMutableArray *)getALlRequirePuchaseList
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return [@[] mutableCopy];
    }
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM RequirePurchaseList"];
    FMResultSet *rs = [db executeQuery:strSql];
    NSMutableArray *arrList = [@[] mutableCopy];
    while ([rs next]) {
        RequirePurchaseModel *model = [[RequirePurchaseModel alloc] init];
        model.purchaseID = [rs intForColumn:@"id"];
        model.purchaseUserID = [rs intForColumn:@"userID"];
        model.purchaseTitle = [rs stringForColumn:@"title"];
        model.purchaseInfo = [rs stringForColumn:@"info"];
        model.purchaseTime = [rs stringForColumn:@"purchaseTime"];
        model.purchaseIsPass = [rs intForColumn:@"ispass"];
        model.purchasePassTime = [rs stringForColumn:@"passTime"];
        model.backup = [rs stringForColumn:@"backup"];
        model.purchaseDistrictID = [rs intForColumn:@"distirctID"];
        model.purchaseDistrictName = [rs stringForColumn:@"districtName"];
        model.purchaseUsrName = [rs stringForColumn:@"username"];
        model.purchaseAvatar = [rs stringForColumn:@"avatar"];
        model.purchaseUsrEmail = [rs stringForColumn:@"email"];
        model.purchaseUsrPhone = [rs stringForColumn:@"phone"];
        model.purchaseUsrIsPass = [rs intForColumn:@"userIsPass"];
        model.purchaseCatID = [rs intForColumn:@"catID"];
        model.purchaseCatName = [rs stringForColumn:@"catName"];
        model.purchaseCatPic = [rs stringForColumn:@"catPic"];
#ifdef DEBUG
        NSLog(@"model is %@",model);
#endif
        [arrList addObject:model];
    }
    [db close];
    return arrList;

}

- (void)removeAllRequirePurchaseList
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    NSString *strSql1 = [NSString stringWithFormat:@"DELETE * FROM RequirePurchaseList"];
    BOOL dbSuccess = [db executeUpdate:strSql1];
    if (dbSuccess) {
        NSLog(@"success");
    }
    [db close];
    return ;
}

/**
 *  团购
 */
- (void)insertAllGrouponList:(NSMutableArray *)arrData
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    NSMutableArray *arrValues = [@[] mutableCopy];
    for (GrouponModel *model in arrData) {
        NSString *strValues = [NSString stringWithFormat:@"(%d,'%@','%@',%f,%d,%d,%d,%d)",model.grouponID,model.name,model.picture,model.price,model.number,model.sort,model.isPass,model.isOnSale];
        [arrValues addObject:strValues];
    }
    NSString *strAllValue = [arrValues componentsJoinedByString:@","];
    NSString *strExec = [NSString stringWithFormat:@"insert into grouponList(grouponID, name, picture, price, number, sort, isPass, isOnSale) values %@",strAllValue];
    BOOL dbSuccess = [db executeUpdate:strExec];
    if (dbSuccess) {
        NSLog(@"success");
    }
    [db close];
    db = nil;

}
- (NSMutableArray *)getAllGrouponList
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return [@[] mutableCopy];
    }
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM grouponList"];
    FMResultSet *rs = [db executeQuery:strSql];
    NSMutableArray *arrList = [@[] mutableCopy];
    while ([rs next]) {
        GrouponModel *model = [[GrouponModel alloc] init];
        model.grouponID = [rs intForColumn:@"grouponID"];
        model.name = [rs stringForColumn:@"name"];
        model.picture = [rs stringForColumn:@"picture"];
        model.price = [rs doubleForColumn:@"price"];
        model.number = [rs intForColumn:@"number"];
        model.sort = [rs intForColumn:@"sort"];
        model.isPass = [rs intForColumn:@"isPass"];
        model.isOnSale = [rs intForColumn:@"isOnSale"];
#ifdef DEBUG
        NSLog(@"model is %@",model);
#endif
        [arrList addObject:model];
    }
    [db close];
    return arrList;
}
- (void)removeAllGrouponList
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    // ...
    NSString *strSql1 = [NSString stringWithFormat:@"DELETE * FROM grouponList"];
    BOOL dbSuccess = [db executeUpdate:strSql1];
    if (dbSuccess) {
        NSLog(@"success");
    }
    [db close];
    return ;
}

#pragma mark - 商户
#pragma mark - 商户分类
/**
 CREATE TABLE "MerchantType" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "name" VARCHAR, "picture" VARCHAR, "productNumber" INTEGER, "infoNumber" INTEGER, "sort" INTEGER, "status" INTEGER)
 */
- (void)insertAllMerchantTypes:(NSMutableArray *)arrTypes
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    NSMutableArray *arrValues = [@[] mutableCopy];
    for (MerchantTypeModel *modelType in arrTypes) {
        NSString *strValues = [NSString stringWithFormat:@"(%d,'%@')",modelType.merchantTypeId,modelType.name];
        [arrValues addObject:strValues];
    }
    NSString *strAllValue = [arrValues componentsJoinedByString:@","];
    NSString *strExec = [NSString stringWithFormat:@"insert or replace into MerchantType(id, name ) values %@",strAllValue];
    BOOL dbSuccess = [db executeUpdate:strExec];
    if (dbSuccess) {
        NSLog(@"success");
    }
    [db close];
    db = nil;
}

- (NSMutableArray *)getAllMerchantTypes
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return [@[] mutableCopy];
    }
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM MerchantType"];
    FMResultSet *rs = [db executeQuery:strSql];
    NSMutableArray *arrTypes = [@[] mutableCopy];
    while ([rs next]) {
        MerchantTypeModel *model = [[MerchantTypeModel alloc] init];
        model.merchantTypeId = [rs intForColumn:@"id"];
        model.name = [rs stringForColumn:@"name"];

#ifdef DEBUG
        NSLog(@"model is %@",model);
#endif
        [arrTypes addObject:model];
    }
    [db close];
    return arrTypes;
}

- (void)removeAllMerchantTypes
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    // ...
    NSString *strSql1 = [NSString stringWithFormat:@"DELETE * FROM MerchantType"];
    BOOL dbSuccess = [db executeUpdate:strSql1];
    if (dbSuccess) {
        NSLog(@"success");
    }
    [db close];
    return ;
}

#pragma mark - 商户列表
/**
 CREATE TABLE "MerchantList" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "name" VARCHAR, "address" VARCHAR, "email" VARCHAR, "phone" VARCHAR, "catId" INTEGER, "levelId" INTEGER, "districtId" INTEGER, "avatar" VARCHAR, "catName" VARCHAR, "districtName" VARCHAR, "sort" INTEGER, "status" INTEGER)
 */
- (void)insertAllMerchantList:(NSMutableArray *)arrList withCateId:(NSInteger)catId
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    NSMutableArray *arrValues = [@[] mutableCopy];
    for (MerchantModel *modelMerchant in arrList) {
        NSString *strValues = [NSString stringWithFormat:@"(%d,'%@','%@','%@','%@',%d,%d,%d,'%@','%@','%@')",modelMerchant.merchantUserId,modelMerchant.merchantCompanyName,modelMerchant.merchantCompanyAddr,modelMerchant.merchantEmail,modelMerchant.merchantPhone,modelMerchant.merchantCatId,modelMerchant.merchantLevelId,modelMerchant.merchantDistrictId,modelMerchant.merchantAvatar,modelMerchant.merchantCatName,modelMerchant.merchantDistrictName];
        [arrValues addObject:strValues];
    }
    NSString *strAllValue = [arrValues componentsJoinedByString:@","];
    NSString *strExec = [NSString stringWithFormat:@"insert or replace into MerchantList(id, name, address, email, phone, catId, levelId, districtId, avatar, catName, districtName) values %@",strAllValue];
    BOOL dbSuccess = [db executeUpdate:strExec];
    if (dbSuccess) {
        NSLog(@"success");
    }
    [db close];
    db = nil;
}
- (NSMutableArray *)getAllMerchantListWithCatId:(NSInteger)catId
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return [@[] mutableCopy];
    }
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM MerchantList where catId = %d",catId];
#ifdef DEBUG
    NSLog(@"sql is %@",strSql);
#endif
    FMResultSet *rs = [db executeQuery:strSql];
    NSMutableArray *arrList = [@[] mutableCopy];
    while ([rs next]) {
        MerchantModel *model = [[MerchantModel alloc] init];
        model.merchantUserId = [rs intForColumn:@"id"];
        model.merchantCompanyName = [rs stringForColumn:@"name"];
        model.merchantCompanyAddr = [rs stringForColumn:@"address"];
        model.merchantEmail = [rs stringForColumn:@"email"];
        model.merchantPhone = [rs stringForColumn:@"phone"];
        model.merchantCatId = [rs intForColumn:@"catId"];
        model.merchantLevelId = [rs intForColumn:@"levelId"];
        model.merchantDistrictId = [rs intForColumn:@"districtId"];
        model.merchantAvatar = [rs stringForColumn:@"avatar"];
        model.merchantCatName = [rs stringForColumn:@"catName"];
        model.merchantDistrictName = [rs stringForColumn:@"districtName"];
#ifdef DEBUG
        NSLog(@"model is %@",model);
#endif
        [arrList addObject:model];
    }
    [db close];
    return arrList;
}
- (void)removeAllMerchantListWithCatId:(NSInteger)catId
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    // ...
    NSString *strSql1 = [NSString stringWithFormat:@"DELETE * FROM MerchantList where catId = %d",catId];
    BOOL dbSuccess = [db executeUpdate:strSql1];
    if (dbSuccess) {
        NSLog(@"success");
    }
    [db close];
    return ;
}

#pragma mark - 商品
/**
 CREATE TABLE "ProductType" ("catID" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "name" VARCHAR, "picture" VARCHAR, "product_number" INTEGER, "info_number" INTEGER, "sort" INTEGER, "created" VARCHAR, "modified" VARCHAR, "status" INTEGER)
 */
/**
 *  商品分类
 */
- (void)insertAllProductType:(NSMutableArray *)arrList
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    NSMutableArray *arrValues = [@[] mutableCopy];
    for (ProductCatModel *modelType in arrList) {
        NSString *strValues = [NSString stringWithFormat:@"(%d,'%@','%@',%d,%d, %d,'%@','%@')",modelType.catID,modelType.name,modelType.picture,modelType.product_number,modelType.info_number,modelType.sort,modelType.created,modelType.modified];
        [arrValues addObject:strValues];
    }
    NSString *strAllValue = [arrValues componentsJoinedByString:@","];
    NSString *strExec = [NSString stringWithFormat:@"insert into ProductType(catID, name, picture, product_number, info_number, sort, created, modified) values %@",strAllValue];
    BOOL dbSuccess = [db executeUpdate:strExec];
    if (dbSuccess) {
        NSLog(@"success");
    }
    [db close];
    db = nil;

}
- (NSMutableArray *)getAllProductTypes
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return [@[] mutableCopy];
    }
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM ProductType"];
    FMResultSet *rs = [db executeQuery:strSql];
    NSMutableArray *arrTypes = [@[] mutableCopy];
    while ([rs next]) {
        ProductCatModel *model = [[ProductCatModel alloc] init];
        model.catID = [rs intForColumn:@"catID"];
        model.name = [rs stringForColumn:@"name"];
        model.picture = [rs stringForColumn:@"picture"];
        model.product_number = [rs intForColumn:@"product_number"];
        model.info_number = [rs intForColumn:@"info_number"];
        model.sort = [rs intForColumn:@"sort"];
        model.created = [rs stringForColumn:@"created"];
        model.modified = [rs stringForColumn:@"modified"];
#ifdef DEBUG
        NSLog(@"model is %@",model);
#endif
        [arrTypes addObject:model];
    }
    [db close];
    return arrTypes;
}
- (void)removeAllProductTypes
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    // ...
    NSString *strSql1 = [NSString stringWithFormat:@"DELETE * FROM ProductType"];
    BOOL dbSuccess = [db executeUpdate:strSql1];
    if (dbSuccess) {
        NSLog(@"success");
    }
    [db close];
    return ;
}

/**
 *  商品列表
 *  CREATE TABLE "ProductList" ("productID"1 "productName"2 VARCHAR, "productPicture"3 VARCHAR, "price"4 FLOAT, "productNum"5 INTEGER, "productClick"6 INTEGER, "districtID"7 INTEGER, "productCatID"8 INTEGER, "userID" 9INTEGER, "releaseDate"10 VARCHAR, "isPass"11 INTEGER, "backup"12 TEXT, "isOnSale"13 INTEGER, "districtName"14 VARCHAR, "productCatName"15 VARCHAR, "username"16 VARCHAR, "userEmail" 17VARCHAR, "avatar"18 VARCHAR, "userPhone"19 VARCHAR, "companyName" 20VARCHAR, "companyAddr"21 VARCHAR)
 */
- (void)insertAllProductList:(NSMutableArray *)arrList withCatId:(NSInteger)catId
{
    FMDatabase *db = [FMDatabase databaseWithPath:[AppDelegate getCacheDatabasePath]];
    if (![db open]) {
        // error
        return ;
    }
    NSMutableArray *arrValues = [@[] mutableCopy];
    for (ProductModel *modelPro in arrList) {
        NSString *strValues = [NSString stringWithFormat:@"(%ld,'%@','%@',%f,%ld,%ld,%ld,%ld,%ld,'%@',%ld,'%@',%ld,'%@','%@','%@','%@','%@','%@','%@','%@')",modelPro.productID,modelPro.productName,modelPro.productPicture,modelPro.price,modelPro.productNum,modelPro.productClick,modelPro.districtID,modelPro.productCatID,modelPro.userID,modelPro.releaseDate,modelPro.isPass,modelPro.backup,modelPro.isOnSale,modelPro.DistrictName,modelPro.productCatName,modelPro.username,modelPro.userEmail,modelPro.avatar,modelPro.userPhone,modelPro.companyName,modelPro.companyAddr];
        [arrValues addObject:strValues];
    }
    NSString *strAllValue = [arrValues componentsJoinedByString:@","];
    NSString *strExec = [NSString stringWithFormat:@"insert into ProductList(productID, name, address, email, phone, catId, levelId, districtId, avatar, catName, districtName) values %@",strAllValue];
    BOOL dbSuccess = [db executeUpdate:strExec];
    if (dbSuccess) {
        NSLog(@"success");
    }
    [db close];
    db = nil;
}
- (NSMutableArray *)getAllProductListWithCatId:(NSInteger)catId
{
    
}
- (void)removeAllProductListWithCatId:(NSInteger)catId
{
    
}

@end
