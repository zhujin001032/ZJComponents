//
//  UITableView+MKEmpty.m
//  MissionskyOA
//
//  Created by Mark Yang on 1/6/16.
//  Copyright © 2016 Missionsky. All rights reserved.
//

#import "UITableView+MKEmpty.h"
#import "ZJConstant.h"
const NSInteger kTouchTag = 1314000;

@interface UITableView ()

@end

#pragma mark -

@implementation UITableView (MKEmpty)

- (void)tableViewDisplayWithMessage:(NSString *)message
             ifNecessaryForRowCount:(NSInteger)rowCount
{
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        UILabel *messageLabel = [UILabel new];
        messageLabel.numberOfLines = 0;
        messageLabel.text = message;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}//


- (void)tableViewDisplayWithMessage:(NSString *)message
             ifNecessaryForRowCount:(NSInteger)rowCount
                         withTarget:(id)sender
                         withHandle:(SEL)sel
{
    UIView *tagView = [self viewWithTag:kTouchTag];
    /**
     *  @author Jason He, 16-05-30
     *
     *  @brief 修复ios8.4列表首次点击复制内容bug
     */
    if (tagView) {
        [tagView removeFromSuperview];
    }
    //end
    
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        UILabel *messageLabel = [UILabel new];
        messageLabel.numberOfLines = 0;
        messageLabel.text = message;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
//        messageLabel.font = kTITLE_FONT;
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:self.bounds];
        [btn setTag:kTouchTag];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:sender
                action:sel
      forControlEvents:UIControlEventTouchUpInside];
        
        // 优化用户体验
        // add by Mark 2016-10-08
        [btn addTarget:self
                action:@selector(btnTouchDown:)
      forControlEvents:UIControlEventTouchDown];
        
        [btn addTarget:self
                action:@selector(btnTouchUp:)
      forControlEvents:UIControlEventTouchCancel];
        
        [btn setShowsTouchWhenHighlighted:YES];
        // end add
        
        [self addSubview:btn];
    }
    else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        /**
         *  @author Jason He, 16-05-30
         *
         *  @brief 修复ios8.4列表首次点击复制内容bug
         */
        UIView *tagView = [self viewWithTag:kTouchTag];
        if (tagView) {
            [self sendSubviewToBack:tagView];
        }
        //end

    }
}//

#pragma mark -
#pragma mark index for table

- (UILabel *)indexLabel
{
    static CGFloat labelHeight = 64;
    UILabel *lbIndex = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width-labelHeight) / 2,
                                                                 (self.bounds.size.height-labelHeight) / 2,
                                                                 labelHeight,
                                                                 labelHeight)];
    lbIndex.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"flotageBackgroud"]];
    lbIndex.hidden = YES;
    lbIndex.textAlignment = NSTextAlignmentCenter;
    lbIndex.textColor = [UIColor whiteColor];
    [self addSubview:lbIndex];
//    [self insertSubview:lbIndex atIndex:0];
    
    
    return lbIndex;
}//

#pragma mark -

- (void)btnTouchDown:(id)sender
{
    if ([self.backgroundView isKindOfClass:[UILabel class]]) {
        [(UILabel *)(self.backgroundView) setTextColor:[UIColor grayColor]];
    }
}//

- (void)btnTouchUp:(id)sender
{
    if ([self.backgroundView isKindOfClass:[UILabel class]]) {
        [(UILabel *)(self.backgroundView) setTextColor:[UIColor lightGrayColor]];
    }
}//

@end
