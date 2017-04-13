//
//  ZJMainTabViewController.m
//  ZJComponents
//
//  Created by 何助金 on 2017/3/9.
//  Copyright © 2017年 maxtian. All rights reserved.
//

#import "ZJMainTabViewController.h"
#import "ZJViewController.h"
#import "ZJUtilsViewController.h"

@interface ZJMainTabViewController ()

@end

@implementation ZJMainTabViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        ZJViewController *comVC = [[ZJViewController alloc]init];
        UINavigationController *navCom = [[UINavigationController alloc]initWithRootViewController:comVC];
        comVC.tabBarItem.image = [UIImage imageWithColor:[UIColor greenColor]withSize:CGSizeMake(30, 30) withCornerRadius:5];
        comVC.title = @"功能组件";

        ZJUtilsViewController *utilsVC = [[ZJUtilsViewController alloc]init];
        utilsVC.tabBarItem.title = @"工具组件";
        utilsVC.tabBarItem.image = [UIImage imageWithColor:[UIColor yellowColor]withSize:CGSizeMake(30, 30) withCornerRadius:5];
        
        UINavigationController *navUtil = [[UINavigationController alloc]initWithRootViewController:utilsVC];
        self.viewControllers = @[navCom,navUtil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
