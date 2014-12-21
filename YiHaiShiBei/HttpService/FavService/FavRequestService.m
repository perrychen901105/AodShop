//
//  FavRequestService.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/20.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "FavRequestService.h"

@implementation FavRequestService

static NSString *ActionGetFavList = @"getUserCollection";
static NSString *ActionAddFav = @"addUserCollection";
static NSString *ActionRemoveFav = @"deletetUserCollection";

- (void)getAllMyFavListWithParas:(NSMutableDictionary *)dicParas success:(GetAllFavListSuccessBlock)successBlock error:(GetAllFavListFailBlock)errorBlock
{
    [self postRequestToServer:ActionGetFavList dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

- (void)addUserFavWithParas:(NSMutableDictionary *)dicParas success:(AddFaveSuccessBlock)successBlock error:(AddFaveFailBlock)errorBlock
{
    [self postRequestToServer:ActionAddFav dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

- (void)removeUserFavWithParas:(NSMutableDictionary *)dicParas success:(RemoveFaveSuccessBlock)successBlock error:(RemoveFaveFailBlock)errorBlock
{
    [self postRequestToServer:ActionRemoveFav dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

@end
