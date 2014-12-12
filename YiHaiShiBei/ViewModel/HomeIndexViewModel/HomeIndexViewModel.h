//
//  HomeIndexViewModel.h
//  YiHaiShiBei
//
//  Created by mac on 14-10-27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeIndexService.h"
#import "LocationModel.h"
#import "InformationListModel.h"
#import "MsgListModel.h"

typedef enum EnumRequestType
{
    TypeRequestAllBanner = 10,
    TypeRequestAllInfo,
    TypeRequestAllMessage
}EnumRequestType;

@protocol HomeIndexViewModelDelegate <NSObject>

- (void)httpSuccessWithTag:(EnumRequestType)type;
- (void)httpError:(NSInteger)errorCode message:(NSString *)errorMessage type:(EnumRequestType)type;

@end

@interface HomeIndexViewModel : NSObject

@property (nonatomic, weak) id<HomeIndexViewModelDelegate> delegate;

@property (nonatomic, strong) HomeIndexService *homeService;

@property (nonatomic, strong) NSMutableArray *arrAllBanners;
@property (nonatomic, strong) NSMutableArray *arrAllInfos;
@property (nonatomic, strong) NSMutableArray *arrAllMessages;

- (void)getAllBannersList:(NSInteger)distrinctID start:(NSInteger)numStart num:(NSInteger)num;
- (void)getAllInfoList:(NSInteger)distrinctID startNum:(NSInteger)numStart num:(NSInteger)num;
- (void)getAllMsgList:(NSInteger)distrinctID startNum:(NSInteger)numStart num:(NSInteger)num;


- (void)getCachedInfoList:(NSInteger)districtID;
- (void)getCachedMsgList:(NSInteger)districtID;

@end
