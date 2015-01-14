//
//  MerchantViewModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MerchantViewModel.h"
#import "MerchantListModel.h"
#import "DatabaseOperator.h"
#import "ProductModel.h"

@implementation MerchantViewModel

- (void)getMerchantTypeListWithStart:(NSInteger)numStart count:(NSInteger)numCount
{
    if (self.merchantService == nil) {
        self.merchantService = [[MerchantRequestService alloc] init];
    }
    __weak MerchantViewModel *weakSelf = self;
    [self.merchantService getMerchantTypeListWithStartNum:numStart Number:numCount success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
//        MerchantTypeListModel *listModel = [[MerchantTypeListModel alloc] initWithString:strResponse error:nil];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(merchantHttpSuccessWithTag:)]) {
                if (weakSelf.arrMerchantType.count > 0) {
                    [weakSelf.arrMerchantType removeAllObjects];
                }
                for (NSDictionary *dic in dicRoot[@"data"][@"usercatlist"]) {
                    MerchantTypeModel *model = [[MerchantTypeModel alloc] initWithDictionary:dic[@"UserCat"] error:nil];
                    [weakSelf.arrMerchantType addObject:model];
                }
                if (weakSelf.arrMerchantType.count > 0) {
                    [[DatabaseOperator getInstance] insertAllMerchantTypes:weakSelf.arrMerchantType];
                }
                [weakSelf.delegate merchantHttpSuccessWithTag:TypeMerchantRequestAllMTypeList];
            }
        } else {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(merchantHttpError:errMsg:withType:)]) {
                [weakSelf.delegate merchantHttpError:intResponseCode errMsg:strResponseMsg withType:TypeMerchantRequestAllMTypeList];
            }
        }
    } error:^(NSInteger errorCode, NSString *strError) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(merchantHttpError:errMsg:withType:)]) {
            [weakSelf.delegate merchantHttpError:errorCode errMsg:strError withType:TypeMerchantRequestAllMTypeList];
        }
    }];
}


- (void)getMerchantListWithCatId:(NSInteger)catID districtID:(NSInteger)districtID Start:(NSInteger)numStart count:(NSInteger)numCount
{
    if (self.merchantService == nil) {
        self.merchantService = [[MerchantRequestService alloc] init];
    }
    if (self.arrMerchantList == nil) {
        self.arrMerchantList = [[NSMutableArray alloc] init];
    }
    __weak MerchantViewModel *weakSelf = self;
    [self.merchantService getMerchantListWithCatId:catID districtID:(NSInteger)districtID startNum:numStart Number:numCount success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(merchantHttpSuccessWithTag:)]) {
                if (weakSelf.arrMerchantList.count > 0) {
                    [weakSelf.arrMerchantList removeAllObjects];
                }
                for (NSDictionary *dic in dicRoot[@"data"][@"businessList"]) {
                    MerchantModel *model = [[MerchantModel alloc] initWithDictionary:dic error:nil];
                    [weakSelf.arrMerchantList addObject:model];
                }
                if (weakSelf.arrMerchantList.count > 0) {
                    [[DatabaseOperator getInstance] insertAllMerchantList:weakSelf.arrMerchantList withCateId:catID];
                }
                [weakSelf.delegate merchantHttpSuccessWithTag:TypeMerchantRequestAllMerchantList];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(merchantHttpError:errMsg:withType:)]) {
                [weakSelf.delegate merchantHttpError:intResponseCode errMsg:strResponseMsg withType:TypeMerchantRequestAllMerchantList];
            }
        }
    } error:^(NSInteger errorCode, NSString *strError) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(merchantHttpError:errMsg:withType:)]) {
            [weakSelf.delegate merchantHttpError:errorCode errMsg:strError withType:TypeMerchantRequestAllMerchantList];
        }
    }];
}

- (void)getMerchantDetailWithUserID:(NSInteger)userID
{
    if (self.merchantService == nil) {
        self.merchantService = [[MerchantRequestService alloc] init];
    }
    __weak MerchantViewModel *weakSelf = self;
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    dicParas[@"userid"] = [NSString stringWithFormat:@"%d",userID];
    [self.merchantService getMerchantDetail:dicParas success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(merchantHttpSuccessWithTag:)]) {
                if (weakSelf.merchantModel) {
                    weakSelf.merchantModel = nil;
                }
                weakSelf.merchantModel = [[MerchantModel alloc] initWithDictionary:dicRoot[@"data"][0] error:nil];
                [weakSelf.delegate merchantHttpSuccessWithTag:TypeMerchantRequestMerchantDetail];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(merchantHttpError:errMsg:withType:)]) {
                [weakSelf.delegate merchantHttpError:intResponseCode errMsg:strResponseMsg withType:TypeMerchantRequestMerchantDetail];
            }
        }
    } error:^(NSInteger errorCode, NSString *strError) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(merchantHttpError:errMsg:withType:)]) {
            [weakSelf.delegate merchantHttpError:errorCode errMsg:strError withType:TypeMerchantRequestMerchantDetail];
        }
    }];
}

- (void)getProductsWithMerchantUserID:(NSInteger)userID
{
    if (self.merchantService == nil) {
        self.merchantService = [[MerchantRequestService alloc] init];
    }
    if (self.arrMerchantProducts == nil) {
        self.arrMerchantProducts = [@[] mutableCopy];
    }
    __weak MerchantViewModel *weakSelf = self;
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    dicParas[@"user_id"] = [NSString stringWithFormat:@"%d",userID];
    [self.merchantService getMerchantProductsWithParameter:dicParas success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(merchantHttpSuccessWithTag:)]) {
                if (weakSelf.arrMerchantList.count > 0) {
                    [weakSelf.arrMerchantList removeAllObjects];
                }
                for (NSDictionary *dicProduct in dicRoot[@"data"][@"productList"]) {
                    ProductModel *model = [[ProductModel alloc] initWithDictionary:dicProduct error:nil];
                    [weakSelf.arrMerchantProducts addObject:model];
                }
                [weakSelf.delegate merchantHttpSuccessWithTag:TypeMerchantRequestAllProducts];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(merchantHttpError:errMsg:withType:)]) {
                [weakSelf.delegate merchantHttpError:intResponseCode errMsg:strResponseMsg withType:TypeMerchantRequestAllProducts];
            }
        }
    } error:^(NSInteger errorCode, NSString *strError) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(merchantHttpError:errMsg:withType:)]) {
            [weakSelf.delegate merchantHttpError:errorCode errMsg:strError withType:TypeMerchantRequestAllProducts];
        }
    }];
}

#pragma mark - get cached methods
- (void)getCachedMerchantType
{
    self.arrMerchantType = [[DatabaseOperator getInstance] getAllMerchantTypes];
}
- (void)getCachedMerchantListWithCatId:(NSInteger)catId
{
    self.arrMerchantList = [[DatabaseOperator getInstance] getAllMerchantListWithCatId:catId];
}
@end
