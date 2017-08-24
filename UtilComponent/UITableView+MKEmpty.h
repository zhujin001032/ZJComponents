//
//  UITableView+MKEmpty.h
//  MissionskyOA
//
//  Created by Mark Yang on 1/6/16.
//  Copyright © 2016 Missionsky. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT const NSInteger kTouchTag;

@interface UITableView (MKEmpty)

- (void)tableViewDisplayWithMessage:(NSString *)message ifNecessaryForRowCount:(NSInteger)rowCount;

- (void)tableViewDisplayWithMessage:(NSString *)message
             ifNecessaryForRowCount:(NSInteger)rowCount
                         withTarget:(id)sender
                         withHandle:(SEL)sel;

#pragma mark -
#pragma mark index for table

- (UILabel *)indexLabel;

@end
