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

#import "AdvertiseModel.h"
#import "ProfileViewModel.h"
@interface HomeIndexViewController ()<ChooseCityProtocol, UITableViewDataSource, UITableViewDelegate, HomeIndexViewModelDelegate>
@property (nonatomic, strong) HomeIndexViewModel *viewModelIndex;

@property (nonatomic, strong) ProfileViewModel *viewModelProfile;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewBanner;
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;


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

- (void)setupBannerView
{
    for (UIView *subView in self.scrollViewBanner.subviews) {
        [subView removeFromSuperview];
    }
    if (self.viewModelIndex) {
        if (self.viewModelIndex.arrAllBanners.count > 0) {
            for (int i = 0; i < self.viewModelIndex.arrAllBanners.count; i++) {
                AdvertiseModel *modelAdvise = self.viewModelIndex.arrAllBanners[i];
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollViewBanner.frame.size.width*i, 0, self.scrollViewBanner.frame.size.width, self.scrollViewBanner.frame.size.height)];
                [imgView sd_setImageWithURL:[NSURL URLWithString:modelAdvise.picture] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
                [self.scrollViewBanner addSubview:imgView];
                
            }
            self.scrollViewBanner.contentSize = CGSizeMake(self.scrollViewBanner.frame.size.width*self.viewModelIndex.arrAllBanners.count, self.scrollViewBanner.frame.size.height);
            return;
        }
    }
    UIImageView *imgViewShow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_banner_default"]];
    
    imgViewShow.contentMode = UIViewContentModeScaleToFill;
    imgViewShow.frame = CGRectMake(0, 0, self.scrollViewBanner.frame.size.width, self.scrollViewBanner.frame.size.height) ;
    [self.scrollViewBanner addSubview:imgViewShow];
    self.scrollViewBanner.contentSize = CGSizeMake(imgViewShow.frame.size.width, imgViewShow.frame.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.viewModelIndex = [[HomeIndexViewModel alloc] init];
    self.viewModelIndex.delegate = self;
    
    self.viewModelProfile = [[ProfileViewModel alloc] init];
    
    [self setNaviBarTitle:nil];
    [self setSearchAndCityButton];
    [self setUserIconButton];
    
    [self requestForBannerList];
    
    NSString *strPreviousSelectCityName = [[NSUserDefaults standardUserDefaults] objectForKey:K_USER_SELECTED_CITY_NAME];
    if (strPreviousSelectCityName != nil) {
        self.lblCity.text = strPreviousSelectCityName;
    } else {
        self.lblCity.text = @"苏州";
    }
//    [self.viewModelIndex getAllBannersList:1 start:-1 num:-1];
    
//    HttpRequestService *requestUpload = [[HttpRequestService alloc] init];
//    UIImage *imgOne = [UIImage imageNamed:@"tabbar_moreSelected"];
//    NSMutableDictionary *dicPost = [[NSMutableDictionary alloc] init];
//    [dicPost setObject:imgOne forKey:@"1"];
//    [requestUpload postFileToServer:@"uploadAvatar" Datas:dicPost dicParams:nil];
    
    // Do any additional setup after loading the view.
}

- (void)requestForBannerList
{
    NSInteger selectedDistrictId = [[[NSUserDefaults standardUserDefaults] objectForKey:K_USER_SELECTED_DISTRICT_ID] intValue];
    if (selectedDistrictId > 0) {
        [self.viewModelIndex getAllBannersList:selectedDistrictId start:-1 num:-1];
    } else {
        [self setupBannerView];
    }
}

- (void)userLoginAction
{
    if (self.apps.modelUser) {
        [self.viewModelProfile getUserInfo:self.apps.modelUser.userId appKey:self.apps.modelUser.appkey];
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
    self.lblCity.text = modelCurrent.strCity;
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:SEGUE_GROUPON]) {
        HomeGrouponListViewController *viewControllerGroupon = segue.destinationViewController;
    }
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexInfoCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndexInfoCell"];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"消息";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"资讯";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"求购";
    } else {
        cell.textLabel.text = @"团购";
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
//        if (self.apps.selectedLocation.distrinct.name.length > 0) {
//            [self.viewModelIndex];
//        } else {
//            [self.viewModelIndex getAllInfoList:0 startNum:-1 num:-1];
//        }
    } else if (indexPath.row == 1) {
        /*
        if (self.apps.selectedLocation.distrinct.name.length > 0) {
            [self.viewModelIndex getAllInfoList:self.apps.selectedLocation.distrinct.districtID startNum:-1 num:-1];
        } else {
            [self.viewModelIndex getAllInfoList:0 startNum:-1 num:-1];
        }
         */
    } else if (indexPath.row == 2) {
        
    } else if (indexPath.row == 3) {
        [self performSegueWithIdentifier:SEGUE_GROUPON sender:indexPath];
    }
}


@end
