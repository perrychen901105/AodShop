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
#ifdef DEBUG_X
    NSLog(@"%@",self.viewModelLocation.locationModel.arrLocation);
#endif
    for (LocationModel *modelLocation in self.viewModelLocation.locationModel.arrLocation) {
#ifdef DEBUG_X
        NSLog(@"the province name is %@",modelLocation.Province.name);
#endif
        for (CityModel *modelCity in modelLocation.arrCity) {
#ifdef DEBUG_X
            NSLog(@"the city name is %@",modelCity.name);
#endif
            for (DistrinctModel *modelDistrinct in modelCity.arrDistrict) {
#ifdef DEBUG_X
                NSLog(@"the distrint is %@",modelDistrinct.name);
#endif
            }
        }
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"gotoLocationList"]) {
        LocationListViewController *viewControllerList = segue.destinationViewController;
        if (self.segControlLocation.selectedSegmentIndex == 0) {
//            viewControllerList.arrayLocation
        }
        viewControllerList.blockSelectedIndex = ^(NSInteger index){
            NSLog(@"%d",index);
        };
    }
}


- (IBAction)btnpressed_ConfirmCity:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)btnpressed_CancelCity:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)segBarLocationChanged:(id)sender {
    NSLog(@"%d",self.segControlLocation.selectedSegmentIndex);
    [self performSegueWithIdentifier:@"gotoLocationList" sender:sender];
}
@end
