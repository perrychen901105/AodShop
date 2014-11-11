//
//  LocationViewModel.h
//  YiHaiShiBei
//
//  Created by qw on 14-11-10.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationModel.h"
#import "HomeIndexService.h"

@protocol LocationIndexViewModelDelegate <NSObject>

- (void)httpSuccess;
- (void)httpError:(NSInteger)errorCode message:(NSString *)errorMessage;

@end

@interface LocationViewModel : NSObject

@property (nonatomic, weak) id<LocationIndexViewModelDelegate> delegate;

@property (nonatomic, strong) HomeIndexService *homeService;

@property (nonatomic, strong) NSMutableArray *arrProvince;

@property (nonatomic, strong) LocationBaseModel *locationModel;

- (void)getAllProvinceList;

- (NSMutableArray *)getAllProvince;
- (NSMutableArray *)getCityWithProvinceID:(NSInteger)provinceID;
- (NSMutableArray *)getAllDistrinctWithCityID:(NSInteger)cityID;

@end
