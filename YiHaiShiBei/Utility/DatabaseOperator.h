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

- (void)insertAllLocations:(NSArray *)arrAllLocations;
- (NSMutableArray *)getAllProvinces;
- (NSMutableArray *)getAllCitysWithProvinceId:(NSInteger)provinceId;
- (NSMutableArray *)getAllDistrictsWithCityId:(NSInteger)cityId;
- (void)deleteAllDistricts;


@end
