//
//  UserModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/5.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "UserModel.h"
#import "JSONKeyMapper.h"

@implementation UserModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"data.User.id":@"userId",
                                                       @"data.User.username":@"username",
                                                       @"data.User.appkey":@"appkey",
                                                       @"data.User.is_pass":@"is_pass"
                                                       }];
}

@end
