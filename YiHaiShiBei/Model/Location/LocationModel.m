//
//  LocationModel.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-28.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "LocationModel.h"
#import "JSONKeyMapper.h"

@implementation LocationModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"City":@"arrCity"
                                                       }];
}

@end

@implementation ProvinceModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"provinceID"
                                                       }];
}
@end

@implementation CityModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"cityID",
                                                       @"District": @"arrDistrict"
                                                       }];
}
@end

@implementation DistrinctModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"districtID"
                                                       }];
}

@end

@implementation LocationBaseModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"data": @"arrLocation"
                                                       }];
}
@end
