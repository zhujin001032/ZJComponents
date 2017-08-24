//
//  SKDropDown.m
//  DropDownExample
//
//  Created by Sukru on 01.10.2013.
//  Copyright (c) 2013 Sukru. All rights reserved.
//

#import "SKDropDown.h"
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "UIColor+MKHex.h"
#import "UIView+MKFrame.h"
#define MAIN_BG_COLOR   [UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1.0]

const CGFloat kDropDownCellHeight = 40.0;

static CGFloat kAnimationDuration = 0.25;

@implementation SKDropDown

- (id)showDropDown:(UIView *)b
        withHeight:(CGFloat *)height
          withData:(NSArray *)arr
animationDirection:(NSString *)direction
{
    _btnSender = b;
    animationDirection = direction;
    self.table = (UITableView *)[super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        // Initialization code
        CGRect btn = b.frame;
        self.list = [NSArray arrayWithArray:arr];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, -5);
        }else if ([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, 5);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        _table.delegate = self;
        _table.dataSource = self;
        _table.layer.cornerRadius = 5;
//        _table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
        [_table setBackgroundColor:[UIColor whiteColor]];
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _table.separatorColor = [UIColor grayColor];
        [_table setLayoutMargins:UIEdgeInsetsZero];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kAnimationDuration];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y-*height, btn.size.width, *height);
        } else if([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, *height);
        }
        _table.frame = CGRectMake(0, 0, btn.size.width, *height);
        [UIView commitAnimations];
        [b.superview addSubview:self];
        [self addSubview:_table];
    }
    return self;
}

- (id)showDropDown:(UIView *)b
            inView:(UIView *)superView
        withHeight:(CGFloat *)height
          withData:(NSArray *)arr
animationDirection:(NSString *)direction
{
    _btnSender = b;
    animationDirection = direction;
    self.table = (UITableView *)[super init];
    if (self) {
        // Initialization code
        CGRect aRect = [b convertRect:b.bounds toView:superView];
        self.list = [NSArray arrayWithArray:arr];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(aRect.origin.x,
                                    aRect.origin.y,
                                    aRect.size.width,
                                    0);
            self.layer.shadowOffset = CGSizeMake(-5, -5);
        }
        else if ([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(aRect.origin.x,
                                    aRect.origin.y+aRect.size.height,
                                    aRect.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, 5);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, aRect.size.width, 0)];
        [_table setDataSource:self];
        [_table setDelegate:self];
        [_table.layer setCornerRadius:5];
        [_table setBackgroundColor:[UIColor whiteColor]];
        [_table setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [_table setSeparatorColor:kHexRGB(0xCCCCCC)];
        [_table setLayoutMargins:UIEdgeInsetsZero];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kAnimationDuration];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(aRect.origin.x,
                                    aRect.origin.y-*height,
                                    aRect.size.width,
                                    *height);
        }
        else if([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(aRect.origin.x,
                                    aRect.origin.y+aRect.size.height,
                                    aRect.size.width,
                                    *height);
        }
        _table.frame = CGRectMake(0, 0, aRect.size.width, *height);
        [UIView commitAnimations];
        [superView addSubview:self];
        if ([superView isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)superView setScrollEnabled:NO];
        }
        [self addSubview:_table];
    }
    return self;
}//


- (id)showDropDowninView:(UIView *)superView
              withHeight:(CGFloat *)height
               withWidth:(CGFloat *)width
                withData:(NSArray *)arr{
    
    
    self.table = (UITableView *)[super init];
    if (self) {
        // Initialization code
        self.list = [NSArray arrayWithArray:arr];
        
        self.frame = CGRectMake((superView.mkWidth - *width)*0.5,
                                (superView.mkHeight - *height)*0.5,
                                *width,
                                0);
        self.layer.shadowOffset = CGSizeMake(-5, -5);
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, *width, 0)];
        [_table setDataSource:self];
        [_table setDelegate:self];
        [_table.layer setCornerRadius:5];
        [_table setBackgroundColor:[UIColor whiteColor]];
        [_table setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [_table setSeparatorColor:kHexRGB(0xCCCCCC)];
        [_table setLayoutMargins:UIEdgeInsetsZero];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kAnimationDuration];
        
        self.frame = CGRectMake((superView.mkWidth - *width)*0.5,
                                (superView.mkHeight - *height)*0.5,
                                *width,
                                *height);
        
        _table.frame = CGRectMake(0, 0, *width, *height);
        [UIView commitAnimations];
        [superView addSubview:self];
        if ([superView isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)superView setScrollEnabled:NO];
        }
        [self addSubview:_table];
    }
    return self;
}//


- (id)showDropDown:(UIView *)b
            inView:(UIView *)superView
        withHeight:(CGFloat *)height
        withWidth:(CGFloat *)width
          withData:(NSArray *)arr
animationDirection:(NSString *)direction
{
    _btnSender = b;
    animationDirection = direction;
    self.table = (UITableView *)[super init];
    if (self) {
        // Initialization code
        CGRect aRect = [b convertRect:b.bounds toView:superView];
        if (*width > b.mkWidth) {
            if ([direction isEqualToString:@"right_down"] || [direction isEqualToString:@"right_up"]) {//指靠屏幕的右侧显示，往左方向扩宽
                aRect.origin.x -= *width - b.mkWidth;
                aRect.size.width = *width;
            }else
            {
                aRect.size.width = *width;
            }
        
        }
        
        self.list = [NSArray arrayWithArray:arr];
        if ([direction hasSuffix:@"up"]) {
            self.frame = CGRectMake(aRect.origin.x,
                                    aRect.origin.y,
                                    aRect.size.width,
                                    0);
            self.layer.shadowOffset = CGSizeMake(-5, -5);
        }
        else if ([direction hasSuffix:@"down"]) {
            self.frame = CGRectMake(aRect.origin.x,
                                    aRect.origin.y+aRect.size.height,
                                    aRect.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, 5);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, aRect.size.width, 0)];
        [_table setDataSource:self];
        [_table setDelegate:self];
        [_table.layer setCornerRadius:5];
        [_table setBackgroundColor:[UIColor whiteColor]];
        [_table setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [_table setSeparatorColor:kHexRGB(0xCCCCCC)];
        [_table setLayoutMargins:UIEdgeInsetsZero];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kAnimationDuration];
        if ([direction hasSuffix:@"up"]) {
            self.frame = CGRectMake(aRect.origin.x,
                                    aRect.origin.y-*height,
                                    aRect.size.width,
                                    *height);
        }
        else if([direction hasSuffix:@"down"]) {
            self.frame = CGRectMake(aRect.origin.x,
                                    aRect.origin.y+aRect.size.height,
                                    aRect.size.width,
                                    *height);
        }
        _table.frame = CGRectMake(0, 0, aRect.size.width, *height);
        [UIView commitAnimations];
        [superView addSubview:self];
        if ([superView isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)superView setScrollEnabled:NO];
        }
        [self addSubview:_table];
    }
    return self;
}//


- (void)hideDropDown{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimationDuration];
    
    self.frame = CGRectMake(self.mkCenterX, self.superview.mkCenterY,0 , 0);
    
    _table.frame = CGRectMake(self.mkCenterX, self.superview.mkCenterY,0 , 0);

    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)(self.superview) setScrollEnabled:YES];
    }
    [UIView commitAnimations];

}

-(void)hideDropDown:(UIView *)b
{
    if (!b) {
        [self hideDropDown];
        return;
    }
    CGRect btn = [b convertRect:b.bounds toView:self.superview];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimationDuration];
    if ([animationDirection hasSuffix:@"up"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
    }
    else if ([animationDirection hasSuffix:@"down"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
    }
    _table.frame = CGRectMake(0, 0, btn.size.width, 0);
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)(self.superview) setScrollEnabled:YES];
    }
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kDropDownCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.list count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
                                         forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsZero];  // must
    // 8.0+ OK
    [cell setLayoutMargins:UIEdgeInsetsZero];
}//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        if ([_btnSender isKindOfClass:[UITextField class]]) {
//            [cell setIndentationWidth:40];
            [cell setIndentationLevel:1];
            [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
        }
        else {
            [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
//            [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        }
    }
    
    cell.textLabel.text =[_list objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    
    UIView * v = [[UIView alloc] init];
    [v setBackgroundColor:MAIN_BG_COLOR];
    [cell setSelectedBackgroundView:v];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hideDropDown:_btnSender];
    
//    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
//    [_btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
    
//    if (![_btnSender isKindOfClass:[UITextField class]]) {
//        for (UIView *subview in _btnSender.subviews) {
//            if ([subview isKindOfClass:[UIImageView class]]) {
//                [subview removeFromSuperview];
//            }
//        }
//    }
    
    if ([_delegate respondsToSelector:@selector(skDropDownDelegateMethod:withSelectedIndexPath:)]) {
        [_delegate skDropDownDelegateMethod:self withSelectedIndexPath:indexPath];
    }
}

@end
