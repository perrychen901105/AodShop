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

@end

@implementation MerchantTypeModel

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"merchantTypeId"
                                                       }];
}

@end
