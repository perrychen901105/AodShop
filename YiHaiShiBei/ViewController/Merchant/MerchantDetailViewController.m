//
//  MerchantDetailViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/22.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MerchantDetailViewController.h"
#import "ASStarRatingView.h"
#import "AppConfig.h"
#import "FavViewModel.h"
#import "UIImageView+WebCache.h"
#import "ASStarRatingView.h"
#import "RegisterRootViewController.h"
#import "MerchantViewModel.h"
#import "productInfoCell.h"
#import "ProductModel.h"
#import "ProductDetailViewController.h"

@interface MerchantDetailViewController ()<FavViewModelDelegate, MerchantViewModelDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imgViewAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet ASStarRatingView *viewStar;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UITextView *tvMerchantDetail;

@property (weak, nonatomic) IBOutlet UIView *viewPhone;
@property (weak, nonatomic) IBOutlet UIView *viewMail;
@property (weak, nonatomic) IBOutlet UIView *viewAddr;
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@property (nonatomic, strong) FavViewModel *viewModelFav;
@property (nonatomic, strong) MerchantViewModel *viewModelMerchant;

- (IBAction)btnpresed_phoneCall:(id)sender;
- (IBAction)btnpressed_email:(id)sender;

@end

@implementation MerchantDetailViewController

- (void)setDetailContent
{
    if (self.viewModelMerchant.merchantModel.merchantLevelId < 0) {
        self.viewStar.hidden = YES;
    } else {
        self.viewStar.canEdit = NO;
        self.viewStar.maxRating = 5;
        self.viewStar.rating = self.viewModelMerchant.merchantModel.merchantLevelId;
    }
    
    self.lblName.text = self.viewModelMerchant.merchantModel.merchantCompanyName;
    self.lblPhone.text = self.viewModelMerchant.merchantModel.merchantPhone;
    self.lblAddress.text = self.viewModelMerchant.merchantModel.merchantCompanyAddr;
    [self.imgViewAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,self.viewModelMerchant.merchantModel.merchantAvatar]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
    
}

- (void)setupMerchantProducts
{
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addFavFunc:(id)sender
{
    if (self.apps.storedUserID <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请登录" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        alert.tag = 1;
        [alert show];
        return;
    }
    [self showProgressLabelHud:@"正在添加收藏..." withView:self.view];
    [self.viewModelFav changeUserFavWithType:1 userID:self.apps.storedUserID appKey:self.apps.stroedAppKey typeid:TYPE_FAV_MERCHANT detailID:self.viewModelMerchant.merchantModel.merchantUserId];
}

- (void)setFavButtonItem
{
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAdd.frame = CGRectMake(0, 0, 30, 30);
    [btnAdd setTitle:@"收藏" forState:UIControlStateNormal];
    [btnAdd setTitleColor:COLOR_TITLE_DEFAULT forState:UIControlStateNormal];
    [btnAdd.titleLabel setFont:[UIFont systemFontOfSize:13]];
//    [btnAdd setBackgroundImage:[UIImage imageNamed:@"btn_orange"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(addFavFunc:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemFav = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
    
    UIButton *btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
    btnShare.frame = CGRectMake(0, 0, 30, 30);
    [btnShare setTitle:@"分享" forState:UIControlStateNormal];
    [btnShare setTitleColor:COLOR_TITLE_DEFAULT forState:UIControlStateNormal];
    [btnShare.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [btnShare addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemShare = [[UIBarButtonItem alloc] initWithCustomView:btnShare];
    self.navigationItem.rightBarButtonItems = @[itemFav, itemShare];

}

- (void)shareBtnClick:(id)sender
{
    [self shareContent:self.viewModelMerchant.merchantModel.merchantUserName img:[UIImage imageNamed:@"img_banner_default"] url:nil];
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
    [self setNaviBarTitle:@"商家详情"];
    [self setBackButton];
    self.viewModelFav = [[FavViewModel alloc] init];
    self.viewModelFav.delegate = self;
    self.viewModelMerchant = [[MerchantViewModel alloc] init];
    self.viewModelMerchant.delegate = self;
    self.viewPhone.layer.borderColor = [COLOR_TITLE_DEFAULT CGColor];
    self.viewAddr.layer.borderColor = [COLOR_TITLE_DEFAULT CGColor];
    self.viewMail.layer.borderColor = [COLOR_TITLE_DEFAULT CGColor];
    self.viewPhone.layer.borderWidth = self.viewMail.layer.borderWidth = self.viewAddr.layer.borderWidth = 1.0f;
    if (self.loadFromWeb) {
        [self.viewModelMerchant getMerchantDetailWithUserID:self.merchantUsrID];
    } else {
        self.merchantUsrID = self.model.merchantUserId;
        [self.viewModelMerchant getMerchantDetailWithUserID:self.merchantUsrID];
//        self.viewModelMerchant.merchantModel = self.model;
//        [self setDetailContent];
    }
    [self.viewModelMerchant getProductsWithMerchantUserID:self.merchantUsrID];
    [self setFavButtonItem];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fav model methods
- (void)favHttpSuccessWithTag:(EnumFavRequestType)type
{
    if (type == FavRequestAddFav) {
        [self showOnlyLabelHud:@"收藏成功" withView:self.view];
    }
}

- (void)favHttpErrorWithCode:(NSInteger)errorCode errMessage:(NSString *)errorStr type:(EnumFavRequestType)type
{
    if (type == FavRequestAddFav) {
        [self showOnlyLabelHud:errorStr withView:self.view];
    }
}

#pragma mark - Merchant model delegate methods
- (void)merchantHttpSuccessWithTag:(EnumMerchantRequestType)typeRequest
{
    if (typeRequest == TypeMerchantRequestMerchantDetail) {
        [self setDetailContent];
    } else if (typeRequest == TypeMerchantRequestAllProducts) {
        NSLog(@"the table view content is %@",self.viewModelMerchant.arrMerchantProducts);
        [self.tbViewContent reloadData];
    }
}

- (void)merchantHttpError:(NSInteger)errorCode errMsg:(NSString *)errorStr withType:(EnumMerchantRequestType)typeRequest
{
    //FIXME: delete it
    NSLog(@"fail");
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)btnpresed_phoneCall:(id)sender {
    if (self.viewModelMerchant.merchantModel.merchantPhone.length > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.viewModelMerchant.merchantModel.merchantPhone]]];
    }
}

- (IBAction)btnpressed_email:(id)sender {
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    productInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductInfoCell"];
    ProductModel *model = self.viewModelMerchant.arrMerchantProducts[indexPath.row];
    cell.lblTitle.text = [NSString stringWithFormat:@"标题: %@",model.productName];
    cell.lblReleaseTime.text = [NSString stringWithFormat:@"发布时间: %@",model.releaseDate];//model.releaseDate;
    [cell.imgViewPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,model.productPicture]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
    cell.lblPrice.text = [NSString stringWithFormat:@"￥ %.2f",model.price];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelMerchant.arrMerchantProducts.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sbProduct = [UIStoryboard storyboardWithName:@"SupplyIndex" bundle:nil];
    ProductDetailViewController *viewControllerDetail = [sbProduct instantiateViewControllerWithIdentifier:@"ProductDetailViewController"];
    viewControllerDetail.modelProduct = self.viewModelMerchant.arrMerchantProducts[indexPath.row];
    [self.navigationController pushViewController:viewControllerDetail animated:YES];
}

#pragma mark - UIAlertview methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UINavigationController *viewControllerRoot = [[UIStoryboard storyboardWithName:@"Register" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        RegisterRootViewController *viewControllerRegister = (RegisterRootViewController *)[[viewControllerRoot viewControllers] objectAtIndex:0];
        __weak typeof(self) weakSelf = self;
        [viewControllerRegister loginDidSuccess:^(BOOL success) {
            [weakSelf addFavFunc:nil];
        }];
        [self.navigationController presentViewController:viewControllerRoot animated:YES completion:^{
        }];
    }
}
@end
