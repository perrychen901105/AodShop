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
                                                       @"GrouppurchaseProduct.user_id":@"name",
                                                       @"GrouppurchaseProduct.title":@"picture",
                                                       @"GrouppurchaseProduct.purchase_info":@"price",
                                                       @"GrouppurchaseProduct.district_id":@"number",
                                                       @"GrouppurchaseProduct.product_cat_id":@"sort",
                                                       @"GrouppurchaseProduct.purchase_time":@"isPass",
                                                       @"GrouppurchaseProduct.is_pass":@"isOnSale"
                                                       }];
}

@end
