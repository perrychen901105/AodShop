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

@interface PurchaseRequestService : HttpRequestService


// 获取所有求购列表
- (void)getAllPurchaseListWithUserId:(NSInteger)userID districtID:(NSInteger)districtID productCatId:(NSInteger)productCatID start:(NSInteger)start num:(NSInteger)num success:(GetAllPurchaseListSuccessBlock)successBlock error:(GetAllPurchaseListFailBlock)errorBlock;

// 获取所有团购列表
- (void)getAllGrouponList:(NSInteger)districtID isPass:(NSInteger)isPass isOnsale:(NSInteger)isOnsale start:(NSInteger)start num:(NSInteger)num success:(GetAllGrouponListSuccessBlock)successBlock error:(GetAllGrouponListFailBlock)errorBlock;

@end
