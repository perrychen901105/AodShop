//
//  HomeInfoListViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/19.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HomeInfoListViewController.h"
#import "HomeIndexViewModel.h"
#import "InfoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "DatabaseOperator.h"

@interface HomeInfoListViewController ()<UITableViewDelegate, UITableViewDataSource, HomeIndexViewModelDelegate>

@property (nonatomic, strong) HomeIndexViewModel *viewModelIndex;
@property (nonatomic, strong) NSMutableArray *arrInfoList;

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@end

@implementation HomeInfoListViewController


- (void)getAllInfoList
{
    if (self.viewModelIndex) {
        [self.viewModelIndex getAllInfoList:self.apps.selectedLocation.intDistrinctId startNum:-1 num:-1];
        
    }
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModelIndex = [[HomeIndexViewModel alloc] init];
    self.viewModelIndex.delegate = self;
    self.arrInfoList = [[NSMutableArray alloc] init];
//    [self setTitle:@"资讯"];
    [self setNaviBarTitle:@"资讯"];
    [self setBackButton];
    
    __weak HomeInfoListViewController *weakSelf = self;
    [self.tbViewContent addHeaderWithCallback:^{
        [weakSelf getAllInfoList];
    }];
    
    NSMutableArray *arrInfos = [[DatabaseOperator getInstance] getAllInformationsWithDistrictId:self.apps.selectedLocation.intDistrinctId];
    if (arrInfos.count > 0) {
        self.arrInfoList = arrInfos;
        [self.tbViewContent reloadData];
    } else {
        [self.tbViewContent headerBeginRefreshing];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [self.tbViewContent indexPathForSelectedRow];
    if(indexPath) {
        [self.tbViewContent deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - HomeViewModel methods
- (void)httpSuccessWithTag:(EnumRequestType)type
{
    if (self.viewModelIndex.arrAllInfos.count > 0) {
        self.arrInfoList = self.viewModelIndex.arrAllInfos;
        [[DatabaseOperator getInstance] insertAllInformations:self.arrInfoList withDistrictId:self.apps.selectedLocation.intDistrinctId];
        [self.tbViewContent reloadData];
    }
    [self.tbViewContent headerEndRefreshing];
}

- (void)httpError:(NSInteger)errorCode message:(NSString *)errorMessage type:(EnumRequestType)type
{
    [self.tbViewContent headerEndRefreshing];
}

#pragma mark - UITableView methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrInfoList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
    InformationModel *modelInfo = self.arrInfoList[indexPath.row];
    [cell.imgViewPic sd_setImageWithURL:[NSURL URLWithString:modelInfo.picture] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
    cell.lblTitle.text = modelInfo.title;
    cell.lblContent.text = modelInfo.content;
    cell.lblCreateTime.text = modelInfo.release_date;
    return cell;
}

@end
