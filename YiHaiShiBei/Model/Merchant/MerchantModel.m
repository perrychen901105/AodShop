//
//  MerchantModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/30.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MerchantModel.h"
#import "JSONKeyMapper.h"
@implementation MerchantModel

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"User.id":@"merchantUserId",
                                                       @"User.company_name":@"merchantCompanyName",
                                                       @"User.company_addr":@"merchantCompanyAddr",
                                                       @"User.email":@"merchantEmail",
                                                       @"User.phone":@"merchantPhone",
                                                       @"User.user_cat_id":@"merchantCatId",
                                                       @"User.level_id":@"merchantLevelId",
                                                       @"User.district_id":@"merchantDistrictId",
                                                       @"User.avatar":@"merchantAvatar",
                                                       @"UserCat.name":@"merchantCatName",
                                                       @"District.name":@"merchantDistrictName"
                                                       }];
}
@end

@implementation MerchantTypeModel

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"merchantTypeId"
                                                       }];
}

@end
