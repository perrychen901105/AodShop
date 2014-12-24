//
//  BaseViewController.h
//  YiHaiShiBei
//
//  Created by mac on 14-10-16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) AppDelegate *apps;
@property (nonatomic, strong) UILabel *lblCity;

- (void)setNaviBarTitle:(NSString *)navTitle;
- (void)setSearchBtn;
- (void)setCityBtn;
- (void)setUserIconButton;
- (void)setBackButton;

- (void)backAction;
- (void)userLoginAction;

- (void)showProgressLabelHud:(NSString *)str withView:(UIView *)withView;
- (void)showOnlyLabelHud:(NSString *)str withView:(UIView *)withView;

- (void)hideHudWithDelay:(NSInteger)delay;

- (void)addTapGestureOnEmptyView;
- (void)emptyViewTapped;
- (void)didChooseCity;
- (void)searchBtnClick;

@end
