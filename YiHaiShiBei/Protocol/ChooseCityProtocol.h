//
//  ChooseCityProtocol.h
//  YiHaiShiBei
//
//  Created by mac on 14-10-22.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationModel.h"
@protocol ChooseCityProtocol <NSObject>



- (void)didSelectCity:(CurrentLocationModel *)modelCurrent;

@end
