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
#import "AppConfig.h"
#import "DatabaseOperator.h"
#import "InforDetailViewController.h"

@interface HomeInfoListViewController ()<UITableViewDelegate, UITableViewDataSource, HomeIndexViewModelDelegate>

@property (nonatomic, strong) HomeIndexViewModel *viewModelIndex;

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@end

@implementation HomeInfoListViewController


- (void)getAllInfoList
{
    if (self.viewModelIndex) {
        [self.viewModelIndex getAllInfoList:self.apps.storedDistrictID startNum:-1 num:-1];
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
    [self setNaviBarTitle:@"资讯"];
    [self setBackButton];
    
    __weak HomeInfoListViewController *weakSelf = self;
    [self.tbViewContent addHeaderWithCallback:^{
        [weakSelf getAllInfoList];
    }];
    
    [self.viewModelIndex getCachedInfoList:self.apps.storedDistrictID];
    if (self.viewModelIndex.arrAllInfos.count > 0) {
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segueInfoDetail"]) {
        UITableViewCell *cellSelect = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tbViewContent indexPathForCell:cellSelect];
        InforDetailViewController *viewControllerDetail = (InforDetailViewController *)segue.destinationViewController;
        viewControllerDetail.modelInfo = self.viewModelIndex.arrAllInfos[indexPath.row];
    }
}


#pragma mark - HomeViewModel methods
- (void)httpSuccessWithTag:(EnumRequestType)type
{
    if (self.viewModelIndex.arrAllInfos.count > 0) {
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
    return self.viewModelIndex.arrAllInfos.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
    InformationModel *modelInfo = self.viewModelIndex.arrAllInfos[indexPath.row];
    [cell.imgViewPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,modelInfo.picture]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
    cell.lblTitle.text = modelInfo.title;
    cell.lblContent.text = modelInfo.content;
    cell.lblCreateTime.text = modelInfo.release_date;
    return cell;
}

@end
