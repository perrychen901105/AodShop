//
//  AppDelegate.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14-10-15.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "LocationModel.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UserModel *modelUser;

@property (strong, nonatomic) CurrentLocationModel *selectedLocation;

+ (NSString *)getCacheDatabasePath;

@end

