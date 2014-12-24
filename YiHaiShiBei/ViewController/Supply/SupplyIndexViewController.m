//
//  SupplyIndexViewController.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "SupplyIndexViewController.h"
#import "ProductViewModel.h"
#import "ProductModel.h"
#import "MJRefresh.h"
#import "AppConfig.h"
#import "ChooseLocationViewController.h"
#import "ChooseCityProtocol.h"
#import "SupplyListViewController.h"
#import "SearchRootViewController.h"
@interface SupplyIndexViewController ()<ChooseCityProtocol, UITableViewDataSource, UITableViewDelegate, ProductViewModelDelegate>

@property (nonatomic, strong) ProductViewModel *viewModelProduct;

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@end

@implementation SupplyIndexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [self.tbViewContent indexPathForSelectedRow];
    if(indexPath) {
        [self.tbViewContent deselectRowAtIndexPath:indexPath animated:YES];
    }
}
- (void)searchBtnClick
{
    UIStoryboard *sbSearch = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
    SearchRootViewController *viewControllerRoot = [sbSearch instantiateInitialViewController];
    [self.navigationController presentViewController:viewControllerRoot animated:YES completion:^{
        
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNaviBarTitle:@"供应类别"];
    self.viewModelProduct = [[ProductViewModel alloc] init];
    self.viewModelProduct.delegate = self;
    
    __weak SupplyIndexViewController *weakSelf = self;
    [self.tbViewContent addHeaderWithCallback:^{
        if (weakSelf.viewModelProduct) {
            [weakSelf.viewModelProduct getProductTypeListWithStart:-1 count:-1];
        }
    }];
    [self.viewModelProduct getCachedProductTypeList];
    if (self.viewModelProduct.arrAllProCatList.count > 0) {
        [self.tbViewContent reloadData];
    } else {
        [self.tbViewContent headerBeginRefreshing];
    }
    [self setSearchBtn];
    // Do any additional setup after loading the view.
}

#pragma mark - Location methods
- (void)didChooseCity
{
    ChooseLocationViewController *viewControllerCity = [[UIStoryboard storyboardWithName:@"ChooseLocation" bundle:nil] instantiateInitialViewController];
    viewControllerCity.delegate = self;
    [self presentViewController:viewControllerCity animated:YES completion:^{
    }];
}
//#pragma mark - Location Protocol
//- (void)didSelectCity:(CurrentLocationModel *)modelCurrent
//{
//    [self setSearchAndCityButton];
//    if (modelCurrent.intDistrinctId > 0) {
////        [self requestForBannerList];
//    }
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segueSupplyList"]) {
        UITableViewCell *cellSelect = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tbViewContent indexPathForCell:cellSelect];
        SupplyListViewController *viewControllerList = (SupplyListViewController *)segue.destinationViewController;
        ProductCatModel *modelType = self.viewModelProduct.arrAllProCatList[indexPath.row];
        viewControllerList.intCatid = modelType.catID;
        viewControllerList.strCatName = modelType.name;
    }
}


#pragma mark - Product ViewModel delegate
- (void)productHttpSuccessWithTag:(EnumProductRequestType)typeRequest
{
    if (typeRequest == ProductRequestAllTypeList) {
        if (self.viewModelProduct.arrAllProCatList.count > 0) {
            [self.tbViewContent reloadData];
        }
    }
    [self.tbViewContent headerEndRefreshing];
}

- (void)productHttpError:(NSInteger)errorCode errMsg:(NSString *)errorStr withType:(EnumProductRequestType)typeRequest
{
    [self.tbViewContent headerEndRefreshing];
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SupplyTypeCell"];
    ProductCatModel *modelType = self.viewModelProduct.arrAllProCatList[indexPath.row];
    cell.textLabel.text = modelType.name;
    cell.textLabel.textColor = COLOR_TITLE_DEFAULT;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelProduct.arrAllProCatList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
