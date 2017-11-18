//
//  UIButton+Plus.m
//  Shoelace
//
//  Created by Cp.Li on 15/4/21.
//  Copyright (c) 2015年 Cp.Li All rights reserved.
//

#import "UIButton+Plus.h"

@implementation UIButton (Plus)

-(void)setTitleColor:(UIColor *)color{
    [self setTitleColor:color forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
}

//-(void)

@end
