//
//  HomeIndexViewController.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HomeIndexViewController.h"
#import "AppConfig.h"
#import "HomeIndexViewModel.h"
#import "HttpRequestService.h"
#import "ProfileRequestService.h"
#import "RegisterRootViewController.h"
#import "ChooseLocationViewController.h"
#import "ChooseCityProtocol.h"
#import "UIImageView+WebCache.h"
#import "HomeGrouponListViewController.h"
#import "HomeMessageListViewController.h"
#import "SearchRootViewController.h"
#import "MerchantDetailViewController.h"

#import "AdvertiseModel.h"
#import "ProfileViewModel.h"
#import "PurchaseViewModel.h"
@interface HomeIndexViewController ()<ChooseCityProtocol, HomeIndexViewModelDelegate, PurchaseViewModelDelegate>
@property (nonatomic, strong) HomeIndexViewModel *viewModelIndex;

@property (nonatomic, strong) ProfileViewModel *viewModelProfile;
@property (nonatomic, strong) PurchaseViewModel *viewModelPurchase;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewBanner;
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;
@property (weak, nonatomic) IBOutlet UIView *viewNewMsg;

- (IBAction)btnpressed_message:(id)sender;
- (IBAction)btnpressed_infomation:(id)sender;
- (IBAction)btnpressed_purchase:(id)sender;
- (IBAction)btnpressed_groupon:(id)sender;

@end

@implementation HomeIndexViewController

#define SEGUE_GROUPON @"segueHomeGroupon"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)hasNewMessage:(BOOL)boolHasMsg
{
    if (boolHasMsg) {
        self.viewNewMsg.hidden = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.viewModelIndex checkNewMsg:self.apps.storedDistrictID];
}

- (void)searchBtnClick
{
    UIStoryboard *sbSearch = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
    SearchRootViewController *viewControllerRoot = [sbSearch instantiateInitialViewController];
    [self.navigationController presentViewController:viewControllerRoot animated:YES completion:^{
        
    }];
}

- (void)setupBannerView
{
    for (UIView *subView in self.scrollViewBanner.subviews) {
        [subView removeFromSuperview];
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    if (self.viewModelIndex) {
        if (self.viewModelIndex.arrAllBanners.count > 0) {
            
            for (int i = 0; i < self.viewModelIndex.arrAllBanners.count; i++) {
                AdvertiseModel *modelAdvise = self.viewModelIndex.arrAllBanners[i];
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth*i, 0, screenWidth, self.scrollViewBanner.frame.size.height)];
                imgView.contentMode = UIViewContentModeScaleToFill;
                [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,modelAdvise.picture]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
                
                UIButton *btnTap = [UIButton buttonWithType:UIButtonTypeCustom];
                btnTap.frame = imgView.frame;
                [btnTap addTarget:self action:@selector(imgClicked:) forControlEvents:UIControlEventTouchUpInside];
                btnTap.tag = i;
            
                [self.scrollViewBanner addSubview:imgView];
                [self.scrollViewBanner addSubview:btnTap];
                
            }
            self.scrollViewBanner.contentSize = CGSizeMake(screenWidth*self.viewModelIndex.arrAllBanners.count, self.scrollViewBanner.frame.size.height);
            return;
        }
    }
    UIImageView *imgViewShow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_banner_default"]];
    imgViewShow.contentMode = UIViewContentModeScaleToFill;
    imgViewShow.frame = CGRectMake(0, 0, screenWidth, self.scrollViewBanner.frame.size.height) ;
    [self.scrollViewBanner addSubview:imgViewShow];
    self.scrollViewBanner.contentSize = CGSizeMake(screenWidth, imgViewShow.frame.size.height);
}

- (void)imgClicked:(id)sender
{
    UIButton *btnTapped = (UIButton *)sender;
    AdvertiseModel *modelAdvertise = self.viewModelIndex.arrAllBanners[btnTapped.tag];
    
    UIStoryboard *sbMerchant = [UIStoryboard storyboardWithName:@"MerchantPage" bundle:nil];
    MerchantDetailViewController *viewControllerMerchant = [sbMerchant instantiateViewControllerWithIdentifier:@"MerchantDetailViewController"];
    viewControllerMerchant.merchantUsrID = modelAdvertise.user_id;
    viewControllerMerchant.loadFromWeb = YES;
    [self.navigationController pushViewController:viewControllerMerchant animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.viewModelIndex = [[HomeIndexViewModel alloc] init];
    self.viewModelIndex.delegate = self;
    
    self.viewModelPurchase = [[PurchaseViewModel alloc] init];
    self.viewModelPurchase.delegate = self;
    
    self.viewModelProfile = [[ProfileViewModel alloc] init];
    
    self.viewNewMsg.layer.cornerRadius = 5.0f;
    self.viewNewMsg.layer.masksToBounds = YES;
    self.viewNewMsg.hidden = YES;
    
    [self setNaviBarTitle:nil];
    [self setSearchBtn];
    [self setCityBtn];
    [self requestForBannerList];
    
    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:244/255.0f green:146/255.0f blue:10/255.0f alpha:1.0f], UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
    NSString *strPreviousSelectCityName = [[NSUserDefaults standardUserDefaults] objectForKey:K_USER_SELECTED_CITY_NAME];
    if (strPreviousSelectCityName != nil) {
        self.lblCity.text = strPreviousSelectCityName;
    } else {
        self.lblCity.text = @"地址";
    }
//    HttpRequestService *requestUpload = [[HttpRequestService alloc] init];
//    UIImage *imgOne = [UIImage imageNamed:@"tabbar_moreSelected"];
//    NSMutableDictionary *dicPost = [[NSMutableDictionary alloc] init];
//    [dicPost setObject:imgOne forKey:@"1"];
//    [requestUpload postFileToServer:@"uploadAvatar" Datas:dicPost dicParams:nil];
    
    // Do any additional setup after loading the view.
}

- (void)requestForBannerList
{
    [self setupBannerView];
    if (self.apps.storedDistrictID > 0) {
        [self.viewModelIndex getAllBannersList:self.apps.storedDistrictID start:-1 num:-1];
    } else {
//        [self setupBannerView];
    }
}

- (void)userLoginAction
{
    if (self.apps.modelUser) {
        [self.viewModelProfile getUserInfo:[NSString stringWithFormat:@"%d",self.apps.modelUser.userId] appKey:self.apps.modelUser.appkey];
    } else {
        // 未登录
        UINavigationController *viewControllerRoot = [[UIStoryboard storyboardWithName:@"Register" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        [self presentViewController:viewControllerRoot animated:YES completion:^{
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Location methods
- (void)didChooseCity
{
    ChooseLocationViewController *viewControllerCity = [[UIStoryboard storyboardWithName:@"ChooseLocation" bundle:nil] instantiateInitialViewController];
    viewControllerCity.delegate = self;
    [self presentViewController:viewControllerCity animated:YES completion:^{
    }];
}

#pragma mark - Location Protocol
- (void)didSelectCity:(CurrentLocationModel *)modelCurrent
{
//    self.lblCity.text = modelCurrent.strCity;
    [self setCityBtn];
    if (modelCurrent.intDistrinctId > 0) {
        [self requestForBannerList];
    }
}

#pragma mark - IndexViewModel delegate methods
- (void)httpSuccessWithTag:(EnumRequestType)type
{
    if (type == TypeRequestAllBanner) {
        [self setupBannerView];
    }
}

- (void)httpError:(NSInteger)errorCode message:(NSString *)errorMessage type:(EnumRequestType)type
{
    
}

#pragma mark - PurchaseViewModel delegate methods
- (void)purchaseRequestSuccessWithTag:(EnumPurchaseRequestType)type
{
    if (type == TypeRequestAllPurchaseList) {
        
    }
}

- (void)purchaseRequestError:(NSInteger)errorCode message:(NSString *)errorMessage type:(EnumPurchaseRequestType)type
{
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segueToMsgList"]) {
        if (self.viewNewMsg.hidden == NO) {
            HomeMessageListViewController *viewController = segue.destinationViewController;
            viewController.needUpdateList = YES;
            self.viewNewMsg.hidden = YES;
        }
    }
}

#pragma mark - button methods

- (IBAction)btnpressed_message:(id)sender {
//    if (self.apps.storedDistrictID > 0) {
    
    [self performSegueWithIdentifier:@"segueToMsgList" sender:sender];
//    }
//    else {
//        [self showOnlyLabelHud:@"请选择地区" withView:self.view];
//    }
}

- (IBAction)btnpressed_infomation:(id)sender {
//    if (self.apps.storedDistrictID > 0) {
        [self performSegueWithIdentifier:@"segueToInfoList" sender:sender];
//    }
//    else {
//        [self showOnlyLabelHud:@"请选择地区" withView:self.view];
//    }
}

- (IBAction)btnpressed_purchase:(id)sender {
    [self performSegueWithIdentifier:@"seguePurchaseList" sender:sender];
}

- (IBAction)btnpressed_groupon:(id)sender {
    [self performSegueWithIdentifier:SEGUE_GROUPON sender:sender];
}
@end
