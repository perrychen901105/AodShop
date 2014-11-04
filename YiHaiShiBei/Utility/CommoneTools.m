//
//  CommoneTools.m
//  tiangou
//
//  Created by mac on 14-2-21.
//  Copyright (c) 2014年 kedao. All rights reserved.
//


#import "CommoneTools.h"
#import "Reachability.h"
//#import "SvUDIDTools.h"
#define ReachabilityHostName @"http://www.baidu.com"
@implementation CommoneTools

+ (CommoneTools *) sharedManager
{
    static CommoneTools *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

+(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:ReachabilityHostName];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
         
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            
            break;
    }
    return isExistenceNetwork;
}

//提示
+ (void) alertOnView:(UIView*)view content:(NSString*)content{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:content delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil,nil];

    [alertView show];
}

//确认
+ (void) confirmOnView:(UIView*)view delegate:(id)delegate content:(NSString*)content tag:(int)tag{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:content delegate:delegate
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles: @"确定",nil];
 
    alertView.tag = tag;
    [alertView show];
    
}

-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
	CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
	CGContextAddEllipseInRect(context, rect);
	CGContextClip(context);
	
	[image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
	CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+(CGSize) getSizeWithString:(NSString *)str labelWidth:(int)labelWidth labelHeight:(int)labelHeight fontSize:(float)fontSize
{
    CGSize constraint = CGSizeMake(labelWidth, 20000.0f);
    
    if (str == nil) {
        str = @"";
    }
    NSAttributedString *questionAttributedText = [[NSAttributedString alloc]initWithString:str
                                                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
    CGRect rect = [questionAttributedText boundingRectWithSize:constraint
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                       context:nil];
    CGSize tempSize = rect.size;
    
    int a1 =  tempSize.height;
    int c1 = a1 % labelHeight;
    float commentHeight = (a1 / labelHeight)*labelHeight + MAX(c1,labelHeight);
    
    CGSize size = CGSizeMake(labelWidth, commentHeight);
    
    return size;
}

+ (void) alignLabelWithTop:(UILabel *)label {
    CGSize maxSize = CGSizeMake(169.0f, 85.0f);
    label.adjustsFontSizeToFitWidth = NO;
    
    // get actual height
    CGSize actualSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize lineBreakMode:label.lineBreakMode];
    CGRect rect = label.frame;
    rect.size.height = actualSize.height;
    label.frame = rect;
}


+(NSString*)formatDateToString:(NSString*)dateString withFormat:(NSString*)formatString{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:formatString];
    NSDate *dt1 = [df dateFromString:dateString];
    [df setDateFormat:formatString];
    return [df stringFromDate:dt1];
}

+(NSString *)getUUIDstring
{
//    NSString *strUUID = [[NSUUID UUID] UUIDString];
//    NSString *strUUID = [SvUDIDTools UDID];
//    NSString *strUUID = @"123";
//    return strUUID;
    return @"123";
}

//获取抢购倒计时时间
+(NSString*)getFormatCountdownTime:(NSString*)dateStr dateTimeNow:(NSDate *)dtNow{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dtSourcePlayTime = [df dateFromString:dateStr];
    NSString *strPlayTime = [NSString stringWithFormat:@"%ld", (long)[dtSourcePlayTime timeIntervalSince1970]];
    
    
    if ([self isSameDay:dtNow date2:dtSourcePlayTime]) {
        return [CommoneTools dateTimewithTimeStr:strPlayTime withFormat:@"今天 HH:mm"];
    } else if ([self isTomorrowDay:dtNow date2:dtSourcePlayTime]) {
        return [CommoneTools dateTimewithTimeStr:strPlayTime withFormat:@"明天 HH:mm"];
    } else {
        if ([CommoneTools isSameYear:dtNow date2:dtSourcePlayTime]) {
            return [CommoneTools dateTimewithTimeStr:strPlayTime withFormat:@"MM-dd HH:mm"];
        } else {
            return [CommoneTools dateTimewithTimeStr:strPlayTime withFormat:@"yyyy-MM-dd HH:mm"];
        }
    }
}

+(NSString*)getTodayTime:(NSString*)dateStr
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM/dd HH:mm:ss"];
    NSDate *dtSourcePlayTime = [df dateFromString:dateStr];
    NSString *strPlayTime = [NSString stringWithFormat:@"%ld", (long)[dtSourcePlayTime timeIntervalSince1970]];
    NSDate *dtNow = [NSDate date];
    
    if ([self isSameDay:dtNow date2:dtSourcePlayTime]) {
        return [NSString stringWithFormat:@"今天 %@",[CommoneTools dateTimewithTimeStr:strPlayTime withFormat:@"HH:mm"]];
    } else {
   
        return [CommoneTools dateTimewithTimeStr:strPlayTime withFormat:@"MM/dd HH:mm"];
      
    }
}

//返回时间所在日期当天的准确时间
+(NSString *)dateTimewithTimeStr:(NSString *)timeStr withFormat:(NSString*)strFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:strFormat];
    NSTimeInterval timeInterval = [timeStr intValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *str =  [formatter stringFromDate:confromTimesp];
    return str;
}

//判断两个日期是否是同一天
+(BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

+(BOOL)isTomorrowDay:(NSDate *)date1 date2:(NSDate*)date2
{
    //date 1是当前时间 date 2是明天时间，需要验证的
    unsigned units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents* compsTomorrow = [[NSCalendar currentCalendar] components:units fromDate:date1];
    // Add one day
    compsTomorrow.day = compsTomorrow.day+1; // no worries: even if it is the end of the month it will wrap to the next month, see doc
    NSDateComponents* compsToday =[[NSCalendar currentCalendar] components:units fromDate:date2];
    return [compsToday day]   == [compsTomorrow day] &&
    [compsToday month] == [compsTomorrow month] &&
    [compsToday year]  == [compsTomorrow year];
    // Recompose a new date, without any time information (so this will be at midnight)
//    NSDate* tomorrow = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
}

//判断两个日期是否是同一年
+(BOOL)isSameYear:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    return [comp1 year]  == [comp2 year];
}



+(NSString *)indexRushTime:(NSString *)rushTime rushEndTime:(NSString *)rushEndTime systime:(NSString *)systime
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dtRushTime = [df dateFromString:rushTime];
    
    NSDate *dtEndTime = [df dateFromString:rushEndTime];

    NSDate *dtSystime = [df dateFromString:systime];
    
    NSComparisonResult result = [dtSystime compare:dtRushTime];
    
    // 还未开始
    if (result == NSOrderedAscending)
    {
        if ([CommoneTools isSameDay:dtRushTime date2:dtSystime]) {
        
             /*
            NSTimeInterval startTimeInterval = [dtRushTime timeIntervalSinceDate:dtSystime];
            NSNumber *startTimeNum = [NSNumber numberWithDouble:startTimeInterval];
            
            
            return [NSString stringWithFormat:@"%@时%@分后开始",
                    [NSString stringWithFormat:@"%d%d",([startTimeNum intValue]/60/60)/10,([startTimeNum intValue]/60/60)%10],
                    [NSString stringWithFormat:@"%d%d",([startTimeNum intValue]/60/60)/10,([startTimeNum intValue]/60%60)%10]];
            */
           
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSCalendar *cal = [NSCalendar currentCalendar];
            unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
            
            NSDateComponents *startDate = [cal components:unitFlags fromDate:[formatter dateFromString:rushTime]];
            return [NSString stringWithFormat:@"%.2d:%.2d 开始",[startDate hour],[startDate minute]];
            
        }else if ([CommoneTools isTomorrowDay:dtSystime date2:dtRushTime])
        {
            return @"明日 开始";
        }else
        {
           
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSCalendar *cal = [NSCalendar currentCalendar];
            unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
            
            NSDateComponents *startDate = [cal components:unitFlags fromDate:[formatter dateFromString:rushTime]];
            return [NSString stringWithFormat:@"%.2d月%.2d日开始",[startDate month],[startDate day]];
         
        }
    }
    
    else if (result == NSOrderedDescending)
    {
         NSComparisonResult result2 = [dtSystime compare:dtEndTime];
         if (result2 == NSOrderedAscending) {
            return @"正在抢购中";
         }else
         {
             return @"抢购结束";
         }
    }else
    {
        return @"正在抢购中";
    }

}

// 1 还未开始  0 正在抢购  -1 抢购结束
+(int) nowCount:(NSString *)nowCount status:(NSString *)status rushTime:(NSString *)rushTime rushEndTime:(NSString *)rushEndTime systime:(NSString *)systime
{
    if ([nowCount intValue] <= 0 || [status isEqualToString:@"4"]) {
        return -1;
    }
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dtRushTime = [df dateFromString:rushTime];
    
    NSDate *dtEndTime = [df dateFromString:rushEndTime];
    
    NSDate *dtSystime = [df dateFromString:systime];
    
    NSComparisonResult result = [dtSystime compare:dtRushTime];
    
    // 还未开始
    if (result == NSOrderedAscending)
    {
        return 1;
    }
    
    else if (result == NSOrderedDescending)
    {
        NSComparisonResult result2 = [dtSystime compare:dtEndTime];
        if (result2 == NSOrderedAscending) {
            return 0;
        }else
        {
            return -1;
        }
    }else
    {
        return 0;
    }
}

// 时间戳转换成日期组件
+(NSString *)dateComponentsSinceTimeInterval:(NSTimeInterval)ctime withSystemTimeInterval:(NSTimeInterval)stime
{
    
    NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:ctime / 1000];
  
    NSTimeInterval tempTimeInterval = (stime - ctime);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:tempDate];
    
    if (tempTimeInterval > 12*60*60)
    {
        return [NSString stringWithFormat:@"%.2d月%.2d日 %.2d:%.2d",[comps month],[comps day],[comps hour],[comps minute]];
    }else
    {
        return [NSString stringWithFormat:@"今天 %.2d:%.2d",[comps hour],[comps minute]];
    }
}

//时间戳转换成before日期
+(NSString *)NewBeforeDay:(NSTimeInterval)ctime withSystemTimeInterval:(NSTimeInterval)stime
{
    NSTimeInterval tempTimeInterval = (stime - ctime) / 1000 ;
    
    //大于1天显示具体日期 09-12 12：35
    if (tempTimeInterval > 24*60*60)
    {
        stime = [[NSDate date] timeIntervalSince1970]*1000;
        NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:ctime / 1000];
        
        //NSTimeInterval tempTimeInterval0 = (stime - ctime);
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        comps = [calendar components:unitFlags fromDate:tempDate];
        
        return [NSString stringWithFormat:@"%.2d-%.2d %.2d:%.2d",[comps month],[comps day],[comps hour],[comps minute]];
        
    }else if( tempTimeInterval > 60*60)
    {
        int beforHour = tempTimeInterval/(60*60);
        return [NSString stringWithFormat:@"%d小时前",beforHour];
        
    }else if(tempTimeInterval > 60)
    {
        int beforMinute = tempTimeInterval / 60;
        
        return [NSString stringWithFormat:@"%d分钟前",beforMinute];
        
    }else
    {
        return @"刚刚";
    }
    
}


// 时间戳转换成日期组件
+(NSString *)beforeDay:(NSTimeInterval)ctime withSystemTimeInterval:(NSTimeInterval)stime
{

    NSTimeInterval tempTimeInterval = (stime - ctime) / 1000 ;

    if (tempTimeInterval > 24*60*60)
    {
        int beforDay = tempTimeInterval/(24*60*60);
    
        return [NSString stringWithFormat:@"%d天前",beforDay];
    }else if( tempTimeInterval > 60*60)
    {
        int beforHour = tempTimeInterval/(60*60);
        return [NSString stringWithFormat:@"%d小时前",beforHour];
        
    }else if(tempTimeInterval > 60)
    {
        int beforMinute = tempTimeInterval / 60;
        
            return [NSString stringWithFormat:@"%d分钟前",beforMinute];
      
    }else
    {
        return @"刚刚";
    }
}

+(NSDateComponents *)timeInterval:(NSTimeInterval)stime
{
    NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:stime / 1000];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:tempDate];
    return comps;
}



@end
