//
//  ProductModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ProductModel.h"
#import "JSONKeyMapper.h"
@implementation ProductModel

@end

@implementation ProductCatModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"catID"
                                                       }];
}
@end
