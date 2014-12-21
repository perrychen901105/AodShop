//
//  SearchViewModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/21.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchRequestService.h"

typedef enum EnumSearchRequestType
{
    SearchRequestAllList = 100
}EnumSearchRequestType;

@protocol SearchViewModelDelegate <NSObject>

- (void)searchHttpSuccessWithTag:(EnumSearchRequestType)type;
- (void)searchHttpErrorWithErrorCode:(NSInteger)errorCode errMessage:(NSString *)errorMsg type:(EnumSearchRequestType)type;

@end

@interface SearchViewModel : NSObject

@property (nonatomic, weak) id<SearchViewModelDelegate> delegate;
@property (nonatomic, strong) SearchRequestService *searchService;
@property (nonatomic, strong) NSMutableArray *arrAllSearchList;

@property (nonatomic, assign) NSInteger intSelectType;

- (void)getAllSearchListWithContent:(NSString *)content type:(NSInteger)type start:(NSInteger)start num:(NSInteger)num;

@end
