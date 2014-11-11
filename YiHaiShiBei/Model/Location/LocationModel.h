//
//  LocationModel.h
//  YiHaiShiBei
//
//  Created by mac on 14-10-28.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseModel.h"
#import "JSONModel.h"

@protocol ProvinceModel

@end

@protocol DistrinctModel

@end

@protocol CityModel

@end

@protocol LocationModel

@end

@interface DistrinctModel : JSONModel

@property (nonatomic, assign) NSInteger districtID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger city_id;

@end

@interface ProvinceModel : JSONModel

@property (nonatomic, assign) NSInteger provinceID;
@property (nonatomic, strong) NSString *name;

@end

@interface CityModel : JSONModel

@property (nonatomic, assign) NSInteger cityID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger province_id;
@property (nonatomic, strong) NSArray <DistrinctModel> *arrDistrict;

@end

@interface LocationModel : JSONModel

@property (nonatomic, strong) ProvinceModel *Province;
@property (nonatomic, strong) NSArray<CityModel>*arrCity;

@end

@interface CurrentLocationModel : BaseModel

@property (nonatomic, strong) ProvinceModel *province;
@property (nonatomic, strong) CityModel *city;
@property (nonatomic, strong) DistrinctModel *distrinct;
@property (nonatomic, strong) LocationModel *location;

@end



@interface LocationBaseModel : BaseModel

@property (nonatomic, strong) NSArray<LocationModel>*arrLocation;

@end

