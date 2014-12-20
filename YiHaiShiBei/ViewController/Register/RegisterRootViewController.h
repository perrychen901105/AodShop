//
//  RegisterRootViewController.h
//  YiHaiShiBei
//
//  Created by mac on 14-10-31.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^UserloginSuccessBlock)(BOOL success);

@interface RegisterRootViewController : BaseViewController<MBProgressHUDDelegate>

@property (nonatomic, strong) UserloginSuccessBlock blockSuccess;

- (void)loginDidSuccess:(UserloginSuccessBlock)blockTemp;

@end
