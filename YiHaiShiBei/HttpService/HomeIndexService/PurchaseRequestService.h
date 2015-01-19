//
//  PurchaseRequestService.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/13.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HttpRequestService.h"

typedef void (^GetAllPurchaseListSuccessBlock)(NSString *strResponse);
typedef void (^GetAllPurchaseListFailBlock)(NSInteger errorCode, NSString *errorMsg);

typedef void (^GetAllGrouponListSuccessBlock)(NSString *strResponse);
typedef void (^GetAllGrouponListFailBlock)(NSInteger errorCode, NSString *errorMsg);

typedef void (^GetAllReplyPurchaseListSuccessBlock)(NSString *strResponse);
typedef void (^GetAllReplyPurchaseListFailBlock)(NSInteger errorCode, NSString *errorMsg);

typedef void (^AddReplyPurchaseSuccessBlock)(NSString *strResponse);
typedef void (^AddReplyPurchaseFailBlock)(NSInteger errorCode, NSString *errorMsg);

typedef void (^JoinGrouponSuccessBlock)(NSString *strResponse);
typedef void (^JoinGrouponFailBlock)(NSInteger errorCode, NSString *errorMsg);

typedef void (^GetGrouponNumberSuccessBlock)(NSString *strResponse);
typedef void (^GetGrouponNumberFailBlock)(NSInteger errorCode, NSString *errorMsg);

@interface PurchaseRequestService : HttpRequestService


// 获取所有求购列表
- (void)getAllPurchaseListWithUserId:(NSInteger)userID districtID:(NSInteger)districtID productCatId:(NSInteger)productCatID start:(NSInteger)start num:(NSInteger)num success:(GetAllPurchaseListSuccessBlock)successBlock error:(GetAllPurchaseListFailBlock)errorBlock;

// 获取所有团购列表
- (void)getAllGrouponList:(NSInteger)districtID isPass:(NSInteger)isPass isOnsale:(NSInteger)isOnsale start:(NSInteger)start num:(NSInteger)num success:(GetAllGrouponListSuccessBlock)successBlock error:(GetAllGrouponListFailBlock)errorBlock;

// 获取产品求购回复列表
- (void)getAllReplyPurchaseListWithParas:(NSMutableDictionary *)dicParas success:(GetAllReplyPurchaseListSuccessBlock)successBlock error:(GetAllReplyPurchaseListFailBlock)errorBlock;

// 评论求购信息
- (void)postReplyWithParas:(NSMutableDictionary *)dicParas success:(GetAllReplyPurchaseListSuccessBlock)successBlock error:(GetAllReplyPurchaseListFailBlock)errorBlock;

// 参加团购接口
- (void)joinGroupPurchase:(NSMutableDictionary *)dicParas success:(JoinGrouponSuccessBlock)successBlock error:(JoinGrouponFailBlock)errorBlock;

// 获取参与团购人数的接口
- (void)getJoinGroupNum:(NSMutableDictionary *)dicParas success:(GetGrouponNumberSuccessBlock)successBlock error:(GetGrouponNumberFailBlock)errorBlock;
@end
