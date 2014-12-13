//
//  AppConfig.h
//  YiHaiShiBei
//
//  Created by mac on 14-10-16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#ifndef YiHaiShiBei_AppConfig_h
#define YiHaiShiBei_AppConfig_h

#define DEBUG_X

#define TEXT_WAIT_NETWORK @"请稍等..."
#define TEXT_SUCCESS_NETWORK @"请求成功"

#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)

#define APIHost @"http://www.aodshop.cn/aodshop/index.php/api/"
#define IMGHost @"http://www.aodshop.cn/aodshop/app/webroot/upload/"

#define K_USER_SELECTED_DISTRICT_ID @"userSelectedDistrictId"
#define K_USER_SELECTED_CITY_NAME @"userSelectedCityName"

#define COLOR_TITLE_DEFAULT [UIColor colorWithRed:244/255.0f green:146/255.0f blue:10/255.0f alpha:1.0f]

#endif
