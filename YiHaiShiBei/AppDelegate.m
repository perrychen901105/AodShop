//
//  AppDelegate.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14-10-15.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeIndexViewController.h"
#import "SupplyIndexViewController.h"
#import "CommoneTools.h"
#import "AppConfig.h"

@interface AppDelegate ()



@end



@implementation AppDelegate

#pragma mark - File Operator
+ (NSString *)getCacheDatabasePath
{
    //指向文件目录
    NSString *documentsDirectory= [NSHomeDirectory()
                                   stringByAppendingPathComponent:@"Documents"];
    NSString *strDBDirPath = [NSString stringWithFormat:@"%@/myFolder", documentsDirectory];
    if (![[NSFileManager defaultManager] fileExistsAtPath:strDBDirPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:strDBDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *strDBPath = [strDBDirPath stringByAppendingPathComponent:@"AodShop.sqlite"];
    
    
    return strDBPath;
}

- (void)copyDBtoDocument
{
    NSString *strDefaultPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"AodShop.sqlite"];
    [[CommoneTools sharedManager] moveTempFile:strDefaultPath ToDestination:[AppDelegate getCacheDatabasePath] needRemoveOld:NO];
}

#pragma mark - Application Lift Cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.

    UITabBarController *tabIndex = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    
    
    
    UINavigationController *navHome = [[UIStoryboard storyboardWithName:@"HomePage" bundle:nil] instantiateInitialViewController];
    UINavigationController *navSupply = [[UIStoryboard storyboardWithName:@"SupplyIndex" bundle:nil] instantiateInitialViewController];
    UINavigationController *navFav = [[UIStoryboard storyboardWithName:@"FavPage" bundle:nil] instantiateInitialViewController];
    UINavigationController *navMerchant = [[UIStoryboard storyboardWithName:@"MerchantPage" bundle:nil] instantiateInitialViewController];
    UINavigationController *navMore = [[UIStoryboard storyboardWithName:@"MorePage" bundle:nil] instantiateInitialViewController];
    
//    [navHome.navigationBar setTranslucent:YES];
    
    [tabIndex setViewControllers:@[navHome, navSupply, navMerchant, navFav , navMore]];
    
    [[[tabIndex.viewControllers objectAtIndex:0] tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_homeSelected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_home"]];
    [[[tabIndex.viewControllers objectAtIndex:1] tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_supplySelected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_supply"]];
    [[[tabIndex.viewControllers objectAtIndex:2] tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_merchantSelected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_merchant"]];
    [[[tabIndex.viewControllers objectAtIndex:3] tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_favSelected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_fav"]];
    [[[tabIndex.viewControllers objectAtIndex:4] tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_moreSelected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_more"]];
    
    [[tabIndex.viewControllers objectAtIndex:0] tabBarItem].title = @"主页";
    [[tabIndex.viewControllers objectAtIndex:1] tabBarItem].title = @"供应";
    [[tabIndex.viewControllers objectAtIndex:2] tabBarItem].title = @"商户";
    [[tabIndex.viewControllers objectAtIndex:3] tabBarItem].title = @"收藏";
    [[tabIndex.viewControllers objectAtIndex:4] tabBarItem].title = @"更多";
    
    self.window.rootViewController = tabIndex;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:249/255.0f green:174/255.0f blue:42/255.0f alpha:1.0f] }
                                             forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:152/255.0f green:152/255.0f blue:152/255.0f alpha:1.0f] }
                                             forState:UIControlStateNormal];

    
    self.modelUser = nil;//[[UserModel alloc] init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:K_USER_SELECTED_DISTRICT_ID] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@4 forKey:K_USER_SELECTED_DISTRICT_ID];
        [[NSUserDefaults standardUserDefaults] setObject:@"南通市" forKey:K_USER_SELECTED_CITY_NAME];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    self.storedCityName = [[NSUserDefaults standardUserDefaults] objectForKey:K_USER_SELECTED_CITY_NAME];
    self.storedDistrictID = [[[NSUserDefaults standardUserDefaults] objectForKey:K_USER_SELECTED_DISTRICT_ID] intValue];
    
    
    [self copyDBtoDocument];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:249/255.0f green:174/255.0f blue:42/255.0f alpha:1.0f]];

//    [[UITabBarController tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_homeSelected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_home"]];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
