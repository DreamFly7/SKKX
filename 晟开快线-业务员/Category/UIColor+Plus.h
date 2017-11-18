//
//  UIColor+Plus.h
//  Shoelace
//
//  Created by Cp.Li on 15/4/23.
//  Copyright (c) 2015年 Cp.Li All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Plus)

+ (UIColor *) colorWithHexString: (NSString *) hexString;

-(BOOL)isEqualToColor:(UIColor *)otherColor;

+ (UIColor *)lightRandom;

@end
