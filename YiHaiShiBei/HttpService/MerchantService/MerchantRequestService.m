//
//  MerchantRequestService.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MerchantRequestService.h"

@implementation MerchantRequestService

static NSString *ActionMerchantTypeList = @"getUserCatList";
static NSString *ActionMerchantList = @"getBusinessListByCat";
static NSString *ActionMerchantDetail = @"getBusinessList/";
static NSString *ActionMerchantProducts = @"getProductByBusiness";

- (void)getMerchantTypeListWithStartNum:(NSInteger)numStart Number:(NSInteger)numCount success:(GetMerchantTypeListSuccessBlock)successBlock error:(GetMerchantTypeListFailBlock)errorBlock
{
    NSMutableString *strRequest = [[NSMutableString alloc] initWithString:@""];
    if (numStart >= 0) {
        [strRequest appendFormat:@"/%d",numStart];
    }
    if (numCount >= 0) {
        [strRequest appendFormat:@"/%d",numCount];
    }
    [self getRequestToServer:ActionMerchantTypeList requestPara:strRequest success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

- (void)getMerchantListWithCatId:(NSInteger)catId districtID:(NSInteger)districtID startNum:(NSInteger)numStart Number:(NSInteger)numCount success:(GetMerchantListSuccessBlock)successBlock error:(GetMerchantListFailBlock)errorBlock
{
    NSMutableString *strRequest = [[NSMutableString alloc] initWithString:@""];
    [strRequest appendFormat:@"/%ld",catId];
    [strRequest appendFormat:@"/%ld",districtID];
    if (numStart >= 0) {
        [strRequest appendFormat:@"/%d",numStart];
    }
    if (numCount >= 0) {
        [strRequest appendFormat:@"/%d",numCount];
    }
    [self getRequestToServer:ActionMerchantList requestPara:strRequest success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

- (void)getMerchantProductsWithParameter:(NSMutableDictionary *)dicPara success:(GetMerchantProductSuccessBlock)successBlock error:(GetMerchantProductFailBlock)errorBlock
{
    NSString *strParas = [NSString stringWithFormat:@"/%d",[dicPara[@"user_id"] intValue]];
    [self getRequestToServer:ActionMerchantProducts requestPara:strParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

- (void)getMerchantDetail:(NSMutableDictionary *)dicPara success:(GetMerchantDetailSuccessBlock)successBlock error:(GetMerchantDetailFailBlock)errorBlock
{
    [self postRequestToServer:ActionMerchantDetail dicParams:dicPara success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

@end
