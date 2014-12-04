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

#pragma mark - Locations
- (void)insertAllLocations:(NSArray *)arrAllLocations
{
    [self deleteAllDistricts];
    NSMutableArray *arrProvinces = [@[] mutableCopy];
    NSMutableArray *arrCitys = [@[] mutableCopy];
    for (NSDictionary *dicLocation in arrAllLocations) {
        [arrProvinces addObject:dicLocation[@"Province"]];
        NSLog(@"dic loaction city is %@",[dicLocation[@"City"] objectAtIndex:0]);
        [arrCitys addObject:[dicLocation[@"City"] objectAtIndex:0]];
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

@end
