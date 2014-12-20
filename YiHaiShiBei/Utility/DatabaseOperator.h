//
//  DatabaseOperator.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/23.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgListModel.h"
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
- (BOOL)hasNewMsg:(MsgModel *)modelMsg districtID:(NSInteger)districtID;

/**
 求购
 */
- (void)insertAllRequirePurchase:(NSMutableArray *)arrData;
- (NSMutableArray *)getALlRequirePuchaseList;
- (void)removeAllRequirePurchaseList;

/**
 *  团购
 */
- (void)insertAllGrouponList:(NSMutableArray *)arrData;
- (NSMutableArray *)getAllGrouponList;
- (void)removeAllGrouponList;

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

#pragma mark - 商品
/**
 *  商品分类
 */
- (void)insertAllProductType:(NSMutableArray *)arrList;
- (NSMutableArray *)getAllProductTypes;
- (void)removeAllProductTypes;

/**
 *  商品列表
 */
- (void)insertAllProductList:(NSMutableArray *)arrList withCatId:(NSInteger)catId;
- (NSMutableArray *)getAllProductListWithCatId:(NSInteger)catId;
- (void)removeAllProductListWithCatId:(NSInteger)catId;
@end
