//
//  InformationListModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/2.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "InformationListModel.h"
#import "JSONKeyMapper.h"

@implementation InformationModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"infoId"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end

@implementation InformationListModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"data.information.Information":@"arrInfoList",
                                                       @"data.count":@"count"
                                                       }];
}
@end
