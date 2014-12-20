//
//  FavViewModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/20.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "FavViewModel.h"

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
    [self.favService getAllMyFavListWithParas:dicParas success:^(NSString *strResponse) {
        
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        
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
