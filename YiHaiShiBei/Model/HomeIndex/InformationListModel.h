//
//  InformationListModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/2.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseModel.h"

@protocol InformationModel <NSObject>

@end

@interface InformationModel : JSONModel

@property (nonatomic, assign) NSInteger infoId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger district_id;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, strong) NSString *release_date;
@property (nonatomic, assign) NSInteger information_category_id;

@end

@interface InformationListModel : BaseModel

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSArray<InformationModel> *arrInfoList;

@end
