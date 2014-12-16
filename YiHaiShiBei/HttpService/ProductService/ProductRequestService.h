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

@interface ProductRequestService : HttpRequestService

/**
 *  @brief getProductCatList     get
 *  @paras start, Number
 */

/**
 *  @brief getProductsListByCat     get
 *  @paras start, Number
 */

/**
 *  @brief ddProductPurchase      post
 *  @paras userid, appkey, title, purchaseinfo, districtid, productcatid,content
 */

@end
