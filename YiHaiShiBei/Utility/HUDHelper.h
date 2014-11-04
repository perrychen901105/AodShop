//
//  HUDHelper.h
//  tiangou
//
//  Created by admin on 14-4-4.
//  Copyright (c) 2014年 shangdao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface HUDHelper : NSObject
+ (HUDHelper *) getInstance;

@property (nonatomic, strong) MBProgressHUD *HUD;//加载提示器

//提示 成功tip
- (void)showSuccessTipWithLabel:(NSString*)label view:(UIView*)view;

//提示 错误tip
- (void)showErrorTipWithLabel:(NSString*)label view:(UIView*)view;

- (void) showLabelHUD:(NSString *)label view:(UIView*)view;

- (void) hideHUD;


@end
