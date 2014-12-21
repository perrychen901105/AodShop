//
//  FavViewModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/20.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavRequestService.h"

typedef enum EnumFavRequestType
{
    FavRequestAllList = 100,
    FavRequestAddFav,
    FavRequestRemoveFav
}EnumFavRequestType;

@protocol FavViewModelDelegate <NSObject>

- (void)favHttpSuccessWithTag:(EnumFavRequestType)type;
- (void)favHttpErrorWithCode:(NSInteger)errorCode errMessage:(NSString *)errorStr type:(EnumFavRequestType)type;

@end

@interface FavViewModel : NSObject

@property (nonatomic, weak) id<FavViewModelDelegate> delegate;
@property (nonatomic, assign) NSInteger didChangeIndex;
@property (nonatomic, strong) FavRequestService *favService;
@property (nonatomic, strong) NSMutableArray *arrALlFavList;

- (void)getAllFavListWithUserID:(NSInteger)userid appKey:(NSString *)appKey typeID:(NSInteger)typeID start:(NSInteger)start num:(NSInteger)num;

/**
    type 1 是收藏。 0 是取消收藏
 */
- (void)changeUserFavWithType:(NSInteger)type userID:(NSInteger)userid appKey:(NSString *)appKey typeid:(NSInteger)typeId detailID:(NSInteger)detailID;

@end
