//
//  BaseViewController.h
//  YiHaiShiBei
//
//  Created by mac on 14-10-16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseCityProtocol.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) id<ChooseCityProtocol> chooseCityDelegate;

- (void)setNaviBarTitle:(NSString *)navTitle;
- (void)setSearchAndCityButton;
- (void)setUserIconButton;
- (void)setBackButton;

- (void)backAction;
- (void)userLoginAction;

@end
