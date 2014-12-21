//
//  SearchRootViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/21.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "SearchRootViewController.h"
#import "ASStarRatingView.h"
#import "SearchViewModel.h"
#import "InformationListModel.h"
#import "MerchantModel.h"
#import "ProductModel.h"
#import "RequirePurchaseModel.h"
#import "InfoTableViewCell.h"
#import "productInfoCell.h"
#import "MerchantInfoCell.h"
#import "HomePurchaseTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AppConfig.h"


@interface SearchRootViewController ()<UITableViewDataSource, UITableViewDelegate, SearchViewModelDelegate, UISearchBarDelegate>

@property (nonatomic, strong) SearchViewModel *viewModelSearch;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarContent;
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@property (nonatomic, assign) NSInteger intSelectType;
@property (nonatomic, strong) NSString *strSearchContent;

- (IBAction)segValueChanged:(id)sender;

@end

@implementation SearchRootViewController

- (void)backAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.intSelectType = 1;
    [self setBackButton];
    [self setNaviBarTitle:nil];
    
    self.strSearchContent = @"";
    
    self.viewModelSearch = [[SearchViewModel alloc] init];
    self.viewModelSearch.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getSearchList
{
    if ([self.strSearchContent isEqualToString:@""]) {
        [self showOnlyLabelHud:@"请输入搜索内容..." withView:self.view];
        return;
    }
    [self.viewModelSearch getAllSearchListWithContent:self.strSearchContent type:self.intSelectType start:-1 num:-1];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - SearchViewModel methods
- (void)searchHttpSuccessWithTag:(EnumSearchRequestType)type
{
    [self.tbViewContent reloadData];
}

- (void)searchHttpErrorWithErrorCode:(NSInteger)errorCode errMessage:(NSString *)errorMsg type:(EnumSearchRequestType)type
{
    
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewModelSearch.intSelectType == 1) {
        InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
        InformationModel *modelInfo = self.viewModelSearch.arrAllSearchList[indexPath.row];
        [cell.imgViewPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,modelInfo.picture]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
        cell.lblTitle.text = modelInfo.title;
        cell.lblContent.text = modelInfo.content;
        cell.lblCreateTime.text = modelInfo.release_date;
        return cell;
    } else if (self.viewModelSearch.intSelectType == 2) {
        productInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductInfoCell"];
        ProductModel *model = self.viewModelSearch.arrAllSearchList[indexPath.row];
        cell.lblTitle.text = [NSString stringWithFormat:@"标题: %@",model.productName];
        cell.lblReleaseTime.text = [NSString stringWithFormat:@"发布时间: %@",model.releaseDate];//model.releaseDate;
        [cell.imgViewPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,model.productPicture]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
        cell.lblPrice.text = [NSString stringWithFormat:@"￥ %.2f",model.price];
        return cell;
    } else if (self.viewModelSearch.intSelectType == 3) {
        HomePurchaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePurchaseTableViewCell"];
        RequirePurchaseModel *model = self.viewModelSearch.arrAllSearchList[indexPath.row];
        cell.lblTitle.text = [NSString stringWithFormat:@"标题: %@",model.purchaseTitle];
        cell.lblContent.text = [NSString stringWithFormat:@"内容: %@",model.purchaseInfo];
        return cell;
    } else {
        MerchantInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantInfoCell"];
        MerchantModel *model = self.viewModelSearch.arrAllSearchList[indexPath.row];
        cell.lblMerchantName.text = model.merchantCompanyName;
        cell.lblMerchantPhone.text = model.merchantPhone;
        [cell.imgViewAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,model.merchantAvatar]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
        cell.viewRating.canEdit = NO;
        cell.viewRating.maxRating = 5;
        cell.viewRating.rating = model.merchantLevelId;
        return cell;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelSearch.arrAllSearchList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.intSelectType == 1) {
        return 90.0f;
    } else if (self.intSelectType == 2) {
        return 90.0f;
    } else if (self.intSelectType == 3) {
        return 60.0f;
    } else {
        return 90.0f;
    }
}

#pragma mark - search bar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *strContent = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.strSearchContent = strContent;
    [self getSearchList];
    [searchBar resignFirstResponder];
}

#pragma mark - Seg action
- (IBAction)segValueChanged:(id)sender {
    UISegmentedControl *segControl = (UISegmentedControl *)sender;
    if (segControl.selectedSegmentIndex == 0) {
        self.intSelectType = 1;
    } else if (segControl.selectedSegmentIndex == 1) {
        self.intSelectType = 2;
    } else if (segControl.selectedSegmentIndex == 2) {
        self.intSelectType = 3;
    } else {
        self.intSelectType = 4;
    }
    [self getSearchList];
}
@end
