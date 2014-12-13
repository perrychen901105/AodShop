//
//  PurchaseModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/13.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "JSONModel.h"

@interface PurchaseModel : JSONModel

@property (nonatomic, assign) NSInteger purchaseID;
@property (nonatomic, assign) NSInteger purchaseUserID;
@property (nonatomic, strong) NSString *purchaseTitle;
@property (nonatomic, strong) NSString *purchaseInfo;
@property (nonatomic, assign) NSInteger purchaseDistrictID;
@property (nonatomic, assign) NSInteger purchaseCatID;
@property (nonatomic, strong) NSString *purchaseTime;
@property (nonatomic, assign) NSInteger purchaseIsPass;
@property (nonatomic, strong) NSString *purchasePassTime;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) NSString *backup;

@property (nonatomic, strong) NSString *purchaseUsrName;
@property (nonatomic, strong) NSString *purchaseAvatar;
@property (nonatomic, strong) NSString *purchaseUsrEmail;
@property (nonatomic, strong) NSString *purchaseUsrPhone;
@property (nonatomic, assign) NSInteger purchaseUsrIsPass;

@property (nonatomic, strong) NSString *purchaseDistrictName;

@property (nonatomic, strong) NSString *purchaseCatName;
@property (nonatomic, strong) NSString *purchaseCatPic;

@end
