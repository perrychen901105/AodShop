//
//  ProductViewModel.m
//  YiHaiShiBei
//
//  Created by qw on 14-12-16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ProductViewModel.h"
#import "DatabaseOperator.h"
#import "ProductModel.h"
#import "ProductCommentModel.h"

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
                    [[DatabaseOperator getInstance] removeAllProductTypes];
                    [[DatabaseOperator getInstance] insertAllProductType:weakSelf.arrAllProCatList];
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
- (void)getProductListWithCatid:(NSInteger)catID districtID:(NSInteger)districtID start:(NSInteger)start count:(NSInteger)count
{
    if (self.productService == nil) {
        self.productService = [[ProductRequestService alloc] init];
    }
    __weak ProductViewModel *weakSelf = self;
    [self.productService getProductListWithCatId:catID districtID:districtID start:start num:count success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(productHttpSuccessWithTag:)]) {
                if (weakSelf.arrAllProductList.count > 0) {
                    [weakSelf.arrAllProductList removeAllObjects];
                }
                for (NSDictionary *dic in dicRoot[@"data"][@"productList"]) {
                    ProductModel *model = [[ProductModel alloc] initWithDictionary:dic error:nil];
                    [weakSelf.arrAllProductList addObject:model];
                }
                if (weakSelf.arrAllProductList.count > 0) {
                    [[DatabaseOperator getInstance] removeAllProductListWithCatId:catID];
                    [[DatabaseOperator getInstance] insertAllProductList:weakSelf.arrAllProductList withCatId:catID];
                }
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(productHttpSuccessWithTag:)]) {
                    [weakSelf.delegate productHttpSuccessWithTag:ProductRequestAllList];

                }
            }
        } else {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(productHttpError:errMsg:withType:)]) {
                [weakSelf.delegate productHttpError:intResponseCode errMsg:strResponseMsg withType:ProductRequestAllList];
            }
        }
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(productHttpError:errMsg:withType:)]) {
            [weakSelf.delegate productHttpError:errorCode errMsg:errorMsg withType:ProductRequestAllList];
        }
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

- (void)getProductCommentListWithUsrID:(NSInteger)userid appKey:(NSString *)appKey productID:(NSInteger)productID
{
    if (self.productService == nil) {
        self.productService = [[ProductRequestService alloc] init];
    }
    if (self.arrAllCommentList == nil) {
        self.arrAllCommentList = [@[] mutableCopy];
    }
    __weak ProductViewModel *weakSelf = self;
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",userid] forKey:@"userid"];
    [dicParas setObject:appKey forKey:@"appkey"];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",productID] forKey:@"productid"];
    [self.productService postGetProductCommentListWithParas:dicParas success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(productHttpSuccessWithTag:)]) {
                if (weakSelf.arrAllCommentList.count > 0) {
                    [weakSelf.arrAllCommentList removeAllObjects];
                }
                for (NSDictionary *dic in dicRoot[@"data"][@"comments"]) {
                    ProductCommentModel *model = [[ProductCommentModel alloc] initWithDictionary:dic error:nil];
                    [weakSelf.arrAllCommentList addObject:model];
                }
                [weakSelf.delegate productHttpSuccessWithTag:ProductRequestAllCommentList];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(productHttpError:errMsg:withType:)]) {
                [weakSelf.delegate productHttpError:intResponseCode errMsg:strResponseMsg withType:ProductRequestAllCommentList];
            }
        }
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(productHttpError:errMsg:withType:)]) {
            [weakSelf.delegate productHttpError:errorCode errMsg:errorMsg withType:ProductRequestAllCommentList];
        }
    }];

}

- (void)postProductCommentWithUserID:(NSInteger)userid appKey:(NSString *)appKey productID:(NSInteger)productID content:(NSString *)content
{
    if (self.productService == nil) {
        self.productService = [[ProductRequestService alloc] init];
    }
    __weak ProductViewModel *weakSelf = self;
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",userid] forKey:@"userid"];
    [dicParas setObject:appKey forKey:@"appkey"];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",productID] forKey:@"productid"];
    [dicParas setObject:content forKey:@"content"];
    [self.productService postProductCommentWithPars:dicParas success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(productHttpSuccessWithTag:)]) {
                [weakSelf.delegate productHttpSuccessWithTag:ProductRequestAddComment];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(productHttpError:errMsg:withType:)]) {
                [weakSelf.delegate productHttpError:intResponseCode errMsg:strResponseMsg withType:ProductRequestAddComment];
            }
        }
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(productHttpError:errMsg:withType:)]) {
            [weakSelf.delegate productHttpError:errorCode errMsg:errorMsg withType:ProductRequestAddComment];
        }
    }];
}

- (void)getCachedProductTypeList
{
    if (self.arrAllProCatList == nil) {
        self.arrAllProCatList = [@[] mutableCopy];
    }
    self.arrAllProCatList = [[DatabaseOperator getInstance] getAllProductTypes];
}

- (void)getCachedProductList:(NSInteger)catID
{
    if (self.arrAllProductList == nil) {
        self.arrAllProductList = [@[] mutableCopy];
    }
    self.arrAllProductList = [[DatabaseOperator getInstance] getAllProductListWithCatId:catID];
}
@end
