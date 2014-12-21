//
//  MerchantListViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/9.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MerchantListViewController.h"
#import "UIImageView+WebCache.h"
#import "ASStarRatingView.h"
#import "MerchantViewModel.h"
#import "MerchantModel.h"
#import "MJRefresh.h"
#import "AppConfig.h"
#import "MerchantInfoCell.h"
#import "MerchantDetailViewController.h"

@interface MerchantListViewController ()<MerchantViewModelDelegate,UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) MerchantViewModel *viewModelMerchant;

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@end

@implementation MerchantListViewController

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
    [self setNaviBarTitle:self.strCatName];
    [self setBackButton];
    
    self.viewModelMerchant = [[MerchantViewModel alloc] init];
    self.viewModelMerchant.delegate = self;
    
    __weak MerchantListViewController *weakSelf = self;
    [self.tbViewContent addHeaderWithCallback:^{
        if (weakSelf.viewModelMerchant) {
            [weakSelf.viewModelMerchant getMerchantListWithCatId:weakSelf.intCatId districtID:self.apps.storedDistrictID Start:-1 count:-1];
        }
    }];
    [self.viewModelMerchant getCachedMerchantListWithCatId:self.intCatId];
    if (self.viewModelMerchant.arrMerchantList.count > 0) {
        [self.tbViewContent reloadData];
    } else {
        [self.tbViewContent headerBeginRefreshing];
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
    if ([segue.identifier isEqualToString:@"segueMerchantDetail"]) {
        UITableViewCell *cellSelect = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tbViewContent indexPathForCell:cellSelect];
        MerchantDetailViewController *viewControllerDetail = (MerchantDetailViewController *)segue.destinationViewController;
        viewControllerDetail.model = self.viewModelMerchant.arrMerchantList[indexPath.row];
    }
}


#pragma mark - Merchant View model methods
- (void)httpError:(NSInteger)errorCode errMsg:(NSString *)errorStr withType:(EnumRequestType)typeRequest
{
    [self.tbViewContent headerEndRefreshing];
}

- (void)httpSuccessWithTag:(EnumRequestType)typeRequest
{
    if (self.viewModelMerchant.arrMerchantList.count > 0) {
        [self.tbViewContent reloadData];
    }
    [self.tbViewContent headerEndRefreshing];
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantInfoCell"];
    MerchantModel *model = self.viewModelMerchant.arrMerchantList[indexPath.row];
    cell.lblMerchantName.text = model.merchantCompanyName;
    cell.lblMerchantPhone.text = model.merchantPhone;
    [cell.imgViewAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,model.merchantAvatar]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
    cell.viewRating.canEdit = NO;
    cell.viewRating.maxRating = 5;
    cell.viewRating.rating = model.merchantLevelId;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelMerchant.arrMerchantList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

@end
