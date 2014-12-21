//
//  SearchRootViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/21.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "SearchRootViewController.h"
#import "SearchViewModel.h"

@interface SearchRootViewController ()<UITableViewDataSource, UITableViewDelegate, SearchViewModelDelegate, UISearchBarDelegate>

@property (nonatomic, strong) SearchViewModel *viewModelSearch;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarContent;
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@property (nonatomic, assign) NSInteger intSelectType;
@property (nonatomic, strong) NSString *strSearchContent;

- (IBAction)segValueChanged:(id)sender;

@end

@implementation SearchRootViewController

- (void)backAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.intSelectType = 1;
    [self setBackButton];
    [self setNaviBarTitle:nil];
    
    self.strSearchContent = @"";
    
    self.viewModelSearch = [[SearchViewModel alloc] init];
    self.viewModelSearch.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getSearchList
{
    if ([self.strSearchContent isEqualToString:@""]) {
        [self showOnlyLabelHud:@"请输入搜索内容..." withView:self.view];
        return;
    }
    [self.viewModelSearch getAllSearchListWithContent:self.strSearchContent type:self.intSelectType start:-1 num:-1];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - SearchViewModel methods
- (void)searchHttpSuccessWithTag:(EnumSearchRequestType)type
{
    NSLog(@"%@",self.viewModelSearch.arrAllSearchList);
}

- (void)searchHttpErrorWithErrorCode:(NSInteger)errorCode errMessage:(NSString *)errorMsg type:(EnumSearchRequestType)type
{
    
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
    return 0;
}

#pragma mark - search bar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *strContent = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    self.strSearchContent = strContent;
    [self getSearchList];
    [searchBar resignFirstResponder];
}

#pragma mark - Seg action
- (IBAction)segValueChanged:(id)sender {
    UISegmentedControl *segControl = (UISegmentedControl *)sender;
    if (segControl.selectedSegmentIndex == 0) {
        self.intSelectType = 1;
    } else if (segControl.selectedSegmentIndex == 1) {
        self.intSelectType = 2;
    } else if (segControl.selectedSegmentIndex == 2) {
        self.intSelectType = 3;
    } else {
        self.intSelectType = 4;
    }
    [self getSearchList];
}
@end
