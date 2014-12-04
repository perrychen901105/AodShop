//
//  MsgListModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/4.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MsgListModel.h"
#import "JSONKeyMapper.h"
@implementation MsgModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"msgId"
                                                       }];
}

@end

@implementation MsgListModel

@end
