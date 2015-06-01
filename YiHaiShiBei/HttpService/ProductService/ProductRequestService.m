//
//  ProductRequestService.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ProductRequestService.h"

@implementation ProductRequestService

static NSString *ActionGetProductCatList = @"getProductCatList";
static NSString *ActionGetProductList = @"getProductsListByCat";
static NSString *ActionPostAddPurchase = @"addProductPurchase/";
static NSString *ActionGetProductCommentList = @"getProductComments/";
static NSString *ActionAddProductComment = @"addProductComment/";
static NSString *ActionAddProductClickCount = @"addCountClick/";

- (void)getProductTypeListWithStart:(NSInteger)start number:(NSInteger)num success:(GetAllProductCatListSuccessBlock)successBlock error:(GetAllProductCatListFailBlock)errorBlock
{
    NSMutableString *strRequest = [[NSMutableString alloc] initWithString:@""];
    if (start >= 0) {
        [strRequest appendFormat:@"/%d",start];
    }
    if (num >= 0) {
        [strRequest appendFormat:@"/%d",num];
    }
    [self getRequestToServer:ActionGetProductCatList requestPara:strRequest success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

- (void)getProductListWithCatId:(NSInteger)catId districtID:(NSInteger)districtID start:(NSInteger)start num:(NSInteger)num success:(GetAllProductListSuccessBlock)successBlock error:(GetAllProductListFailBlock)errorBlock
{
    NSMutableString *strRequest = [[NSMutableString alloc] initWithString:@""];
    [strRequest appendFormat:@"/%ld",catId];
    [strRequest appendFormat:@"/%ld",districtID];
    if (start >= 0) {
        [strRequest appendFormat:@"/%ld",start];
    }
    if (num >= 0) {
        [strRequest appendFormat:@"/%ld",num];
    }
    [self getRequestToServer:ActionGetProductList requestPara:strRequest success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

/**
 *  @brief addProductPurchase      post
 *  @paras userid, appkey, title, purchaseinfo, districtid, productcatid,content
 */
- (void)postAddProductPurchaseWithUsrID:(NSInteger)userid appKey:(NSString *)appKey title:(NSString *)title purchaseInfo:(NSString *)info districtID:(NSInteger)districtID productcatid:(NSInteger)catID success:(PostAddPurchaseSuccessBlock)successBlock error:(PostAddPurchaseFailBlock)errorBlock
{
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    dicParas[@"userid"] = [NSString stringWithFormat:@"%d",userid];
    dicParas[@"appkey"] = [NSString stringWithFormat:@"%@",appKey];
    dicParas[@"title"] = [NSString stringWithFormat:@"%@",title];
    dicParas[@"purchaseinfo"] = [NSString stringWithFormat:@"%@",info];
    dicParas[@"districtid"] = [NSString stringWithFormat:@"%d",districtID];
    dicParas[@"productcatid"] = [NSString stringWithFormat:@"%d",catID];
    [self postRequestToServer:ActionPostAddPurchase dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

- (void)postGetProductCommentListWithParas:(NSMutableDictionary *)dicParas success:(PostGetProductCommentSuccessBlock)successBlock error:(PostGetProductCommentFailBlock)errorBlock
{
    [self postRequestToServer:ActionGetProductCommentList dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

- (void)postProductCommentWithPars:(NSMutableDictionary *)dicParas success:(PostAddProductCommentSuccessBlock)successBlock error:(PostAddProductCommentFailBlcok)errorBlock
{
    [self postRequestToServer:ActionAddProductComment dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

- (void)postAddProductClickWithParas:(NSMutableDictionary *)dicParas success:(PostAddProudctClickCountSuccessBlock)successBlock error:(PostAddProductClickCountFailBlock)errorBlock
{
    [self postRequestToServer:ActionAddProductClickCount dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

@end
