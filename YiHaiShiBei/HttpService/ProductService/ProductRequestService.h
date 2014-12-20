//
//  ProductRequestService.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HttpRequestService.h"

typedef void (^GetAllProductCatListSuccessBlock)(NSString *strResponse);
typedef void (^GetAllProductCatListFailBlock)(NSInteger errorCode, NSString *errorMsg);

typedef void (^GetAllProductListSuccessBlock)(NSString *strResponse);
typedef void (^GetAllProductListFailBlock)(NSInteger errorCode, NSString *errorMsg);

typedef void (^PostAddPurchaseSuccessBlock)(NSString *strResponse);
typedef void (^PostAddPurchaseFailBlock)(NSInteger errorCode, NSString *errorMsg);

@interface ProductRequestService : HttpRequestService

/**
 *  @brief getProductCatList     get
 *  @paras start, Number
 */
- (void)getProductTypeListWithStart:(NSInteger)start number:(NSInteger)num success:(GetAllProductCatListSuccessBlock)successBlock error:(GetAllProductCatListFailBlock)errorBlock;

/**
 *  @brief getProductsListByCat     get
 *  @paras start, Number Catid
 */
- (void)getProductListWithCatId:(NSInteger)catId districtID:(NSInteger)districtID start:(NSInteger)start num:(NSInteger)num success:(GetAllProductListSuccessBlock)successBlock error:(GetAllProductListFailBlock)errorBlock;


/**
 *  @brief addProductPurchase      post
 *  @paras userid, appkey, title, purchaseinfo, districtid, productcatid,content
 */
- (void)postAddProductPurchaseWithUsrID:(NSInteger)userid appKey:(NSString *)appKey title:(NSString *)title purchaseInfo:(NSString *)info districtID:(NSInteger)districtID productcatid:(NSInteger)catID success:(PostAddPurchaseSuccessBlock)successBlock error:(PostAddPurchaseFailBlock)errorBlock;

@end
