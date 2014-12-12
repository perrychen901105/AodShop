//
//  DatabaseOperator.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/23.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DatabaseOperator : NSObject

+ (DatabaseOperator *)getInstance;

#pragma mark - 首页
/**
 location
 */
- (void)insertAllLocations:(NSArray *)arrAllLocations;
- (NSMutableArray *)getAllProvinces;
- (NSMutableArray *)getAllCitysWithProvinceId:(NSInteger)provinceId;
- (NSMutableArray *)getAllDistrictsWithCityId:(NSInteger)cityId;
- (void)deleteAllDistricts;

/**
 information
 */
- (void)insertAllInformations:(NSMutableArray *)arrInfors withDistrictId:(NSInteger)districtid;
- (NSMutableArray *)getAllInformationsWithDistrictId:(NSInteger)districtid;
- (void)removeAllInforsWithDistrictId:(NSInteger)districtid;

/**
 message
 */
- (void)insertAllMessages:(NSMutableArray *)arrMsgs withDistrictId:(NSInteger)districtid;
- (NSMutableArray *)getAllMessagesWithDistrictId:(NSInteger)districtid;
- (void)removeAllMessagesWithDistrictId:(NSInteger)districtid;


#pragma mark - 商户
/**
 MerchantType
 */
- (void)insertAllMerchantTypes:(NSMutableArray *)arrTypes;
- (NSMutableArray *)getAllMerchantTypes;
- (void)removeAllMerchantTypes;

/**
 MerchantList
 */
- (void)insertAllMerchantList:(NSMutableArray *)arrList withCateId:(NSInteger)catId;
- (NSMutableArray *)getAllMerchantListWithCatId:(NSInteger)catId;
- (void)removeAllMerchantListWithCatId:(NSInteger)catId;

@end
