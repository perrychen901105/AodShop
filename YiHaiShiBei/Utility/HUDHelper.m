//
//  HUDHelper.m
//  tiangou
//
//  Created by admin on 14-4-4.
//  Copyright (c) 2014年 shangdao. All rights reserved.
//

#import "HUDHelper.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface HUDHelper ()
@end

@implementation HUDHelper


+ (HUDHelper *) getInstance
{
     static dispatch_once_t once;
     static HUDHelper *instance = nil;
     dispatch_once( &once, ^{ instance = [[HUDHelper alloc] init]; } );
     return instance;
}


- (void) showLabelHUDOnScreen:(NSString*)label{
    if (self.HUD) {
        [self.HUD removeFromSuperview];
        self.HUD = nil;
    }
    self.HUD = [[MBProgressHUD alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    
	[[self appDelegate].window addSubview:self.HUD];
	
	self.HUD.delegate = (id)self;
	self.HUD.detailsLabelText = label;
    self.HUD.detailsLabelFont = [UIFont systemFontOfSize:17];
	[self.HUD show:YES];
}

- (void) showLabelHUD:(NSString *)label view:(UIView*)view{
    if (self.HUD) {
        [self.HUD removeFromSuperview];
        self.HUD = nil;
    }
    self.HUD = [[MBProgressHUD alloc] initWithView:view];
    
    [view addSubview:self.HUD];
    
    self.HUD.delegate = (id)self;
    self.HUD.detailsLabelText = label;
    self.HUD.detailsLabelFont = [UIFont systemFontOfSize:14];
    [self.HUD show:YES];

}

//提示 成功tip
- (void)showSuccessTipWithLabel:(NSString*)label view:(UIView*)view{
	
    if (self.HUD) {
        [self.HUD removeFromSuperview];
        self.HUD = nil;
    }
    if (view) {
        self.HUD = [[MBProgressHUD alloc] initWithView:view];
    }else{
        self.HUD = [[MBProgressHUD alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    }
    /*
    self.HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD.bundle/success.png"]];
	*/
    
	self.HUD.mode = MBProgressHUDModeCustomView;
    if (view) {
        [view addSubview:self.HUD];
    }else{
        [[self appDelegate].window addSubview:self.HUD];
    }
	
	self.HUD.delegate = (id)self;

    self.HUD.animationType = MBProgressHUDAnimationZoomOut;
    self.HUD.minShowTime = 0.8;
    
	self.HUD.detailsLabelText = label;
	self.HUD.detailsLabelFont = [UIFont systemFontOfSize:16];
    [self.HUD showAnimated:YES whileExecutingBlock:^{
        
    } completionBlock:^{
        [self.HUD hide:YES];
        
    }];
}

//提示 错误tip
- (void)showErrorTipWithLabel:(NSString*)label view:(UIView*)view{
    if (self.HUD) {
        [self.HUD removeFromSuperview];
        self.HUD = nil;
    }
    if (view) {
        self.HUD = [[MBProgressHUD alloc] initWithView:view];
    }else{
        self.HUD = [[MBProgressHUD alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    }
    
    /*
    self.HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD.bundle/error.png"]];
    */
    
	self.HUD.mode = MBProgressHUDModeText;
  
	if (view) {
        [view addSubview:self.HUD];
    }else{
        [[self appDelegate].window addSubview:self.HUD];
    }
	self.HUD.userInteractionEnabled = NO;
	self.HUD.delegate = (id)self;
    
	self.HUD.detailsLabelText = label;
    self.HUD.detailsLabelFont = [UIFont systemFontOfSize:16];
    self.HUD.animationType = MBProgressHUDAnimationZoomOut;
    self.HUD.minShowTime = 1;
    
    [self.HUD showAnimated:YES whileExecutingBlock:^{
        
    } completionBlock:^{
       [self.HUD hide:YES];
    }];
}

- (void) setHUDLabel:(NSString*)label{
    self.HUD.detailsLabelText = label;
}

-(void)hideHUD
{
//    [self.HUD hide:YES];
    [self.HUD removeFromSuperview];
}

#pragma HUD ---EOF
#pragma mark MBProgressHUDDelegate methods --BOF
- (void)hudWasHidden:(MBProgressHUD *)hud {
	[self.HUD removeFromSuperview];
	self.HUD = nil;
}
#pragma mark MBProgressHUDDelegate methods --EOF

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


@end
