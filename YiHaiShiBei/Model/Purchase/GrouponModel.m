//
//  GrouponModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/13.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "GrouponModel.h"
#import "JSONKeyMapper.h"
@implementation GrouponModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"GrouppurchaseProduct.id":@"grouponID",
                                                       @"GrouppurchaseProduct.name":@"name",
                                                       @"GrouppurchaseProduct.picture":@"picture",
                                                       @"GrouppurchaseProduct.price":@"price",
                                                       @"GrouppurchaseProduct.number":@"number",
                                                       @"GrouppurchaseProduct.sort":@"sort",
                                                       @"GrouppurchaseProduct.is_pass":@"isPass",
                                                       @"GrouppurchaseProduct.is_onsale":@"isOnSale"
                                                       }];
}

@end
