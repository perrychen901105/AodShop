//
//  FavIndexViewController.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-22.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "FavIndexViewController.h"
#import "FavViewModel.h"

@interface FavIndexViewController ()

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
@end
