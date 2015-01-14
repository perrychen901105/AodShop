//
//  MsgDetailViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/5.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MsgDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "AppConfig.h"

@interface MsgDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgViewDes;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblReleaseTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextView *tvContent;

@end

@implementation MsgDetailViewController

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNaviBarTitle:@"消息详情"];
    [self setBackButton];
    [self setupDetailView];
    //TODO: add share button
    
    [self setShareButton];
    // Do any additional setup after loading the view.
}

//Share content

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupDetailView
{
    [self.imgViewDes sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,self.modelMsg.picture]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
    self.lblUserName.text = [NSString stringWithFormat:@"发布人: %@",self.modelMsg.userName];
    self.lblReleaseTime.text = [NSString stringWithFormat:@"时间: %@",self.modelMsg.release_date];
    self.lblTitle.text = [NSString stringWithFormat:@"%@",self.modelMsg.title];
    self.tvContent.text = [NSString stringWithFormat:@"%@",self.modelMsg.content];
}

- (void)btnShareClick
{
    [self shareContent:@"关注艺海" img:[UIImage imageNamed:@"img_banner_default"] url:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
