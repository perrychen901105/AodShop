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

- (void)insertAllLocations:(NSDictionary *)dicAllLocations
{
    
}

- (void)insertAllProvince:(NSDictionary *)dicAllProvinces
{
    
}

- (void)insertAllCitys:(NSDictionary *)dicAllCitys provinceId:(NSString *)provinceId
{
    
}

- (void)insertAllDistricts:(NSDictionary *)dicAllDistricts cityId:(NSString *)cityId
{
    
}

/*
 FMDatabaseQueue *databaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
 [databaseQueue inDatabase:^(FMDatabase *db){
 [db executeUpdate:@"insert into user values (?,?,?)",@"Ren",@"Male",[NSNumber numberWithInt:20]];
 }];
 [databaseQueue close];
 */

@end
