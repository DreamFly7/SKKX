//
//  UIView+Plus.h
//  Shoelace
//
//  Created by Cp.Li on 15/4/23.
//  Copyright (c) 2015年 Cp.Li All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Plus)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat x, y, width, height;
@property (nonatomic, assign) CGFloat left, right, top, bottom;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, readonly) CGPoint boundsCenter;



//-(void)addSubFullView:(UIView *)view;
- (UIView*)superviewWithClass:(Class)class_;
- (void)earthquake;

-(void)setRadiusByCorners:(UIRectCorner)corners radius:(float)radius;
//-(UILabel *)subLabelViewWithIdentifier:(NSString *)identifier;

@end
