//
//  PurchaseModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/13.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "RequirePurchaseModel.h"
#import "JSONKeyMapper.h"
@implementation RequirePurchaseModel

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"ProductPurchase.id":@"purchaseID",
                                                       @"ProductPurchase.user_id":@"purchaseUserID",
                                                       @"ProductPurchase.title":@"purchaseTitle",
                                                       @"ProductPurchase.purchase_info":@"purchaseInfo",
                                                       @"ProductPurchase.district_id":@"purchaseDistrictID",
                                                       @"ProductPurchase.product_cat_id":@"purchaseCatID",
                                                       @"ProductPurchase.purchase_time":@"purchaseTime",
                                                       @"ProductPurchase.is_pass":@"purchaseIsPass",
                                                       @"ProductPurchase.pass_time":@"purchasePassTime",
                                                       @"ProductPurchase.sort":@"sort",
                                                       @"ProductPurchase.backup":@"backup",
                                                       @"User.username":@"purchaseUsrName",
                                                       @"User.avatar":@"purchaseAvatar",
                                                       @"User.email":@"purchaseUsrEmail",
                                                       @"User.phone":@"purchaseUsrPhone",
                                                       @"User.is_pass":@"purchaseUsrIsPass",
                                                       @"District.name":@"purchaseDistrictName",
                                                       @"ProductCat.name":@"purchaseCatName",
                                                       @"ProductCat.picture":@"purchaseCatPic",
                                                       }];
}
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end
