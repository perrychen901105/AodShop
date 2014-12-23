//
//  ProductDetailViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/22.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductViewModel.h"
#import "AppConfig.h"
#import "FavViewModel.h"
#import "ProductCommentModel.h"
#import "ProductCommentCell.h"
#import "RegisterRootViewController.h"

@interface ProductDetailViewController ()<ProductViewModelDelegate,UITextFieldDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, FavViewModelDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintInupBottom;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblProductPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblProductReleaseTime;

@property (weak, nonatomic) IBOutlet UILabel *lblMerchantName;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchantPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchantAddr;

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@property (nonatomic, strong) ProductViewModel *viewModelProduct;
@property (nonatomic, strong) FavViewModel *viewModelFav;

@property (weak, nonatomic) IBOutlet UITextField *tfProductComment;
- (IBAction)btnpressed_comment:(id)sender;

@end

@implementation ProductDetailViewController

- (void)getCommentList
{
    if (self.apps.storedUserID <= 0) {
        return;
    }
    [self.viewModelProduct getProductCommentListWithUsrID:self.apps.storedUserID appKey:self.apps.stroedAppKey productID:self.modelProduct.productID];

}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)emptyViewTapped
{
    [self.tfProductComment resignFirstResponder];
}

- (void)addFavFunc:(id)sender
{
    if (self.apps.storedUserID <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请登录" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        alert.tag = 1;
        [alert show];
        return;
    }
    [self showProgressLabelHud:@"正在添加收藏..." withView:self.view];
    [self.viewModelFav changeUserFavWithType:1 userID:self.apps.storedUserID appKey:self.apps.stroedAppKey typeid:TYPE_FAV_PRODUCT detailID:self.modelProduct.productID];
}


- (void)setFavButtonItem
{
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAdd.frame = CGRectMake(0, 0, 60, 30);
    [btnAdd setTitle:@"添加收藏" forState:UIControlStateNormal];
    [btnAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnAdd.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [btnAdd setBackgroundImage:[UIImage imageNamed:@"btn_orange"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(addFavFunc:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModelProduct = [[ProductViewModel alloc] init];
    self.viewModelProduct.delegate = self;
    self.viewModelFav = [[FavViewModel alloc] init];
    self.viewModelFav.delegate = self;
    [self addTapGestureOnEmptyView];
    [self setBackButton];
    [self getCommentList];
    [self setFavButtonItem];
    [self setNaviBarTitle:@"供应详情"];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupDetailView
{
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView methods
- (void)setupCellContent:(ProductCommentCell *)cell indexPath:(NSIndexPath *)indexPath
{
    ProductCommentModel *model = self.viewModelProduct.arrAllCommentList[indexPath.row];
    cell.lblName.text = [NSString stringWithFormat:@"用户名: %@",model.username];
    cell.lblContent.text = [NSString stringWithFormat:@"%@",model.strContent];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCommentCell"];
    [self setupCellContent:cell indexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelProduct.arrAllCommentList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static ProductCommentCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [tableView dequeueReusableCellWithIdentifier:@"ProductCommentCell"];
    });
    [self setupCellContent:sizingCell indexPath:indexPath];
    
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1.0f;
}


#pragma mark - Product viewmodel methds
-(void)productHttpError:(NSInteger)errorCode errMsg:(NSString *)errorStr withType:(EnumProductRequestType)typeRequest
{
    [self showOnlyLabelHud:errorStr withView:self.view];
}

- (void)productHttpSuccessWithTag:(EnumProductRequestType)typeRequest
{
    if (typeRequest == ProductRequestAddComment) {
        [self showOnlyLabelHud:@"提交成功" withView:self.view];
        self.tfProductComment.text = @"";
        [self getCommentList];
    } else if (typeRequest == ProductRequestAllCommentList) {
        [self.tbViewContent reloadData];
    }
}

#pragma mark - Fav model methods
- (void)favHttpSuccessWithTag:(EnumFavRequestType)type
{
    if (type == FavRequestAddFav) {
        [self showOnlyLabelHud:@"收藏成功" withView:self.view];
    }
}

- (void)favHttpErrorWithCode:(NSInteger)errorCode errMessage:(NSString *)errorStr type:(EnumFavRequestType)type
{
    if (type == FavRequestAddFav) {
        [self showOnlyLabelHud:errorStr withView:self.view];
    }
}

#pragma mark - Keyboard methdos
- (void)moveupInputView:(BOOL)isMoveup notify:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    CGFloat height = keyboardFrame.size.height;
    if (isMoveup) {
        [UIView animateWithDuration:animationDuration animations:^{
            self.constraintInupBottom.constant = height;
            [self.view layoutIfNeeded];
        }];
    } else {
        self.constraintInupBottom.constant = 0;
        [self.view layoutIfNeeded];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
}

- (void)keyboardChangeFrame:(NSNotification *)notification
{
    [self moveupInputView:YES notify:notification];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self moveupInputView:NO notify:notification];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnpressed_comment:(id)sender {
    if (self.apps.storedUserID <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请登录" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alert show];
        return;
    }
    NSString *strContent = [self.tfProductComment.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([strContent isEqualToString:@""]) {
        [self showOnlyLabelHud:@"请填写内容..." withView:self.view];
        return;
    }
    [self.tfProductComment resignFirstResponder];
    [self showProgressLabelHud:@"正在提交内容..." withView:self.view];
    [self.viewModelProduct postProductCommentWithUserID:self.apps.storedUserID appKey:self.apps.stroedAppKey productID:self.modelProduct.productID content:strContent];
}

#pragma mark - UIAlertview methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        UINavigationController *viewControllerRoot = [[UIStoryboard storyboardWithName:@"Register" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        RegisterRootViewController *viewControllerRegister = (RegisterRootViewController *)[[viewControllerRoot viewControllers] objectAtIndex:0];
        __weak ProductDetailViewController *weakSelf = self;
        [viewControllerRegister loginDidSuccess:^(BOOL success) {
            [weakSelf addFavFunc:nil];
        }];
        [self.navigationController presentViewController:viewControllerRoot animated:YES completion:^{
        }];
    } else {
        if (buttonIndex == 1) {
            UINavigationController *viewControllerRoot = [[UIStoryboard storyboardWithName:@"Register" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
            RegisterRootViewController *viewControllerRegister = (RegisterRootViewController *)[[viewControllerRoot viewControllers] objectAtIndex:0];
            __weak ProductDetailViewController *weakSelf = self;
            [viewControllerRegister loginDidSuccess:^(BOOL success) {
                [weakSelf btnpressed_comment:nil];
            }];
            [self.navigationController presentViewController:viewControllerRoot animated:YES completion:^{
            }];
        }
    }
}

@end
