//
//  RegisterViewController.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/2.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^UserRegisterSuccessBlock)(BOOL success, NSString *userName, NSString *password);
@interface RegisterViewController : BaseViewController
@property (nonatomic, strong) UserRegisterSuccessBlock blockSuccess;

- (void)registerDidSuccess:(UserRegisterSuccessBlock)blockTemp;
@end
