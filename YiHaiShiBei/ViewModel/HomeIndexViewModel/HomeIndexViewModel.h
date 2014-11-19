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

typedef enum EnumRequestType
{
    TypeRequestAllBanner = 10
}EnumRequestType;

@protocol HomeIndexViewModelDelegate <NSObject>

- (void)httpSuccessWithTag:(EnumRequestType)type;
- (void)httpError:(NSInteger)errorCode message:(NSString *)errorMessage type:(EnumRequestType)type;

@end

@interface HomeIndexViewModel : NSObject

@property (nonatomic, weak) id<HomeIndexViewModelDelegate> delegate;

@property (nonatomic, strong) HomeIndexService *homeService;

@property (nonatomic, strong) NSMutableArray *arrAllBanners;

- (void)getAllBannersList:(NSInteger)distrinctID start:(NSInteger)numStart num:(NSInteger)num;
- (void)getAllInfoList:(NSInteger)distrinctID startNum:(NSInteger)numStart num:(NSInteger)num;
//- (void)
- (void)getAllGrouponList:(NSInteger)districtID isPass:(NSInteger)isPass IsOnsale:(NSInteger)isOnsale start:(NSInteger)numStart num:(NSInteger)num;

@end
