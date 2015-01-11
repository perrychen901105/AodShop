//
//  MerchantViewModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MerchantModel.h"
#import "MerchantRequestService.h"

typedef enum EnumMerchantRequestType
{
    TypeMerchantRequestAllMTypeList = 10,
    TypeMerchantRequestAllMerchantList,
    TypeMerchantRequestMerchantDetail
}EnumMerchantRequestType;

@protocol MerchantViewModelDelegate <NSObject>

- (void)merchantHttpSuccessWithTag:(EnumMerchantRequestType)typeRequest;
- (void)merchantHttpError:(NSInteger)errorCode errMsg:(NSString *)errorStr withType:(EnumMerchantRequestType)typeRequest;

@end

@interface MerchantViewModel : NSObject

@property (nonatomic, weak) id<MerchantViewModelDelegate> delegate;
@property (nonatomic, strong) MerchantRequestService *merchantService;
@property (nonatomic, strong) NSMutableArray *arrMerchantType;
@property (nonatomic, strong) NSMutableArray *arrMerchantList;
@property (nonatomic, strong) MerchantModel *merchantModel;

- (void)getMerchantTypeListWithStart:(NSInteger)numStart count:(NSInteger)numCount;
- (void)getMerchantListWithCatId:(NSInteger)catID districtID:(NSInteger)districtID Start:(NSInteger)numStart count:(NSInteger)numCount;
- (void)getMerchantDetailWithUserID:(NSInteger)userID;

- (void)getCachedMerchantType;
- (void)getCachedMerchantListWithCatId:(NSInteger)catId;

@end
