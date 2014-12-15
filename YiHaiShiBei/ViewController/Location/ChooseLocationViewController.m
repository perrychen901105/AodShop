//
//  ChooseLocationViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/9.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ChooseLocationViewController.h"
#import "AppConfig.h"
#import "LocationViewModel.h"
#import "LocationModel.h"
#import "LocationListViewController.h"
#import "DatabaseOperator.h"

@interface ChooseLocationViewController ()<LocationIndexViewModelDelegate>

@property (nonatomic, strong) CurrentLocationModel *selectedLocation;
@property (nonatomic, strong) LocationViewModel *viewModelLocation;
@property (nonatomic, assign) NSInteger intSelectSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControlLocation;

- (IBAction)btnpressed_ConfirmCity:(id)sender;
- (IBAction)btnpressed_CancelCity:(id)sender;
- (IBAction)segBarLocationChanged:(id)sender;

@end

@implementation ChooseLocationViewController

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
    

    self.selectedLocation = [[CurrentLocationModel alloc] init];
    [self getAllLocations];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebService methods
- (void)getAllLocations
{
    if ([[DatabaseOperator getInstance] getAllProvinces].count > 0) {
        
    } else {
        self.viewModelLocation = [[LocationViewModel alloc] init];
        self.viewModelLocation.delegate = self;
        [self showProgressLabelHud:TEXT_WAIT_NETWORK withView:self.view];
        [self.viewModelLocation getAllProvinceList];
    }
    
}

- (void)httpError:(NSInteger)errorCode message:(NSString *)errorMessage
{
    [self showOnlyLabelHud:errorMessage withView:self.view];
}

- (void)httpSuccess
{
    [self showOnlyLabelHud:TEXT_SUCCESS_NETWORK withView:self.view];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"gotoLocationList"]) {
        self.intSelectSeg = self.segControlLocation.selectedSegmentIndex;
        LocationListViewController *viewControllerList = segue.destinationViewController;
        if (self.segControlLocation.selectedSegmentIndex == 0) {
            NSMutableArray *arrProvince = [[DatabaseOperator getInstance] getAllProvinces];
            NSLog(@"%@",arrProvince);
            viewControllerList.arrayLocation = arrProvince;
            viewControllerList.TypeLocationList = ENUM_LOCATIONLIST_PROVINCE;
        } else if (self.segControlLocation.selectedSegmentIndex == 1) {
            NSMutableArray *arrCity = [[DatabaseOperator getInstance] getAllCitysWithProvinceId:self.selectedLocation.intProvinceId];
            viewControllerList.arrayLocation = arrCity;
            viewControllerList.TypeLocationList = ENUM_LOCATIONLIST_CITY;
        } else {
            NSMutableArray *arrDistrict = [[DatabaseOperator getInstance] getAllDistrictsWithCityId:self.selectedLocation.intCityId];
            viewControllerList.arrayLocation = arrDistrict;
            viewControllerList.TypeLocationList = ENUM_LOCATIONLIST_DISTRINCT;
        }
        __weak ChooseLocationViewController *weakSelf = self;
        // 已经选择地址
        [viewControllerList HadSelectLocation:^(NSInteger locationId, NSString *locationName) {
            if (weakSelf.intSelectSeg == 0) {
                weakSelf.selectedLocation.strCity = @"市";
                weakSelf.selectedLocation.intCityId = 0;
                weakSelf.selectedLocation.strDistrinct = @"区";
                weakSelf.selectedLocation.intDistrinctId = 0;
                weakSelf.selectedLocation.strProvince = locationName;
                weakSelf.selectedLocation.intProvinceId = locationId;
            } else if (weakSelf.intSelectSeg == 1) {
                weakSelf.selectedLocation.strDistrinct = @"区";
                weakSelf.selectedLocation.intDistrinctId = 0;
                weakSelf.selectedLocation.strCity = locationName;
                weakSelf.selectedLocation.intCityId = locationId;
            } else {
                weakSelf.selectedLocation.strDistrinct = locationName;
                weakSelf.selectedLocation.intDistrinctId = locationId;
            }
            [self setupSegControl];
        }];
    }
}

- (void)setupSegControl
{
    [self.segControlLocation setTitle:self.selectedLocation.strProvince forSegmentAtIndex:0];
    [self.segControlLocation setTitle:self.selectedLocation.strCity forSegmentAtIndex:1];
    [self.segControlLocation setTitle:self.selectedLocation.strDistrinct forSegmentAtIndex:2];
}

- (IBAction)btnpressed_ConfirmCity:(id)sender {
    if (self.selectedLocation.intDistrinctId == 0) {
        [self showOnlyLabelHud:@"请选择地区" withView:self.view];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(didSelectCity:)]) {
        [self.delegate didSelectCity:self.selectedLocation];
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.selectedLocation.strCity forKey:K_USER_SELECTED_CITY_NAME];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",self.selectedLocation.intDistrinctId] forKey:K_USER_SELECTED_DISTRICT_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.apps.selectedLocation = self.selectedLocation;
    self.apps.storedDistrictID = self.selectedLocation.intDistrinctId;
    [[DatabaseOperator getInstance] removeAllRequirePurchaseList];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)btnpressed_CancelCity:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)segBarLocationChanged:(id)sender {
    if (self.segControlLocation.selectedSegmentIndex == 0) {
        
    } else if (self.segControlLocation.selectedSegmentIndex == 1) {
        if (self.selectedLocation.intProvinceId == 0) {
            [self showOnlyLabelHud:@"请选择省份" withView:self.view];
            return;
        }
    } else {
        if (self.selectedLocation.intCityId == 0) {
            [self showOnlyLabelHud:@"请选择城市" withView:self.view];
            return;
        }
    }
    [self performSegueWithIdentifier:@"gotoLocationList" sender:sender];
}
@end
