//
//  FavModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/21.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseModel.h"
#import <UIKit/UIKit.h>

@interface FavModel : BaseModel

@end

@interface ProductFavModel : JSONModel

@property (nonatomic, assign) NSInteger favID;
@property (nonatomic, assign) NSInteger usreID;
@property (nonatomic, assign) NSInteger productID;
@property (nonatomic, strong) NSString *strAddtime;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productPic;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *companyAddr;
@property (nonatomic, strong) NSString *releaseDate;

@end

@interface InfoFavModel : JSONModel

@property (nonatomic, assign) NSInteger favID;
@property (nonatomic, assign) NSInteger usreID;
@property (nonatomic, assign) NSInteger informationID;
@property (nonatomic, strong) NSString *strAddtime;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *infoName;
@property (nonatomic, strong) NSString *infoPic;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *releaseDate;

@end

@interface GrouponFavModel : JSONModel

@property (nonatomic, assign) NSInteger favID;
@property (nonatomic, assign) NSInteger usreID;
@property (nonatomic, assign) NSInteger grouponID;
@property (nonatomic, strong) NSString *strAddtime;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *grouponName;
@property (nonatomic, strong) NSString *grouponPic;
@property (nonatomic, assign) CGFloat oriPrice;
@property (nonatomic, assign) CGFloat newPrice;
@property (nonatomic, assign) NSInteger number;

@end

@interface MerchantFavModel : JSONModel

@property (nonatomic, assign) NSInteger favID;
@property (nonatomic, assign) NSInteger usreID;
@property (nonatomic, assign) NSInteger merchantID;
@property (nonatomic, strong) NSString *strAddtime;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *merchantName;
@property (nonatomic, strong) NSString *merchantUserName;
@property (nonatomic, strong) NSString *merchantPic;
@property (nonatomic, strong) NSString *merchantEmail;
@property (nonatomic, strong) NSString *merchantPhone;
@property (nonatomic, strong) NSString *merchantAddr;
@property (nonatomic, assign) NSInteger levelID;

@end
