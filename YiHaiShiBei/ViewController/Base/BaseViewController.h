//
//  BaseViewController.h
//  YiHaiShiBei
//
//  Created by mac on 14-10-16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseCityProtocol.h"
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) id<ChooseCityProtocol> chooseCityDelegate;

@property (nonatomic, strong) MBProgressHUD *HUD;

- (void)setNaviBarTitle:(NSString *)navTitle;
- (void)setSearchAndCityButton;
- (void)setUserIconButton;
- (void)setBackButton;

- (void)backAction;
- (void)userLoginAction;

- (void)showProgressLabelHud:(NSString *)str withView:(UIView *)withView;
- (void)showOnlyLabelHud:(NSString *)str withView:(UIView *)withView;

- (void)hideHudWithDelay:(NSInteger)delay;
@end
