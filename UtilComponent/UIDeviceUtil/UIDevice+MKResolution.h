//
//  UIDevice+MKResolution.h
//
//

#import <UIKit/UIKit.h>


@interface UIDevice (MKResolution)


+ (NSString *)deviceModelName;
/**
 *	@brief	当前是否运行在iPhone端
 *
 *	@return 是否运行在iPhone端标识
 *
 */
+ (BOOL)isRunningOniPhone;

@end
