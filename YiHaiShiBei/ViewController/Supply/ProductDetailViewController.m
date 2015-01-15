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
#import "UIImageView+WebCache.h"
#import "MerchantDetailViewController.h"

@interface ProductDetailViewController ()<ProductViewModelDelegate,UITextFieldDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, FavViewModelDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintInupBottom;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblProductPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblProductReleaseTime;

@property (weak, nonatomic) IBOutlet UILabel *lblMerchantName;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchantPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchantAddr;
@property (weak, nonatomic) IBOutlet UIButton *btnMerchantPhone;
@property (weak, nonatomic) IBOutlet UITextView *tvProductBackup;

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@property (nonatomic, strong) ProductViewModel *viewModelProduct;
@property (nonatomic, strong) FavViewModel *viewModelFav;

@property (weak, nonatomic) IBOutlet UITextField *tfProductComment;
- (IBAction)btnpressed_comment:(id)sender;
- (IBAction)btnpressed_phoneClick:(id)sender;
- (IBAction)btnpressed_companyClick:(id)sender;

@end

@implementation ProductDetailViewController

- (void)getCommentList
{
    if (self.apps.storedUserID <= 0) {
        return;
    }
    [self showProgressLabelHud:@"获取评论中..." withView:self.view];
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
    btnAdd.frame = CGRectMake(0, 0, 30, 30);
    [btnAdd setTitle:@"收藏" forState:UIControlStateNormal];
    [btnAdd setTitleColor:COLOR_TITLE_DEFAULT forState:UIControlStateNormal];
    [btnAdd.titleLabel setFont:[UIFont systemFontOfSize:13]];
    //    [btnAdd setBackgroundImage:[UIImage imageNamed:@"btn_orange"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(addFavFunc:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemFav = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
    
    UIButton *btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
    btnShare.frame = CGRectMake(0, 0, 30, 30);
    [btnShare setTitle:@"分享" forState:UIControlStateNormal];
    [btnShare setTitleColor:COLOR_TITLE_DEFAULT forState:UIControlStateNormal];
    [btnShare.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [btnShare addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemShare = [[UIBarButtonItem alloc] initWithCustomView:btnShare];
    self.navigationItem.rightBarButtonItems = @[itemFav, itemShare];
}

- (void)shareBtnClick:(id)sender
{
    [self shareContent:self.modelProduct.productName img:[UIImage imageNamed:@"img_banner_default"] url:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModelProduct = [[ProductViewModel alloc] init];
    self.viewModelProduct.delegate = self;
    self.viewModelFav = [[FavViewModel alloc] init];
    self.viewModelFav.delegate = self;
    [self addTapGestureOnEmptyView];
    self.tvProductBackup.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.tvProductBackup.layer.borderWidth = 0.5;
    self.tvProductBackup.textContainer.lineFragmentPadding = 0;
    self.tvProductBackup.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
    [self setBackButton];
    [self getCommentList];
    [self setFavButtonItem];
    [self setNaviBarTitle:@"供应详情"];
    self.viewModelProduct.product = self.modelProduct;
    [self setupDetailView];
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
    [self.imgViewProduct sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,self.modelProduct.productPicture]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
    self.lblProductName.text = [NSString stringWithFormat:@"品名: %@",self.modelProduct.productName];
    self.lblProductPrice.text = [NSString stringWithFormat:@"价格: ￥%.2f",self.modelProduct.price];
    self.lblProductReleaseTime.text = [NSString stringWithFormat:@"发布时间: %@",self.modelProduct.releaseDate];
    self.lblMerchantName.text = [NSString stringWithFormat:@"公司名: %@",self.modelProduct.companyName];
    self.lblMerchantPhone.text = [NSString stringWithFormat:@"公司电话: %@",self.modelProduct.userPhone];
    self.lblMerchantAddr.text = [NSString stringWithFormat:@"公司地址: %@",self.modelProduct.companyAddr];
    self.btnMerchantPhone.layer.cornerRadius = 5.0f;
    self.btnMerchantPhone.layer.masksToBounds = YES;
    self.tvProductBackup.text = self.modelProduct.backup;
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
    cell.lblContent.text = [NSString stringWithFormat:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          @"%@",model.strContent];
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
        [self hideHudWithDelay:0];
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
        __weak ProductDetailViewController *weakSelf = self;
        [UIView animateWithDuration:animationDuration animations:^{
            weakSelf.constraintInupBottom.constant = height;
            [weakSelf.view layoutIfNeeded];
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

- (IBAction)btnpressed_phoneClick:(id)sender {
    if ([self.viewModelProduct.product.userPhone length] > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.viewModelProduct.product.userPhone]]];
    }
}

- (IBAction)btnpressed_companyClick:(id)sender {
    UIStoryboard *sbMerchant = [UIStoryboard storyboardWithName:@"MerchantPage" bundle:nil];
    MerchantDetailViewController *viewControllerMerchant = [sbMerchant instantiateViewControllerWithIdentifier:@"MerchantDetailViewController"];
    viewControllerMerchant.loadFromWeb = YES;
    viewControllerMerchant.merchantUsrID = self.modelProduct.userID;
    [self.navigationController pushViewController:viewControllerMerchant animated:YES];
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
