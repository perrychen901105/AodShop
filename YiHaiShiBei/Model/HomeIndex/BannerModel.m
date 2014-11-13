//
//  BannerModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/13.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BannerModel.h"
#import "JSONKeyMapper.h"
@implementation BannerModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"data.advertisings":@"advertisings",
                                                       @"data.count":@"count",
                                                       }];
}
@end
