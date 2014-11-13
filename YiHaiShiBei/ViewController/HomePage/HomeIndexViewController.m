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
@interface HomeIndexViewController ()<ChooseCityProtocol, UITableViewDataSource, UITableViewDelegate>
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.viewModelIndex = [[HomeIndexViewModel alloc] init];
    [self setNaviBarTitle:nil];
    
    [self setSearchAndCityButton];
    [self setUserIconButton];
    
    UIImageView *imgBanner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_banner_default"]];
    
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
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
