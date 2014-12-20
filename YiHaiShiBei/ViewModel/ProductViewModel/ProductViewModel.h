//
//  ProductViewModel.h
//  YiHaiShiBei
//
//  Created by qw on 14-12-16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductRequestService.h"

typedef enum EnumProductRequestType
{
    ProductRequestAllTypeList = 100,
    ProductRequestAllList,
    ProductRequestAddPurchase
}EnumProductRequestType;

@protocol ProductViewModelDelegate <NSObject>

- (void)productHttpSuccessWithTag:(EnumProductRequestType)typeRequest;
- (void)productHttpError:(NSInteger)errorCode errMsg:(NSString *)errorStr withType:(EnumProductRequestType)typeRequest;

@end

@interface ProductViewModel : NSObject

@property (nonatomic, weak) id<ProductViewModelDelegate> delegate;
@property (nonatomic, strong) ProductRequestService *productService;
@property (nonatomic, strong) NSMutableArray *arrAllProCatList;
@property (nonatomic, strong) NSMutableArray *arrAllProductList;

- (void)getProductTypeListWithStart:(NSInteger)start count:(NSInteger)count;
- (void)getProductListWithCatid:(NSInteger)catID districtID:(NSInteger)districtID start:(NSInteger)start count:(NSInteger)count;
- (void)postToPurchaseWithUsrID:(NSInteger)userid appKey:(NSString *)appKey title:(NSString *)title purchaseInfo:(NSString *)info districtID:(NSInteger)districtID productcatid:(NSInteger)catID;

- (void)getCachedProductTypeList;
- (void)getCachedProductList:(NSInteger)catID;
@end
