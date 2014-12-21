//
//  MerchantModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/30.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseModel.h"
@protocol MerchantTypeModel <NSObject>

@end


@interface MerchantModel : JSONModel

@property (nonatomic, assign) NSInteger merchantUserId;
@property (nonatomic, strong) NSString *merchantUserName;
@property (nonatomic, strong) NSString *merchantUserRealName;
@property (nonatomic, strong) NSString *merchantCompanyName;
@property (nonatomic, strong) NSString *merchantCompanyAddr;
@property (nonatomic, strong) NSString *merchantEmail;
@property (nonatomic, strong) NSString *merchantPhone;
@property (nonatomic, assign) NSInteger merchantCatId;
@property (nonatomic, assign) NSInteger merchantLevelId;
@property (nonatomic, assign) NSInteger merchantDistrictId;
@property (nonatomic, strong) NSString *merchantAvatar;
@property (nonatomic, strong) NSString *merchantCatName;
@property (nonatomic, strong) NSString *merchantDistrictName;

@end

@interface MerchantTypeModel : JSONModel

@property (nonatomic, assign) NSInteger merchantTypeId;
@property (nonatomic, strong) NSString *name;
//@property (nonatomic, strong) NSString *picture;
//@property (nonatomic, assign) NSInteger product_number;
//@property (nonatomic, assign) NSInteger info_number;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) NSString<Optional> *created;
@property (nonatomic, strong) NSString<Optional> *modified;

@end
