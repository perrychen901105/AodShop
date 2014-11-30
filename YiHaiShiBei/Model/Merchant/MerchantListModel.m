//
//  MerchantListModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/30.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MerchantListModel.h"
#import "JSONKeyMapper.h"

@implementation MerchantListModel

@end

@implementation MerchantTypeListModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"data.procatlist.ProductCat":@"arrMerchantType",
                                                       @"data.count":@"count",
                                                       }];
}
@end