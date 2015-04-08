//
//  CommoneTools.h
//  tiangou
//
//  Created by mac on 14-2-21.
//  Copyright (c) 2014年 kedao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommoneTools : NSObject

typedef void (^ReloadRequestBlock)(UIView *view);

+ (CommoneTools *) sharedManager;

+ (void) alertOnView:(UIView*)view content:(NSString*)content;
+ (void) confirmOnView:(UIView*)view delegate:(id)delegate content:(NSString*)content tag:(int)tag;

// 移动文件
- (void)moveTempFile:(NSString *)tmpFilePath ToDestination:(NSString *)desFilePath needRemoveOld:(BOOL)needRemove;

// 是否有网络连接
+ (BOOL) isConnectionAvailable;

// 图片圆角处理
-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;

+(NSString *)getUUIDstring;

// 把字符串放入一个宽和高的lable 中 动态获取lable的高度和宽度
+(CGSize) getSizeWithString:(NSString *)str labelWidth:(int)labelWidth labelHeight:(int)labelHeight fontSize:(float)fontSize;

+ (void) alignLabelWithTop:(UILabel *)label;

+(NSString*)formatDateToString:(NSString*)dateString withFormat:(NSString*)formatString;

//获取抢购倒计时时间
+(NSString*)getFormatCountdownTime:(NSString*)dateStr dateTimeNow:(NSDate *)dtNow;


+(NSString*)getTodayTime:(NSString*)dateStr;

+(BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;
+(BOOL)isTomorrowDay:(NSDate *)date1 date2:(NSDate*)date2;
+(BOOL)isSameYear:(NSDate*)date1 date2:(NSDate*)date2;
//返回时间所在日期当天的准确时间
+(NSString *)dateTimewithTimeStr:(NSString *)timeStr withFormat:(NSString*)strFormat;
+ (NSDate *)dateFromFormatterString:(NSString *)dateString withFormat:(NSString *)formatString;

+(NSString *)indexRushTime:(NSString *)rushTime rushEndTime:(NSString *)rushEndTime systime:(NSString *)systime;


// 1 还未开始  0 正在抢购  -1 抢购结束
+(int) nowCount:(NSString *)nowCount status:(NSString *)status rushTime:(NSString *)rushTime rushEndTime:(NSString *)rushEndTime systime:(NSString *)systime;


// 时间戳转换成日期组件
+(NSString *)dateComponentsSinceTimeInterval:(NSTimeInterval)ctime withSystemTimeInterval:(NSTimeInterval)stime;

+(NSString *)NewBeforeDay:(NSTimeInterval)ctime withSystemTimeInterval:(NSTimeInterval)stime;

+(NSString *)beforeDay:(NSTimeInterval)ctime withSystemTimeInterval:(NSTimeInterval)stime;

+(NSDateComponents *)timeInterval:(NSTimeInterval)stime;

@end
