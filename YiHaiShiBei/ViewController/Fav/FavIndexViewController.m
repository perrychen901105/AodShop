//
//  FavIndexViewController.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-22.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "FavIndexViewController.h"
#import "FavViewModel.h"
#import "FavModel.h"
#import "UIImageView+WebCache.h"
#import "AppConfig.h"
#import "favListCell.h"

#import "SearchRootViewController.h"

#import "MerchantModel.h"
#import "ProductModel.h"
#import "GrouponModel.h"
#import "InformationListModel.h"

#import "GrouponDetailViewController.h"
#import "InforDetailViewController.h"
#import "MerchantDetailViewController.h"
@interface FavIndexViewController ()<FavViewModelDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segControlFav;
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@property (nonatomic, strong) FavViewModel *viewModelFav;

@property (nonatomic, assign) NSInteger intSelectFav;

@property (nonatomic, assign) NSInteger intRemovedIndex;

- (IBAction)segValueChanged:(id)sender;

@end

@implementation FavIndexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)searchBtnClick
{
    UIStoryboard *sbSearch = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
    SearchRootViewController *viewControllerRoot = [sbSearch instantiateInitialViewController];
    [self.navigationController presentViewController:viewControllerRoot animated:YES completion:^{
        
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [self.tbViewContent indexPathForSelectedRow];
    if(indexPath) {
        [self.tbViewContent deselectRowAtIndexPath:indexPath animated:YES];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.intSelectFav = 1;
    [self setNaviBarTitle:@"我的收藏"];
    self.viewModelFav = [[FavViewModel alloc] init];
    self.viewModelFav.delegate = self;
    [self getFavList];
    [self setSearchAndCityButton];
    self.tbViewContent.allowsMultipleSelectionDuringEditing = NO;
    self.intRemovedIndex = 0;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)getFavList
{
    if (self.apps.storedUserID <= 0) {
        return;
    }
    [self.viewModelFav getAllFavListWithUserID:self.apps.storedUserID appKey:self.apps.stroedAppKey typeID:self.intSelectFav start:-1 num:-1];
}

- (IBAction)segValueChanged:(id)sender {
    if (self.segControlFav.selectedSegmentIndex == 0) {
        self.intSelectFav = 1;
    } else if (self.segControlFav.selectedSegmentIndex == 1) {
        self.intSelectFav = 4;
    } else if (self.segControlFav.selectedSegmentIndex == 2) {
        self.intSelectFav = 3;
    } else if (self.segControlFav.selectedSegmentIndex == 3) {
        self.intSelectFav = 2;
    }
    [self getFavList];
}

#pragma mark - Fav view model methods
- (void)favHttpErrorWithCode:(NSInteger)errorCode errMessage:(NSString *)errorStr type:(EnumFavRequestType)type
{
    if (type == FavRequestRemoveFav) {
        [self showOnlyLabelHud:errorStr withView:self.view];
    }
}

- (void)favHttpSuccessWithTag:(EnumFavRequestType)type
{
    if (type == FavRequestRemoveFav) {
        [self.viewModelFav.arrALlFavList removeObjectAtIndex:self.intRemovedIndex];
        [self.tbViewContent reloadData];
        self.intRemovedIndex = 0;
        [self showOnlyLabelHud:@"删除成功" withView:self.view];
    } else {
        [self.tbViewContent reloadData];
    }
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    favListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favListCell"];
    if (self.viewModelFav.didChangeIndex == TYPE_FAV_PRODUCT) {
        ProductFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
        [cell.imgViewFav sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,model.productPic]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
        cell.lblTitle.text = model.productName;
        cell.lblContent.text = [NSString stringWithFormat:@"￥ %.2f",model.price];
        cell.lblSubtitle.text = [NSString stringWithFormat:@"添加时间: %@",model.strAddtime];
    } else if(self.viewModelFav.didChangeIndex == TYPE_FAV_MERCHANT) {
        MerchantFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
        [cell.imgViewFav sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,model.merchantPic]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
        cell.lblTitle.text = model.merchantName;
        cell.lblContent.text = [NSString stringWithFormat:@"地址 %@",model.merchantAddr];
        cell.lblSubtitle.text = [NSString stringWithFormat:@"添加时间: %@",model.strAddtime];
    } else if (self.viewModelFav.didChangeIndex == TYPE_FAV_GROUPON) {
        GrouponFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
        [cell.imgViewFav sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,model.grouponPic]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
        cell.lblTitle.text = model.grouponName;
        cell.lblContent.text = [NSString stringWithFormat:@"团购价:￥ %.2f",model.newPrice];
        cell.lblSubtitle.text = [NSString stringWithFormat:@"添加时间: %@",model.strAddtime];
    } else {
        InfoFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
        [cell.imgViewFav sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,model.infoPic]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
        cell.lblTitle.text = model.infoName;
        cell.lblContent.text = @"";
        cell.lblSubtitle.text = [NSString stringWithFormat:@"添加时间: %@",model.strAddtime];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelFav.arrALlFavList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self showProgressLabelHud:@"正在取消" withView:self.view];
        if (self.viewModelFav.didChangeIndex == TYPE_FAV_PRODUCT) {
            ProductFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
            [self.viewModelFav changeUserFavWithType:0 userID:self.apps.storedUserID appKey:self.apps.stroedAppKey typeid:TYPE_FAV_PRODUCT detailID:model.favID];
        } else if (self.viewModelFav.didChangeIndex == TYPE_FAV_MERCHANT) {
            MerchantFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
            [self.viewModelFav changeUserFavWithType:0 userID:self.apps.storedUserID appKey:self.apps.stroedAppKey typeid:TYPE_FAV_MERCHANT detailID:model.favID];
        } else if (self.viewModelFav.didChangeIndex == TYPE_FAV_GROUPON) {
            GrouponFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
            [self.viewModelFav changeUserFavWithType:0 userID:self.apps.storedUserID appKey:self.apps.stroedAppKey typeid:TYPE_FAV_GROUPON detailID:model.favID];
        } else {
            InfoFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
            [self.viewModelFav changeUserFavWithType:0 userID:self.apps.storedUserID appKey:self.apps.stroedAppKey typeid:TYPE_FAV_INFORMATION detailID:model.favID];
        }
        self.intRemovedIndex = indexPath.row;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消收藏";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewModelFav.didChangeIndex == TYPE_FAV_PRODUCT) {
        ProductFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
        
    } else if (self.viewModelFav.didChangeIndex == TYPE_FAV_MERCHANT) {
        MerchantFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
        MerchantModel *modelMerchant = [[MerchantModel alloc] init];
        modelMerchant.merchantLevelId = -1;
        modelMerchant.merchantCompanyName = model.merchantName;
        modelMerchant.merchantPhone = model.merchantPhone;
        modelMerchant.merchantCompanyAddr = model.merchantAddr;
        modelMerchant.merchantAvatar = model.avatar;
        modelMerchant.merchantUserId = model.usreID;
        UIStoryboard *sbMerchant = [UIStoryboard storyboardWithName:@"MerchantPage" bundle:nil];
        MerchantDetailViewController *viewController = [sbMerchant instantiateViewControllerWithIdentifier:@"MerchantDetailViewController"];
        viewController.model = modelMerchant;
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (self.viewModelFav.didChangeIndex == TYPE_FAV_GROUPON) {
        GrouponFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
        GrouponModel *modelGroupon = [[GrouponModel alloc] init];
        modelGroupon.name = model.grouponName;
        modelGroupon.new_price = model.newPrice;
        modelGroupon.number = 0;
        modelGroupon.picture = model.grouponPic;
        modelGroupon.grouponID = model.grouponID;
        UIStoryboard *sbGroupon = [UIStoryboard storyboardWithName:@"HomePage" bundle:nil];
        GrouponDetailViewController *viewController = [sbGroupon instantiateViewControllerWithIdentifier:@"GrouponDetailViewController"];
        viewController.model = modelGroupon;
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        InfoFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
        InformationModel *modelInfo = [[InformationModel alloc] init];
        modelInfo.picture = model.infoPic;
        modelInfo.userName = model.username;
        modelInfo.release_date = @"";
        modelInfo.infoId = model.informationID;
        modelInfo.title = model.infoName;
        modelInfo.content = @"";
        UIStoryboard *sbGroupon = [UIStoryboard storyboardWithName:@"HomePage" bundle:nil];
        InforDetailViewController *viewController = [sbGroupon instantiateViewControllerWithIdentifier:@"InforDetailViewController"];
        viewController.modelInfo = modelInfo;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
