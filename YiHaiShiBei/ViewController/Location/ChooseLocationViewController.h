//
//  ChooseLocationViewController.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/9.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseViewController.h"
#import "ChooseCityProtocol.h"
@interface ChooseLocationViewController : BaseViewController<ChooseCityProtocol>

@property (weak, nonatomic) id<ChooseCityProtocol> delegate;

@end
