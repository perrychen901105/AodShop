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

@protocol HomeIndexViewModelDelegate <NSObject>

- (void)httpSuccess;
- (void)httpError:(NSInteger)errorCode message:(NSString *)errorMessage;

@end

@interface HomeIndexViewModel : NSObject

@property (nonatomic, weak) id<HomeIndexViewModelDelegate> delegate;

@property (nonatomic, strong) HomeIndexService *homeService;

@property (nonatomic, strong) NSMutableArray *arrProvince;

@property (nonatomic, strong) LocationBaseModel *locationModel;

- (void)getAllProvinceList;

@end
