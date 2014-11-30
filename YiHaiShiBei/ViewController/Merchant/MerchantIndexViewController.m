//
//  MerchantIndexViewController.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-22.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MerchantIndexViewController.h"
#import "MerchantViewModel.h"
@interface MerchantIndexViewController ()<MerchantViewModelDelegate>

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNaviBarTitle:@"商户"];
    self.viewModelMerchant = [[MerchantViewModel alloc] init];
    self.viewModelMerchant.delegate = self;
    [self.viewModelMerchant getMerchantTypeListWithStart:-1 count:-1];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Merchant ViewModel delegate
- (void)httpSuccessWithTag:(EnumRequestType)typeRequest
{
    if (typeRequest == TypeRequestAllMTypeList) {
        
    }
}

- (void)httpError:(NSInteger)errorCode errMsg:(NSString *)errorStr withType:(EnumRequestType)typeRequest
{
    
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

@end
