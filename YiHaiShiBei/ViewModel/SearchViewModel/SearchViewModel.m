//
//  SearchViewModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/21.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "SearchViewModel.h"
#import "InformationListModel.h"
#import "ProductModel.h"
#import "MerchantModel.h"
#import "RequirePurchaseModel.h"

@implementation SearchViewModel
- (void)getAllSearchListWithContent:(NSString *)content type:(NSInteger)type start:(NSInteger)start num:(NSInteger)num
{
    if (self.searchService) {
        self.searchService = nil;
    }
    self.searchService = [[SearchRequestService alloc] init];
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    [dicParas setObject:content forKey:@"content"];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",type] forKey:@"typeid"];
    if (start >= 0) {
        [dicParas setObject:[NSString stringWithFormat:@"%ld",start] forKey:@"start"];
    }
    if (num >= 0) {
        [dicParas setObject:[NSString stringWithFormat:@"%ld",num] forKey:@"number"];
    }
    __weak SearchViewModel *weakSelf = self;
    [self.searchService getAllSearchListWithParas:dicParas success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            weakSelf.arrAllSearchList = [@[] mutableCopy];
            if (type == 1) {
                for (NSDictionary *dic in dicRoot[@"data"][@"Informations"]) {
                    InformationModel *model = [[InformationModel alloc] initWithDictionary:dic[@"Information"] error:nil];
                    [weakSelf.arrAllSearchList addObject:model];
                }
            } else if (type == 2) {
                for (NSDictionary *dic in dicRoot[@"data"][@"Products"]) {
                    ProductModel *model = [[ProductModel alloc] initWithDictionary:dic error:nil];
                    [weakSelf.arrAllSearchList addObject:model];
                }
            } else if (type == 3) {
                for (NSDictionary *dic in dicRoot[@"data"][@"ProductPurchases"]) {
                    RequirePurchaseModel *model = [[RequirePurchaseModel alloc] initWithDictionary:dic error:nil];
                    [weakSelf.arrAllSearchList addObject:model];
                }
            } else {
                for (NSDictionary *dic in dicRoot[@"data"][@"Users"]) {
                    MerchantModel *model = [[MerchantModel alloc] initWithDictionary:dic error:nil];
                    [weakSelf.arrAllSearchList addObject:model];
                }
            }
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(searchHttpSuccessWithTag:)]) {
                weakSelf.intSelectType = type;
                [weakSelf.delegate searchHttpSuccessWithTag:SearchRequestAllList];
            }
        } else {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(searchHttpErrorWithErrorCode:errMessage:type:)]) {
                [weakSelf.delegate searchHttpErrorWithErrorCode:intResponseCode errMessage:strResponseMsg type:SearchRequestAllList];
            }
        }
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(searchHttpErrorWithErrorCode:errMessage:type:)]) {
            [weakSelf.delegate searchHttpErrorWithErrorCode:errorCode errMessage:errorMsg type:SearchRequestAllList];
        }
    }];
}
@end
