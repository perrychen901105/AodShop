//
//  HomeGrouponListViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/19.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HomeGrouponListViewController.h"
#import "PurchaseViewModel.h"
#import "GrouponModel.h"
#import "MJRefresh.h"
#import "AppConfig.h"

@interface HomeGrouponListViewController ()<UITableViewDataSource, UITableViewDelegate, PurchaseViewModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@property (nonatomic, strong) PurchaseViewModel *viewModelPurchase;

@end

@implementation HomeGrouponListViewController

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBarTitle:@"寻求团购"];
    [self setBackButton];
    self.viewModelPurchase = [[PurchaseViewModel alloc] init];
    self.viewModelPurchase.delegate = self;
    
    __weak HomeGrouponListViewController *weakSelf = self;
    [self.tbViewContent addHeaderWithCallback:^{
        if (weakSelf.viewModelPurchase) {
            [weakSelf.viewModelPurchase getAllGrouponList:self.apps.storedDistrictID isPass:1 IsOnsale:1 start:-1 num:-1];
        }
    }];
    [self.viewModelPurchase getCachedGrouponList];
    if (self.viewModelPurchase.arrAllGrouponList.count > 0) {
        [self.tbViewContent reloadData];
    } else {
        [self.tbViewContent headerBeginRefreshing];
    }
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
- (void)purchaseRequestError:(NSInteger)errorCode message:(NSString *)errorMessage type:(EnumPurchaseRequestType)type
{
    [self.tbViewContent headerEndRefreshing];
}

- (void)purchaseRequestSuccessWithTag:(EnumPurchaseRequestType)type
{
    [self.tbViewContent reloadData];
    [self.tbViewContent headerEndRefreshing];
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellHomeGroupon"];
    cell.textLabel.text = @"a";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
