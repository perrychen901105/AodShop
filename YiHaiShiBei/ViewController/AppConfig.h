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

#define APIHost @"http://www.aodshop.cn/api/"
#define IMGHost @"http://aodshop.cn/js/kindeditor/attached/image/"

#define K_USER_SELECTED_DISTRICT_ID @"userSelectedDistrictId"
#define K_USER_SELECTED_CITY_NAME @"userSelectedCityName"

#define K_USER_LOGIN_NAME @"userloginName"
#define K_USER_LOGIN_USERID @"userloginUserID"
#define K_USER_LOGIN_APPKEY @"userloginAppkey"

#define COLOR_TITLE_DEFAULT [UIColor colorWithRed:244/255.0f green:146/255.0f blue:10/255.0f alpha:1.0f]

#define TYPE_FAV_PRODUCT 1
#define TYPE_FAV_MERCHANT 2
#define TYPE_FAV_GROUPON 3
#define TYPE_FAV_INFORMATION 4

#endif
