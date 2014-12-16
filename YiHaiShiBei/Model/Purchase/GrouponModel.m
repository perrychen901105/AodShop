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
                                                       @"id":@"grouponID",
                                                       @"name":@"name",
                                                       @"picture":@"picture",
                                                       @"price":@"price",
                                                       @"number":@"number",
                                                       @"sort":@"sort",
                                                       @"is_pass":@"isPass",
                                                       @"is_onsale":@"isOnSale"
                                                       }];
}

@end
