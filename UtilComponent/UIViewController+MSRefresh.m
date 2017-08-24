//
//  UIViewController+MSRefresh.m
//  Association
//
//  Created by Mark Yang on 9/7/16.
//  Copyright © 2016 com.missionsky. All rights reserved.
//

#import "UIViewController+MSRefresh.h"

@implementation UIViewController (MSRefresh)

- (void)loadRefreshHeader:(UIScrollView *)refreshView
                   action:(SEL)refreshAction
{
    // Header Refresh
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                     refreshingAction:refreshAction];
    [header.lastUpdatedTimeLabel setHidden:YES];
    [header setTitle:NSLocalizedStringFromTable(@"Pull down to refresh", nil, nil) forState:MJRefreshStateIdle];
    [header setTitle:NSLocalizedStringFromTable(@"Release to refresh", nil, nil) forState:MJRefreshStatePulling];
    [header setTitle:NSLocalizedStringFromTable(@"Refreshing ...", nil, nil) forState:MJRefreshStateRefreshing];
    [header.stateLabel setFont:[UIFont systemFontOfSize:15]];
    
    [refreshView setMj_header:header];
}//

- (void)loadLoadMoreFooter:(UIScrollView *)loadMoreView action:(SEL)loadMoreAction
{
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self
                                                                             refreshingAction:loadMoreAction];
    [footer setTitle:NSLocalizedStringFromTable(@"Drag up to load more", nil, nil) forState:MJRefreshStateIdle];
    [footer setTitle:NSLocalizedStringFromTable(@"Release to load more", nil, nil) forState:MJRefreshStatePulling];
    [footer setTitle:NSLocalizedStringFromTable(@"Loading more ...", nil, nil) forState:MJRefreshStateRefreshing];
    [footer setTitle:NSLocalizedStringFromTable(@"No more data", nil, nil) forState:MJRefreshStateNoMoreData];
    [footer.stateLabel setFont:[UIFont systemFontOfSize:15.0]];
    [loadMoreView setMj_footer:footer];
}//

#pragma mark -
#pragma mark SVProgress Show

- (void)showWithMaskType:(SVProgressHUDMaskType)maskType
{
    [SVProgressHUD setDefaultMaskType:maskType];
    [SVProgressHUD show];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}//

@end
