//
//  ProductModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/16.
//  Copyright (c) 2014年 perry. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "JSONModel.h"
@interface ProductModel : JSONModel

@property (nonatomic, assign) NSInteger productID;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productPicture;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSInteger productNum;
@property (nonatomic, assign) NSInteger productClick;
@property (nonatomic, assign) NSInteger districtID;
@property (nonatomic, assign) NSInteger productCatID;
@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, assign) NSInteger isPass;
@property (nonatomic, strong) NSString *backup;
@property (nonatomic, assign) NSInteger isOnSale;
@property (nonatomic, strong) NSString *DistrictName;
@property (nonatomic, strong) NSString *productCatName;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *userPhone;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *companyAddr;

@end

@interface ProductCatModel : JSONModel

@property (nonatomic, assign) NSInteger catID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, assign) NSInteger product_number;
@property (nonatomic, assign) NSInteger info_number;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *modified;

@end
