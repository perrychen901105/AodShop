//
//  ProductCommentModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/23.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ProductCommentModel.h"
#import "JSONKeyMapper.h"
@implementation ProductCommentModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"ProductComment.id":@"commentID",
                                                       @"ProductComment.user_id":@"userID",
                                                       @"ProductComment.product_id":@"productID",
                                                       @"ProductComment.content":@"strContent",
                                                       @"ProductComment.time":@"strTime",
                                                       @"User.username":@"username",
                                                       @"User.avatar":@"avatar"
                                                       }];
}
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end
