//
//  UIViewController+MSRefresh.h
//  Association
//
//  Created by Mark Yang on 9/7/16.
//  Copyright © 2016 com.missionsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>

@interface UIViewController (MSRefresh)

- (void)loadRefreshHeader:(UIScrollView *)refreshView action:(SEL)refreshAction;
- (void)loadLoadMoreFooter:(UIScrollView *)loadMoreView action:(SEL)loadMoreAction;

#pragma mark -
#pragma mark SVProgress Show

- (void)showWithMaskType:(SVProgressHUDMaskType)maskType;

@end

