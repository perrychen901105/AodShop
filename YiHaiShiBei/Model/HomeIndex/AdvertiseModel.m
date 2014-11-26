//
//  AdvertiseModel.m
//  YiHaiShiBei
//
//  Created by qw on 14-11-26.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "AdvertiseModel.h"
#import "JSONKeyMapper.h"
@implementation AdvertiseModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"advertiseId"
                                                       }];
}
@end
