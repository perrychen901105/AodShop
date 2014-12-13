//
//  PurchaseViewModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/13.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PurchaseRequestService.h"

typedef enum EnumPurchaseRequestType
{
    TypeRequestAllPurchaseList = 10,
    TypeRequestAllGrouponList
}EnumPurchaseRequestType;

@protocol PurchaseViewModelDelegate <NSObject>

- (void)purchaseRequestSuccessWithTag:(EnumPurchaseRequestType)type;
- (void)purchaseRequestError:(NSInteger)errorCode message:(NSString *)errorMessage type:(EnumPurchaseRequestType)type;

@end

@interface PurchaseViewModel : NSObject

@property (nonatomic, assign) id<PurchaseViewModelDelegate> delegate;

@property (nonatomic, strong) PurchaseRequestService *purchaseService;

@property (nonatomic, strong) NSMutableArray *arrAllPurchaseList;
@property (nonatomic, strong) NSMutableArray *arrAllGrouponList;

- (void)getAllPurchaseList:(NSInteger)userID districtID:(NSInteger)districtID productCateID:(NSInteger)productCatID start:(NSInteger)start num:(NSInteger)num;
- (void)getAllGrouponList:(NSInteger)districtID isPass:(NSInteger)isPass IsOnsale:(NSInteger)isOnsale start:(NSInteger)numStart num:(NSInteger)num;

//- (void)getCachedPurchaseList

@end
