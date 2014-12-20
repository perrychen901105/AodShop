//
//  SupplyListViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/17.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "SupplyListViewController.h"
#import "ProductViewModel.h"
#import "MJRefresh.h"
#import "AppConfig.h"
#import "ProductModel.h"
#import "productInfoCell.h"
#import "UIImageView+WebCache.h"


@interface SupplyListViewController ()<ProductViewModelDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ProductViewModel *viewModelProduct;
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@end

@implementation SupplyListViewController

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
    self.viewModelProduct = [[ProductViewModel alloc] init];
    self.viewModelProduct.delegate = self;

    __weak SupplyListViewController *weakSelf = self;
    [self.tbViewContent addHeaderWithCallback:^{
        [weakSelf.viewModelProduct getProductListWithCatid:weakSelf.intCatid districtID:self.apps.storedDistrictID start:-1 count:-1];
    }];
    [self.viewModelProduct getCachedProductList:self.intCatid];
    if (self.viewModelProduct.arrAllProductList.count <= 0) {
        [self.tbViewContent headerBeginRefreshing];
    } else {
        [self.tbViewContent reloadData];
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

#pragma mark - ProductViewmodel methods
- (void)productHttpError:(NSInteger)errorCode errMsg:(NSString *)errorStr withType:(EnumProductRequestType)typeRequest
{
    [self.tbViewContent headerEndRefreshing];
}

- (void)productHttpSuccessWithTag:(EnumProductRequestType)typeRequest
{
    [self.tbViewContent reloadData];
    [self.tbViewContent headerEndRefreshing];
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    productInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductInfoCell"];
    ProductModel *model = self.viewModelProduct.arrAllProductList[indexPath.row];
    cell.lblTitle.text = [NSString stringWithFormat:@"标题: %@",model.productName];
    cell.lblReleaseTime.text = [NSString stringWithFormat:@"发布时间: %@",model.releaseDate];//model.releaseDate;
    [cell.imgViewPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,model.productPicture]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
    cell.lblPrice.text = [NSString stringWithFormat:@"￥ %.2f",model.price];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelProduct.arrAllProductList.count;
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
