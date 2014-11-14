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
@interface HomeIndexViewController ()<ChooseCityProtocol, UITableViewDataSource, UITableViewDelegate, HomeIndexViewModelDelegate>
@property (nonatomic, strong) HomeIndexViewModel *viewModelIndex;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewBanner;
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;


@end

@implementation HomeIndexViewController

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
            
            return;
        } else {
            
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
    [self setNaviBarTitle:nil];
    
    [self setSearchAndCityButton];
    [self setUserIconButton];
    
    [self setupBannerView];
//    [self.viewModelIndex getAllBannersList:1 start:-1 num:-1];
    
//    HttpRequestService *requestUpload = [[HttpRequestService alloc] init];
//    UIImage *imgOne = [UIImage imageNamed:@"tabbar_moreSelected"];
//    NSMutableDictionary *dicPost = [[NSMutableDictionary alloc] init];
//    [dicPost setObject:imgOne forKey:@"1"];
//    [requestUpload postFileToServer:@"uploadAvatar" Datas:dicPost dicParams:nil];
    
    // Do any additional setup after loading the view.
}

- (void)userLoginAction
{
    UINavigationController *viewControllerRoot = [[UIStoryboard storyboardWithName:@"Register" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [self presentViewController:viewControllerRoot animated:YES completion:^{
        NSLog(@"present success");
    }];
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
    NSLog(@"%@",modelCurrent);
    self.lblCity.text = modelCurrent.city.name;
    if (modelCurrent.distrinct.name.length > 0) {
        [self.viewModelIndex getAllBannersList:modelCurrent.distrinct.districtID start:-1 num:-1];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

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
        [self.viewModelIndex getAllInfoList:-1 num:-1];
    }
}

#pragma mark - HttpService methods
- (void)httpSuccessWithTag:(EnumRequestType)type
{
    if (type == TypeRequestAllBanner) {
        if (self.viewModelIndex.arrAllBanners.count > 0) {
            [self setupBannerView];
        }
    }
}

- (void)httpError:(NSInteger)errorCode message:(NSString *)errorMessage type:(EnumRequestType)type
{
    if (type == TypeRequestAllBanner) {
        
    }
}

@end
