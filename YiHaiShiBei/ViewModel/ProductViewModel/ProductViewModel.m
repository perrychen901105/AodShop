//
//  ProductViewModel.m
//  YiHaiShiBei
//
//  Created by qw on 14-12-16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ProductViewModel.h"
#import "ProductModel.h"

@implementation ProductViewModel

- (void)getProductTypeListWithStart:(NSInteger)start count:(NSInteger)count
{
    if (self.productService == nil) {
        self.productService = [[ProductRequestService alloc] init];
    }
    if (self.arrAllProCatList == nil) {
        self.arrAllProCatList = [@[] mutableCopy];
    }
    __weak ProductViewModel *weakSelf = self;
    
    [self.productService getProductTypeListWithStart:start number:count success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate &&[weakSelf.delegate respondsToSelector:@selector(productHttpSuccessWithTag:)]) {
                if (weakSelf.arrAllProCatList.count > 0) {
                    [weakSelf.arrAllProCatList removeAllObjects];
                }
                for (NSDictionary *dicProCat in dicRoot[@"data"][@"procatlist"]) {
                    ProductCatModel *modelCat = [[ProductCatModel alloc] initWithDictionary:dicProCat[@"ProductCat"] error:nil];
                    [weakSelf.arrAllProCatList addObject:modelCat];
                }
                if (weakSelf.arrAllProCatList.count > 0) {
                    
                }
                [weakSelf.delegate productHttpSuccessWithTag:ProductRequestAllTypeList];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(productHttpError:errMsg:withType:)]) {
                [weakSelf.delegate productHttpError:intResponseCode errMsg:strResponseMsg withType:ProductRequestAllTypeList];
            }
        }
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(productHttpError:errMsg:withType:)]) {
            [weakSelf.delegate productHttpError:errorCode errMsg:errorMsg withType:ProductRequestAllTypeList];
        }
    }];
}
- (void)getProductListWithCatid:(NSInteger)catID start:(NSInteger)start count:(NSInteger)count
{
    if (self.productService == nil) {
        self.productService = [[ProductRequestService alloc] init];
    }
    __weak ProductViewModel *weakSelf = self;
    [self.productService getProductListWithCatId:catID start:start num:count success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        
    }];
}

- (void)postToPurchaseWithUsrID:(NSInteger)userid appKey:(NSString *)appKey title:(NSString *)title purchaseInfo:(NSString *)info districtID:(NSInteger)districtID productcatid:(NSInteger)catID
{
    if (self.productService == nil) {
        self.productService = [[ProductRequestService alloc] init];
    }
    __weak ProductViewModel *weakSelf = self;
    [self.productService postAddProductPurchaseWithUsrID:userid appKey:appKey title:title purchaseInfo:info districtID:districtID productcatid:catID success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(productHttpSuccessWithTag:)]) {
                [weakSelf.delegate productHttpSuccessWithTag:ProductRequestAddPurchase];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(productHttpError:errMsg:withType:)]) {
                [weakSelf.delegate productHttpError:intResponseCode errMsg:strResponseMsg withType:ProductRequestAllTypeList];
            }
        }
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(productHttpError:errMsg:withType:)]) {
            [weakSelf.delegate productHttpError:errorCode errMsg:errorMsg withType:ProductRequestAllTypeList];
        }
    }];
}

@end
