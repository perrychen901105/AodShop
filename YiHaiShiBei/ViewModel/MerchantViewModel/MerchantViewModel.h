//
//  MerchantViewModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MerchantRequestService.h"

typedef enum EnumRequestType
{
    TypeRequestAllMTypeList = 10,
    TypeRequestAllMerchantList
}EnumRequestType;

@protocol MerchantViewModelDelegate <NSObject>

- (void)httpSuccessWithTag:(EnumRequestType)typeRequest;
- (void)httpError:(NSInteger)errorCode errMsg:(NSString *)errorStr withType:(EnumRequestType)typeRequest;

@end

@interface MerchantViewModel : NSObject

@property (nonatomic, weak) id<MerchantViewModelDelegate> delegate;
@property (nonatomic, strong) MerchantRequestService *merchantService;
@property (nonatomic, strong) NSMutableArray *arrMerchantType;
@property (nonatomic, strong) NSMutableArray *arrMerchantList;

- (void)getMerchantTypeListWithStart:(NSInteger)numStart count:(NSInteger)numCount;
- (void)getMerchantListWithCatId:(NSInteger)catID Start:(NSInteger)numStart count:(NSInteger)numCount;

- (void)getCachedMerchantType;
- (void)getCachedMerchantListWithCatId:(NSInteger)catId;

@end
