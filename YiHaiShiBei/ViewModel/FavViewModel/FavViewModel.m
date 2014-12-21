//
//  FavViewModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/20.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "FavViewModel.h"
#import "FavModel.h"
@implementation FavViewModel

- (void)getAllFavListWithUserID:(NSInteger)userid appKey:(NSString *)appKey typeID:(NSInteger)typeID start:(NSInteger)start num:(NSInteger)num
{
    if (self.favService) {
        self.favService = nil;
    }
    self.favService = [[FavRequestService alloc] init];
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",userid] forKey:@"userid"];
    [dicParas setObject:appKey forKey:@"appkey"];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",typeID] forKey:@"typeid"];
    if (start >= 0) {
        [dicParas setObject:[NSString stringWithFormat:@"%ld",start] forKey:@"start"];
    }
    if (num >= 0) {
        [dicParas setObject:[NSString stringWithFormat:@"%ld",num] forKey:@"number"];
    }
    __weak FavViewModel *weakSelf = self;
    [self.favService getAllMyFavListWithParas:dicParas success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            weakSelf.arrALlFavList = [@[] mutableCopy];
            for (NSDictionary *dic in dicRoot[@"data"][@"Collection"]) {
                if (typeID == 1) {  // product
                    ProductFavModel *model = [[ProductFavModel alloc] initWithDictionary:dic error:nil];
                    [weakSelf.arrALlFavList addObject:model];
                } else if (typeID == 2) {   // merchant
                    MerchantFavModel *model = [[MerchantFavModel alloc] initWithDictionary:dic error:nil];
                    [weakSelf.arrALlFavList addObject:model];
                } else if (typeID == 3) {   // groupon
                    GrouponFavModel *model = [[GrouponFavModel alloc] initWithDictionary:dic error:nil];
                    [weakSelf.arrALlFavList addObject:model];
                } else {    // info
                    InfoFavModel *model = [[InfoFavModel alloc] initWithDictionary:dic error:nil];
                    [weakSelf.arrALlFavList addObject:model];
                }
            }
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(favHttpSuccessWithTag:)]) {
                weakSelf.didChangeIndex = typeID;
                [weakSelf.delegate favHttpSuccessWithTag:FavRequestAllList];
            }
        } else {
            if (weakSelf && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(favHttpErrorWithCode:errMessage:type:)]) {
                [weakSelf.delegate favHttpErrorWithCode:intResponseCode errMessage:strResponseMsg type:FavRequestAllList];
            }
        }
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        if (weakSelf && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(favHttpErrorWithCode:errMessage:type:)]) {
            [weakSelf.delegate favHttpErrorWithCode:errorCode errMessage:errorMsg type:FavRequestAllList];
        }
    }];
}


- (void)changeUserFavWithType:(NSInteger)type userID:(NSInteger)userid appKey:(NSString *)appKey typeid:(NSInteger)typeId detailID:(NSInteger)detailID
{
    if (self.favService) {
        self.favService = nil;
    }
    self.favService = [[FavRequestService alloc] init];
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",userid] forKey:@"userid"];
    [dicParas setObject:appKey forKey:@"appkey"];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",typeId] forKey:@"typeid"];
    if (type == 1) {
        [dicParas setObject:[NSString stringWithFormat:@"%ld",detailID] forKey:@"collectionid"];
        [self.favService addUserFavWithParas:dicParas success:^(NSString *strResponse) {
            
        } error:^(NSInteger errorCode, NSString *errorMsg) {
            
        }];
    } else {
        [dicParas setObject:[NSString stringWithFormat:@"%ld",detailID] forKey:@"modelid"];
    }
    
}

@end
