//
//  FavIndexViewController.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-22.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "FavIndexViewController.h"
#import "FavViewModel.h"
#import "FavModel.h"
#import "UIImageView+WebCache.h"
#import "AppConfig.h"
#import "favListCell.h"

@interface FavIndexViewController ()<FavViewModelDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segControlFav;
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@property (nonatomic, strong) FavViewModel *viewModelFav;

@property (nonatomic, assign) NSInteger intSelectFav;

- (IBAction)segValueChanged:(id)sender;

@end

@implementation FavIndexViewController

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
    self.intSelectFav = 1;
    [self setNaviBarTitle:@"我的收藏"];
    self.viewModelFav = [[FavViewModel alloc] init];
    self.viewModelFav.delegate = self;
    [self getFavList];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)getFavList
{
    if (self.apps.storedUserID <= 0) {
        return;
    }
    [self.viewModelFav getAllFavListWithUserID:self.apps.storedUserID appKey:self.apps.stroedAppKey typeID:self.intSelectFav start:-1 num:-1];
}

- (IBAction)segValueChanged:(id)sender {
    if (self.segControlFav.selectedSegmentIndex == 0) {
        self.intSelectFav = 1;
    } else if (self.segControlFav.selectedSegmentIndex == 1) {
        self.intSelectFav = 4;
    } else if (self.segControlFav.selectedSegmentIndex == 2) {
        self.intSelectFav = 3;
    } else if (self.segControlFav.selectedSegmentIndex == 3) {
        self.intSelectFav = 2;
    }
    [self getFavList];
}

#pragma mark - Fav view model methods
- (void)favHttpErrorWithCode:(NSInteger)errorCode errMessage:(NSString *)errorStr type:(EnumFavRequestType)type
{
    
}

- (void)favHttpSuccessWithTag:(EnumFavRequestType)type
{
    [self.tbViewContent reloadData];
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    favListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favListCell"];
    if (self.viewModelFav.didChangeIndex == 1) {
        ProductFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
        [cell.imgViewFav sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,model.productPic]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
        cell.lblTitle.text = model.productName;
        cell.lblContent.text = [NSString stringWithFormat:@"￥ %.2f",model.price];
        cell.lblSubtitle.text = [NSString stringWithFormat:@"添加时间: %@",model.strAddtime];
    } else if(self.viewModelFav.didChangeIndex == 2) {
        MerchantFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
        [cell.imgViewFav sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,model.merchantPic]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
        cell.lblTitle.text = model.merchantName;
        cell.lblContent.text = [NSString stringWithFormat:@"地址 %@",model.merchantAddr];
        cell.lblSubtitle.text = [NSString stringWithFormat:@"添加时间: %@",model.strAddtime];
    } else if (self.viewModelFav.didChangeIndex == 3) {
        GrouponFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
        [cell.imgViewFav sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,model.grouponPic]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
        cell.lblTitle.text = model.grouponName;
        cell.lblContent.text = [NSString stringWithFormat:@"团购价:￥ %.2f",model.newPrice];
        cell.lblSubtitle.text = [NSString stringWithFormat:@"添加时间: %@",model.strAddtime];
    } else {
        InfoFavModel *model = self.viewModelFav.arrALlFavList[indexPath.row];
        [cell.imgViewFav sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,model.infoPic]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
        cell.lblTitle.text = model.infoName;
        cell.lblContent.text = @"";
        cell.lblSubtitle.text = [NSString stringWithFormat:@"添加时间: %@",model.strAddtime];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelFav.arrALlFavList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
@end
