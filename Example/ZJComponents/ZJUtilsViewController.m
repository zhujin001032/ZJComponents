//
//  ZJUtilsViewController.m
//  ZJComponents
//
//  Created by 何助金 on 2017/3/9.
//  Copyright © 2017年 maxtian. All rights reserved.
//

#import "ZJUtilsViewController.h"

@interface ZJUtilsViewController ()

@end

@implementation ZJUtilsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *image = [UIImage  imageWithColor:[UIColor redColor]];
    UITableView *table = [UITableView new];
    [self loadRefreshHeader:table action:@selector(refresh)];
    UIImageView *imgView = [UIImageView new];
    [imgView sd_setImageWithURL:nil placeholderImage:image];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
