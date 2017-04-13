//
//  ZJViewController.m
//  ZJComponents
//
//  Created by Jason He on 03/03/2017.
//  Copyright (c) 2017 Jason.he All rights reserved.
//

#import "ZJViewController.h"

@interface ZJViewController ()
@property (nonatomic, strong) Reachability *hostReach;
@end

@implementation ZJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customBackItem:nil];
    [self httpRequestDeme];
    [self utilsDemo];
    
}

- (void)httpRequestDeme{
    UIImageView *imageView = [[UIImageView alloc ]initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    [[ZJHTTPManager manager] resquestWith:HTTPRequestType_POST withURL:@"http://api.izhangchu.com" withParams:@{@"appVersion":@"4.9",@"sysVersion":@"10.2.1",@"devModel":@"iPhone"} success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        //        NSLog(@"responseObject:%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dic:%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        NSLog(@"error:%@",error);
    }];
    
    [[ZJHTTPManager manager] resquestWith:HTTPRequestType_GET withURL:@"http://appserv.51zxw.net//course.asp?app_Ver=1.2.14&cmod=ap&courseid=457" withParams:nil success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        //        NSLog(@"responseObject:%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dic:%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        NSLog(@"error:%@",error);
    }];
    
    [[ZJHTTPManager manager] dowloadFileWithURL:@"http://www.51zxw.net/netclass//images/SN0112_banner.jpg" progress:^(NSProgress *downloadProgress) {
        NSLog(@"\n下载进度:%@\n",@((1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount)*100.0));
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"\nresponse:%@\nfilePath:%@",response,filePath);
        imageView.image = [UIImage imageWithContentsOfFile:filePath.resourceSpecifier];
    }];

}

- (void)utilsDemo{
    //加密
    NSString *enString = [NSString encryptUseDES:@"ABS123" key:@"123456"];
    NSLog(@"加密后:%@",enString);
    //解密
    NSString *deString = [NSString decryptUseDES:enString key:@"123456"];
    NSLog(@"解密后:%@",deString);
    // Do any additional setup after loading the view, typically from a nib.
    
    UIWindow *win = [UIWindow lastWindow];
    NSLog(@"Real Last Window : %@", win);
    
    
    // An array to hold the badges
    NSMutableArray *badges = [NSMutableArray array];
    
    
    // Creates a badge with scale of 1.5
    CustomBadge *badge1 = [CustomBadge customBadgeWithString:@"CustomBadge" withScale:1.5];
    [badges addObject:badge1];
    
    // Creates a badge with pre-defined style "old" (for prior-iOS7 style)
    CustomBadge *badge2 = [CustomBadge customBadgeWithString:@"Old iOS Style" withScale:1.5 withStyle:[BadgeStyle oldStyle]];
    [badges addObject:badge2];
    
    // Creates a badge with free customer definitions
    BadgeStyle *badge3Style = [BadgeStyle freeStyleWithTextColor:[UIColor whiteColor]
                                                  withInsetColor:[UIColor blueColor]
                                                  withFrameColor:nil
                                                       withFrame:NO
                                                      withShadow:NO
                                                     withShining:NO
                                                    withFontType:BadgeStyleFontTypeHelveticaNeueLight];
    
    CustomBadge *badge3 = [CustomBadge customBadgeWithString:@"Retina ready!" withScale:1.5 withStyle:badge3Style];
    [badges addObject:badge3];
    
    BadgeStyle *badge4Style = [BadgeStyle freeStyleWithTextColor:[UIColor whiteColor]
                                                  withInsetColor:[UIColor purpleColor]
                                                  withFrameColor:[UIColor blackColor]
                                                       withFrame:YES
                                                      withShadow:YES
                                                     withShining:YES
                                                    withFontType:BadgeStyleFontTypeHelveticaNeueLight];
    
    CustomBadge *badge4 = [CustomBadge customBadgeWithString:@"Highly customizable" withScale:2.0 withStyle:badge4Style];
    [badges addObject:badge4];
    
    CustomBadge *badge5 = [CustomBadge customBadgeWithString:@"1"];
    [badges addObject:badge5];
    
    CustomBadge *badge6 = [CustomBadge customBadgeWithString:@"2" withStyle:[BadgeStyle oldStyle]];
    [badges addObject:badge6];
    
    
    // Creates a baddge ...
    CustomBadge *badge7 = [CustomBadge customBadgeWithString:@"Easy to use"];
    [badges addObject:badge7];
    [badge7.badgeStyle setBadgeTextColor:[UIColor blackColor]];
    [badge7.badgeStyle setBadgeInsetColor:[UIColor whiteColor]];
    [badge7.badgeStyle setBadgeShadow:YES];
    // ... and change it afterwards with autoBadgeSizeWithString
    [badge7 autoBadgeSizeWithString:@"Easy to use & flexible"];
    
    CustomBadge *badge8 = [CustomBadge customBadgeWithString:@"Still Open & Free" withScale:1.25];
    [badge8.badgeStyle setBadgeShadow:YES];
    [badge8.badgeStyle setBadgeFrame:YES];
    [badge8.badgeStyle setBadgeFrameColor:[UIColor yellowColor]];
    [badges addObject:badge8];
    
    
    
    // Put all badges to the screen
    for (int i=0; i<badges.count; i++) {
        CustomBadge *badge = [badges objectAtIndex:i];
        CGFloat y;
        if(i==0) {
            y = 110;
        } else {
            CustomBadge* last = (CustomBadge*)[badges objectAtIndex:i-1];
            y = last.frame.origin.y + last.frame.size.height;
        }
        CGPoint point = CGPointMake(self.view.frame.size.width/2-badge.frame.size.width/2, y);
        CGSize size = CGSizeMake(badge.frame.size.width, badge.frame.size.height);
        CGRect rect = CGRectMake(point.x, point.y, size.width, size.height);
        [badge setFrame:rect];
        [self.view addSubview:badge];
    }
    
  //必须是成员变量 才能实时监控网络变化
    _hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [_hostReach startNotifier];
    [_hostReach setNetworkChangeBlock:^(NetworkStatus status) {
        switch (status) {
            case NotReachable:
                NSLog(@"\n=====NoneNet\n");
                
                break;
            case ReachableViaWiFi:
                NSLog(@"\n=====WiFi\n");
                break;
            case ReachableViaWWAN:
                NSLog(@"\n=====WWAN\n");
                break;
            case kReachableVia2G:
                NSLog(@"\n=====2G\n");
                break;
            case kReachableVia3G:
                NSLog(@"\n=====3G\n");
                break;
            case kReachableVia4G:
                NSLog(@"\n=====4G\n");
                break;
            default:
                break;
        }

    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
