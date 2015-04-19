//
//  LicenseViewController.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 4/19/15.
//  Copyright (c) 2015 perry. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^ConfirmLicenseBlock)(BOOL success);

@interface LicenseViewController : BaseViewController
@property (nonatomic, strong) ConfirmLicenseBlock blockSuccess;
@end
