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


@interface ChooseLocationViewController ()<LocationIndexViewModelDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) CurrentLocationModel *selectedLocation;
@property (nonatomic, strong) LocationViewModel *viewModelLocation;
@property (nonatomic, assign) NSInteger intSelectSeg;

@property (nonatomic, assign) NSInteger intSelectProvince;
@property (nonatomic, assign) NSInteger intSelectCity;
@property (nonatomic, assign) NSInteger intSelectDistrict;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segControlLocation;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewLocation;


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
    self.pickerViewLocation.layer.borderColor = [COLOR_TITLE_DEFAULT CGColor];
    self.pickerViewLocation.layer.borderWidth = 1.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - WebService methods
- (void)getAllLocations
{
    if ([[DatabaseOperator getInstance] getAllProvinces].count > 0) {
        if ([[self getAllProvices] count]>0) {
            ProvinceModel *model = [self getAllProvices][0];
            self.intSelectProvince = model.provinceID;
            if ([[self getAllCityWithProvinceID:self.intSelectProvince] count] > 0) {
                CityModel *modelCity = [self getAllCityWithProvinceID:self.intSelectProvince][0];
                self.intSelectCity = modelCity.cityID;
                [self.pickerViewLocation reloadComponent:1];
                if ([[self getAllDistrictWithCityID:self.intSelectCity] count]>0) {
                    [self.pickerViewLocation reloadComponent:2];
                }
            }
        }
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
    if ([[self getAllProvices] count]>0) {
        [self.pickerViewLocation reloadComponent:0];
        ProvinceModel *model = [self getAllProvices][0];
        self.intSelectProvince = model.provinceID;
        if ([[self getAllCityWithProvinceID:self.intSelectProvince] count] > 0) {
            CityModel *modelCity = [self getAllCityWithProvinceID:self.intSelectProvince][0];
            self.intSelectCity = modelCity.cityID;
            [self.pickerViewLocation reloadComponent:1];
            if ([[self getAllDistrictWithCityID:self.intSelectCity] count]>0) {
                [self.pickerViewLocation reloadComponent:2];
            }
        }
    }
}

- (void)synacApps:(CityModel *)modelCity distrinct:(DistrinctModel *)modelDis
{
    [[NSUserDefaults standardUserDefaults] setObject:modelCity.name forKey:K_USER_SELECTED_CITY_NAME];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",modelDis.districtID] forKey:K_USER_SELECTED_DISTRICT_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.apps.selectedLocation = self.selectedLocation;
    self.apps.storedDistrictID = modelDis.districtID;
    self.apps.storedCityName = modelCity.name;
}

#pragma mark - Navigation
- (IBAction)btnpressed_ConfirmCity:(id)sender {
    NSArray *arrDistricts = [self getAllDistrictWithCityID:self.intSelectCity];
    NSArray *arrCitys = [self getAllCityWithProvinceID:self.intSelectProvince];
    NSArray *arrProvince = [self getAllProvices];
    if ([arrDistricts count] > 0) {
        DistrinctModel *modelDis = arrDistricts[[self.pickerViewLocation selectedRowInComponent:2]];
        CityModel *modelCity = arrCitys[[self.pickerViewLocation selectedRowInComponent:1]];
        ProvinceModel *modelProvince = arrProvince[[self.pickerViewLocation selectedRowInComponent:0]];
        
        if (self.apps.storedDistrictID != modelDis.districtID) {
            [[DatabaseOperator getInstance] removeAllRequirePurchaseList];
            [[DatabaseOperator getInstance] removeAllGrouponList];
            [[DatabaseOperator getInstance] removeAllProductTypes];
            [[DatabaseOperator getInstance] removeAllMerchantTypes];
            [[DatabaseOperator getInstance] removeAllProductLists];
            [[DatabaseOperator getInstance] removeAllMerchantLists];
        }
        self.selectedLocation = [[CurrentLocationModel alloc] init];
        self.selectedLocation.strProvince = modelProvince.name;
        self.selectedLocation.intProvinceId = modelProvince.provinceID;
        self.selectedLocation.strCity = modelCity.name;
        self.selectedLocation.intCityId = modelCity.cityID;
        self.selectedLocation.strDistrinct = modelDis.name;
        self.selectedLocation.intDistrinctId = modelDis.districtID;
        if (self.needSynacApp) {
            [self synacApps:modelCity distrinct:modelDis];
        }
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    } else {
        [self showOnlyLabelHud:@"请选择地区" withView:self.view];
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCity:)]) {
        [self.delegate didSelectCity:self.selectedLocation];
    }
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

#pragma mark - UIPicker methods
- (NSArray *)getAllProvices
{
    NSArray *arrPro = @[];
    arrPro = [[DatabaseOperator getInstance] getAllProvinces];
    return arrPro;
}

- (NSArray *)getAllCityWithProvinceID:(NSInteger)provinceID
{
    NSArray *arrCity = @[];
    arrCity = [[DatabaseOperator getInstance] getAllCitysWithProvinceId:provinceID];
    return arrCity;
}

- (NSArray *)getAllDistrictWithCityID:(NSInteger)cityID
{
    NSArray *arrDistrict = @[];
    arrDistrict = [[DatabaseOperator getInstance] getAllDistrictsWithCityId:cityID];
    return arrDistrict;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [[self getAllProvices] count];
    } else if (component == 1) {
        return [[self getAllCityWithProvinceID:self.intSelectProvince] count];
    } else {
        return [[self getAllDistrictWithCityID:self.intSelectCity] count];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    if (component == 0) {
        ProvinceModel *model = [self getAllProvices][row];
        title = model.name;
    } else if (component == 1) {
        CityModel *model = [self getAllCityWithProvinceID:self.intSelectProvince][row];
        title = model.name;
    } else {
        DistrinctModel *model = [self getAllDistrictWithCityID:self.intSelectCity][row];
        title = model.name;
    }
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:COLOR_TITLE_DEFAULT,NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
    return attString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        ProvinceModel *model = [self getAllProvices][row];
        self.intSelectProvince = model.provinceID;
        [pickerView reloadComponent:1];
        if ([[self getAllCityWithProvinceID:self.intSelectProvince] count] > 0) {
            CityModel *modelCity = [self getAllCityWithProvinceID:self.intSelectProvince][0];
            self.intSelectCity = modelCity.cityID;
            [self.pickerViewLocation reloadComponent:1];
            if ([[self getAllDistrictWithCityID:self.intSelectCity] count]>0) {
                [self.pickerViewLocation reloadComponent:2];
            }
        }
    } else if (component == 1) {
        CityModel *model = [self getAllCityWithProvinceID:self.intSelectProvince][row];
        self.intSelectCity = model.cityID;
        [pickerView reloadComponent:2];
    } else {
        DistrinctModel *model = [self getAllDistrictWithCityID:self.intSelectCity][row];
        self.intSelectDistrict = model.districtID;
    }
}

@end
