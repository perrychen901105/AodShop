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
    
    self.viewModelLocation = [[LocationViewModel alloc] init];
    self.viewModelLocation.delegate = self;
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
    [self showProgressLabelHud:TEXT_WAIT_NETWORK withView:self.view];
    [self.viewModelLocation getAllProvinceList];
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
            viewControllerList.arrayLocation = self.viewModelLocation.locationModel.arrLocation;
            viewControllerList.TypeLocationList = ENUM_LOCATIONLIST_PROVINCE;
        } else if (self.segControlLocation.selectedSegmentIndex == 1) {
            viewControllerList.arrayLocation = self.selectedLocation.location.arrCity;
            viewControllerList.TypeLocationList = ENUM_LOCATIONLIST_CITY;
        } else {
            viewControllerList.arrayLocation = self.selectedLocation.city.arrDistrict;
            viewControllerList.TypeLocationList = ENUM_LOCATIONLIST_DISTRINCT;
        }
        __weak ChooseLocationViewController *weakSelf = self;
        [viewControllerList HadSelectLocation:^(NSInteger index) {
            if (weakSelf.intSelectSeg == 0) {
                weakSelf.selectedLocation.location = self.viewModelLocation.locationModel.arrLocation[index];
                [weakSelf.segControlLocation setTitle:weakSelf.selectedLocation.location.Province.name forSegmentAtIndex:0];
            } else if (weakSelf.intSelectSeg == 1) {
                weakSelf.selectedLocation.city = self.selectedLocation.location.arrCity[index];
                [weakSelf.segControlLocation setTitle:weakSelf.selectedLocation.city.name forSegmentAtIndex:1];
            } else {
                weakSelf.selectedLocation.distrinct = self.selectedLocation.city.arrDistrict[index];
                [weakSelf.segControlLocation setTitle:weakSelf.selectedLocation.distrinct.name forSegmentAtIndex:2];
            }
        }];
    }
}

- (IBAction)btnpressed_ConfirmCity:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectCity:)]) {
        [self.delegate didSelectCity:self.selectedLocation];
    }
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
        if (self.selectedLocation.location.Province.name == nil) {
            [self showOnlyLabelHud:@"请选择省份" withView:self.view];
            return;
        }
    } else {
        if (self.selectedLocation.city.name == nil) {
            [self showOnlyLabelHud:@"请选择城市" withView:self.view];
            return;
        }
    }
    
    [self performSegueWithIdentifier:@"gotoLocationList" sender:sender];
}
@end
