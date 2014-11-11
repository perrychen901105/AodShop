//
//  LocationListViewController.h
//  YiHaiShiBei
//
//  Created by qw on 14-11-11.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^SelectLocationIndexBlock)(NSInteger index);
typedef enum LocationListType
{
    ENUM_LOCATIONLIST_PROVINCE = 0x00000001,
    ENUM_LOCATIONLIST_CITY = 0x00000001 << 2,
    ENUM_LOCATIONLIST_DISTRINCT = 0x00000001 << 4
}enumLocationListType;

@interface LocationListViewController : BaseViewController

@property (nonatomic, strong) NSArray *arrayLocation;

@property (nonatomic, strong) SelectLocationIndexBlock blockSelectedIndex;

@property (nonatomic, strong) NSString *strTitle;

@property (nonatomic, assign) enumLocationListType TypeLocationList;

- (void)HadSelectLocation:(SelectLocationIndexBlock)selectBlock;

@end
