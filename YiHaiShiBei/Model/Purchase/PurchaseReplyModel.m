//
//  PurchaseReplyModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/21.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "PurchaseReplyModel.h"
#import "JSONKeyMapper.h"
@implementation PurchaseReplyModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"ProductPurchasesReply.id":@"replyID",
                                                       @"ProductPurchasesReply.user_id":@"replyUserID",
                                                       @"ProductPurchasesReply.product_purchase_id":@"replyPurchaseID",
                                                       @"ProductPurchasesReply.content":@"content",
                                                       @"ProductPurchasesReply.time":@"time",
                                                       @"User.username":@"replyUserName",
                                                       @"User.avatar":@"replyUserAvatar",
                                                       @"User.realname":@"replyUserRealName",
                                                       @"User.email":@"replyUserEmail",
                                                       @"ProductPurchase.title":@"replyPurchaseTitle",
                                                       @"ProductPurchase.purchase_info":@"replyPurchaseInfo",
                                                       }];
}
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end
