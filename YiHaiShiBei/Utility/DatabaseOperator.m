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

@end
