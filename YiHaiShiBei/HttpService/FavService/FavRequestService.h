//
//  FavRequestService.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/20.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HttpRequestService.h"

typedef void (^GetAllFavListSuccessBlock)(NSString *strResponse);
typedef void (^GetAllFavListFailBlock)(NSInteger errorCode, NSString *errorMsg);

typedef void (^AddFaveSuccessBlock)(NSString *strResponse);
typedef void (^AddFaveFailBlock)(NSInteger errorCode, NSString *errorMsg);

typedef void (^RemoveFaveSuccessBlock)(NSString *strResponse);
typedef void (^RemoveFaveFailBlock)(NSInteger errorCode, NSString *errorMsg);

@interface FavRequestService : HttpRequestService

- (void)getAllMyFavListWithParas:(NSMutableDictionary *)dicParas success:(GetAllFavListSuccessBlock)successBlock error:(GetAllFavListFailBlock)errorBlock;

- (void)addUserFavWithParas:(NSMutableDictionary *)dicParas success:(AddFaveSuccessBlock)successBlock error:(AddFaveFailBlock)errorBlock;

- (void)removeUserFavWithParas:(NSMutableDictionary *)dicParas success:(RemoveFaveSuccessBlock)successBlock error:(RemoveFaveFailBlock)errorBlock;

@end
