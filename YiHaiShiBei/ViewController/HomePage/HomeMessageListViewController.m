//
//  HomeMessageListViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/19.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HomeMessageListViewController.h"
#import "MsgTableViewCell.h"
#import "DatabaseOperator.h"
#import "HomeIndexViewModel.h"
#import "MJRefresh.h"
#import "AppConfig.h"
#import "MsgDetailViewController.h"
#import "UIImageView+WebCache.h"
@interface HomeMessageListViewController ()<UITableViewDataSource, UITableViewDelegate, HomeIndexViewModelDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@property (nonatomic, strong) HomeIndexViewModel *viewModelIndex;

@end

@implementation HomeMessageListViewController

- (void)getAllMsgList
{
    if (self.viewModelIndex) {
        [self.viewModelIndex getAllMsgList:self.apps.storedDistrictID startNum:-1 num:-1];
    }
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [self.tbViewContent indexPathForSelectedRow];
    if(indexPath) {
        [self.tbViewContent deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModelIndex = [[HomeIndexViewModel alloc] init];
    self.viewModelIndex.delegate = self;
    [self setNaviBarTitle:@"消息"];
    [self setBackButton];
    
    __weak HomeMessageListViewController *weakSelf = self;
    [self.tbViewContent addHeaderWithCallback:^{
        [weakSelf getAllMsgList];
    }];
    [self.viewModelIndex getCachedMsgList:self.apps.storedDistrictID];
    if (self.viewModelIndex.arrAllMessages.count > 0) {
        if (self.needUpdateList) {
            [self.tbViewContent headerBeginRefreshing];
        } else {
            [self.tbViewContent reloadData];
        }
    } else {
        [self.tbViewContent headerBeginRefreshing];
    }
    // Do any additional setup after loading the view.
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
    
    if ([segue.identifier isEqualToString:@"segueMsgDetail"]) {
        UITableViewCell *cellSelect = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tbViewContent indexPathForCell:cellSelect];
        MsgDetailViewController *viewControllerDetail = (MsgDetailViewController *)segue.destinationViewController;
        viewControllerDetail.modelMsg = self.viewModelIndex.arrAllMessages[indexPath.row];
    }
}


#pragma mark - Http Request 
- (void)httpError:(NSInteger)errorCode message:(NSString *)errorMessage type:(EnumRequestType)type
{
    [self.tbViewContent headerEndRefreshing];
}

- (void)httpSuccessWithTag:(EnumRequestType)type
{
    if (type == TypeRequestAllMessage) {
        [self.tbViewContent reloadData];
    }
    [self.tbViewContent headerEndRefreshing];
}

#pragma mark - UITableView methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelIndex.arrAllMessages.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgTableViewCell"];
    InformationModel *modelInfo = self.viewModelIndex.arrAllMessages[indexPath.row];
    [cell.imgViewPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,modelInfo.picture]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
    cell.lblTitle.text = modelInfo.title;
    cell.lblContent.text = modelInfo.content;
    cell.lblCreateTime.text = modelInfo.release_date;
    return cell;
}


@end
