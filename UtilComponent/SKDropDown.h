//
//  SKDropDown.h
//  DropDownExample
//
//  Created by Sukru on 01.10.2013.
//  Copyright (c) 2013 Sukru. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT const CGFloat kDropDownCellHeight;

@class SKDropDown;

@protocol SKDropDownDelegate <NSObject>

@optional
- (void)skDropDownDelegateMethod:(SKDropDown *)sender withSelectedIndexPath:(NSIndexPath *)index;

@end

#pragma mark -

@interface SKDropDown : UIView <UITableViewDelegate, UITableViewDataSource>
{
    NSString *animationDirection;
}

@property (nonatomic, weak) id <SKDropDownDelegate> delegate;
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIView      *btnSender;
@property(nonatomic, retain) NSArray *list;

#pragma mark -

- (void)hideDropDown:(UIView *)b;
- (id)showDropDown:(UIView *)b
        withHeight:(CGFloat *)height
          withData:(NSArray *)arr
animationDirection:(NSString *)direction;

- (id)showDropDown:(UIView *)b
            inView:(UIView *)superView
        withHeight:(CGFloat *)height
          withData:(NSArray *)arr
animationDirection:(NSString *)direction;
/**
 *  @author Jason He, 16-04-14
 *
 *  @brief 居中显示 待完善
 *
 *  @param superView <#superView description#>
 *  @param height    <#height description#>
 *  @param width     <#width description#>
 *  @param arr       <#arr description#>
 *
 *  @return <#return value description#>
 */
- (id)showDropDowninView:(UIView *)superView
        withHeight:(CGFloat *)height
        withWidth:(CGFloat *)width
          withData:(NSArray *)arr;
/**
 *  @author Jason He, 16-04-16
 *
 *  @brief 添加自定义宽度
 *
 *  @param b         <#b description#>
 *  @param superView <#superView description#>
 *  @param height    <#height description#>
 *  @param width     指定宽度，大于b的宽度有效
 *  @param arr       <#arr description#>
 *  @param direction 方向参数 使用：right_down right_up 表示在靠屏幕的 右侧向下或者向上显示，其他left_down left_up 可以直接用down up
 *
 *  @return <#return value description#>
 */
- (id)showDropDown:(UIView *)b
            inView:(UIView *)superView
        withHeight:(CGFloat *)height
        withWidth:(CGFloat *)width
          withData:(NSArray *)arr
animationDirection:(NSString *)direction;

@end
