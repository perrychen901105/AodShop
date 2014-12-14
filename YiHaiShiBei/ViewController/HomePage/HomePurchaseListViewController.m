//
//  HomePurchaseListViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/19.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HomePurchaseListViewController.h"
#import "RequirePurchaseModel.h"
#import "PurchaseViewModel.h"
#import "HomePurchaseTableViewCell.h"
#import "MJRefresh.h"
#import "AppConfig.h"

@interface HomePurchaseListViewController ()<UITableViewDataSource, UITableViewDelegate, PurchaseViewModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@property (nonatomic, strong) PurchaseViewModel *viewModelPurchase;

@end

@implementation HomePurchaseListViewController

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModelPurchase = [[PurchaseViewModel alloc]  init];
    self.viewModelPurchase.delegate = self;
    [self setNaviBarTitle:@"求购列表"];
    [self setBackButton];
    
    __weak HomePurchaseListViewController *weakSelf = self;
    [self.tbViewContent addHeaderWithCallback:^{
        if (weakSelf.viewModelPurchase) {
            [weakSelf.viewModelPurchase getAllPurchaseList:self.apps.storedUserID districtID:self.apps.storedDistrictID productCateID:0 start:-1 num:-1];
        }
    }];
    [self.tbViewContent headerBeginRefreshing];
    // Do any additional setup after loading the view.
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

#pragma mark - PurchaseViewModel methods
- (void)purchaseRequestSuccessWithTag:(EnumPurchaseRequestType)type
{
    if (type == TypeRequestAllPurchaseList) {
        [self.tbViewContent reloadData];
    }
    [self.tbViewContent headerEndRefreshing];
}

- (void)purchaseRequestError:(NSInteger)errorCode message:(NSString *)errorMessage type:(EnumPurchaseRequestType)type
{
    if (type == TypeRequestAllPurchaseList) {
        
    }
    [self.tbViewContent headerEndRefreshing];
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePurchaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePurchaseTableViewCell"];
    RequirePurchaseModel *model = self.viewModelPurchase.arrAllPurchaseList[indexPath.row];
    cell.lblTitle.text = [NSString stringWithFormat:@"标题: %@",model.purchaseTitle];
    cell.lblContent.text = [NSString stringWithFormat:@"内容: %@",model.purchaseInfo];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelPurchase.arrAllPurchaseList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
}

@end
