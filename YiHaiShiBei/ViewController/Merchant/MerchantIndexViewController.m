//
//  MerchantIndexViewController.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-22.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MerchantIndexViewController.h"
#import "MerchantListViewController.h"
#import "MerchantViewModel.h"
#import "MerchantModel.h"
#import "MJRefresh.h"
#import "AppConfig.h"
#import "ChooseLocationViewController.h"
#import "ChooseCityProtocol.h"
#import "SearchRootViewController.h"
@interface MerchantIndexViewController ()<ChooseCityProtocol, MerchantViewModelDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) MerchantViewModel *viewModelMerchant;

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;


@end

@implementation MerchantIndexViewController

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
    [self setNaviBarTitle:@"商户"];
    self.viewModelMerchant = [[MerchantViewModel alloc] init];
    self.viewModelMerchant.delegate = self;
    __weak MerchantIndexViewController *weakSelf = self;
    [self.tbViewContent addHeaderWithCallback:^{
        if (weakSelf.viewModelMerchant) {
            [weakSelf.viewModelMerchant getMerchantTypeListWithStart:-1 count:-1];
        }
    }];
    [self.viewModelMerchant getCachedMerchantType];
    if (self.viewModelMerchant.arrMerchantType.count > 0) {
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
//    //    self.lblCity.text = modelCurrent.strCity;
//    [self setSearchAndCityButton];
//    if (modelCurrent.intDistrinctId > 0) {
//        //        [self requestForBannerList];
//    }
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Merchant ViewModel delegate
- (void)merchantHttpSuccessWithTag:(EnumMerchantRequestType)typeRequest
{
    if (typeRequest == TypeMerchantRequestAllMTypeList) {
        if (self.viewModelMerchant.arrMerchantType.count > 0) {
            [self.tbViewContent reloadData];
        }
    }
    [self.tbViewContent headerEndRefreshing];
}

- (void)merchantHttpError:(NSInteger)errorCode errMsg:(NSString *)errorStr withType:(EnumMerchantRequestType)typeRequest
{
    [self.tbViewContent headerEndRefreshing];
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantTypeCell"];
    MerchantTypeModel *modelType = self.viewModelMerchant.arrMerchantType[indexPath.row];
    cell.textLabel.text = modelType.name;
    cell.textLabel.textColor = COLOR_TITLE_DEFAULT;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelMerchant.arrMerchantType.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segueMerchantList"]) {
        UITableViewCell *cellSelect = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tbViewContent indexPathForCell:cellSelect];
        MerchantListViewController *viewControllerListMerchant = (MerchantListViewController *)segue.destinationViewController;
        MerchantTypeModel *modelType = self.viewModelMerchant.arrMerchantType[indexPath.row];
        viewControllerListMerchant.intCatId = modelType.merchantTypeId;
        viewControllerListMerchant.strCatName = modelType.name;
    }
}


@end
