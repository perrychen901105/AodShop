//
//  LocationListViewController.h
//  YiHaiShiBei
//
//  Created by qw on 14-11-11.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^SelectLocationIndexBlock)(NSInteger index);

@interface LocationListViewController : BaseViewController

@property (nonatomic, strong) NSArray *arrayLocation;

@property (nonatomic, strong) SelectLocationIndexBlock blockSelectedIndex;

@property (nonatomic, strong) NSString *title;

@end
