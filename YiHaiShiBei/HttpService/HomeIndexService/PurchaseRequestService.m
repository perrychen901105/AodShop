//
//  PurchaseRequestService.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/13.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "PurchaseRequestService.h"

@implementation PurchaseRequestService

static NSString *ActionAllPurchaseList = @"productPurchaseList";
static NSString *ActionAllGrouponList  = @"getGroupPurchases";
static NSString *ActionAllReplyPurchaseList = @"getProductPurchasesReplies";
static NSString *ActionAddReplyPurchase = @"addProductPurchasesReply";

- (void)getAllPurchaseListWithUserId:(NSInteger)userID districtID:(NSInteger)districtID productCatId:(NSInteger)productCatID start:(NSInteger)start num:(NSInteger)num success:(GetAllPurchaseListSuccessBlock)successBlock error:(GetAllPurchaseListFailBlock)errorBlock;
{
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    if (userID > 0) {
        dicParas[@"userid"] = [NSString stringWithFormat:@"%d",userID];
    }
    if (districtID > 0) {
        dicParas[@"districtid"] = [NSString stringWithFormat:@"%d",districtID];
    }
    if (productCatID > 0) {
        dicParas[@"productcatid"] = [NSString stringWithFormat:@"%d",productCatID];
    }
    if (start > 0) {
        dicParas[@"start"] = [NSString stringWithFormat:@"%d",start];
    }
    if (num > 0) {
        dicParas[@"start"] = [NSString stringWithFormat:@"%d",num];
    }
    [self postRequestToServer:ActionAllPurchaseList dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

// 获取所有团购列表
- (void)getAllGrouponList:(NSInteger)districtID isPass:(NSInteger)isPass isOnsale:(NSInteger)isOnsale start:(NSInteger)start num:(NSInteger)num success:(GetAllGrouponListSuccessBlock)successBlock error:(GetAllGrouponListFailBlock)errorBlock
{
    NSMutableString *strGetGrouponList = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@""]];
    if (districtID < 0) {
        districtID = 0;
    }
    if (isPass != 0) {
        isPass = 1;
    }
    if (isOnsale != 0) {
        isOnsale = 1;
    }
    [strGetGrouponList appendFormat:@"/%d/%d/%d",districtID,isPass,isOnsale];
    if (start >= 0) {
        [strGetGrouponList appendFormat:@"/%d",start];
    }
    if (num >= 0) {
        [strGetGrouponList appendFormat:@"/%d",num];
    }
    
    [self getRequestToServer:ActionAllGrouponList requestPara:strGetGrouponList success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

- (void)getAllReplyPurchaseListWithParas:(NSMutableDictionary *)dicParas success:(GetAllReplyPurchaseListSuccessBlock)successBlock error:(GetAllReplyPurchaseListFailBlock)errorBlock;
{
    [self postRequestToServer:ActionAllReplyPurchaseList dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

// 评论求购信息
- (void)postReplyWithParas:(NSMutableDictionary *)dicParas success:(GetAllReplyPurchaseListSuccessBlock)successBlock error:(GetAllReplyPurchaseListFailBlock)errorBlock
{
    [self postRequestToServer:ActionAddReplyPurchase dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

@end
