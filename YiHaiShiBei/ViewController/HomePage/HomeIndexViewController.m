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
@interface HomeIndexViewController ()
@property (nonatomic, strong) HomeIndexViewModel *viewModelIndex;
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
//    HttpRequestService *requestUpload = [[HttpRequestService alloc] init];
//    UIImage *imgOne = [UIImage imageNamed:@"tabbar_moreSelected"];
//    NSMutableDictionary *dicPost = [[NSMutableDictionary alloc] init];
//    [dicPost setObject:imgOne forKey:@"1"];
//    [requestUpload postFileToServer:@"uploadAvatar" Datas:dicPost dicParams:nil];
    
    // Do any additional setup after loading the view.
}

- (void)userLoginAction
{
    NSLog(@"login action");
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
    [self presentViewController:viewControllerCity animated:YES completion:^{
    }];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

}


@end
