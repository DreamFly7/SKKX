//
//  UIView+Plus.m
//  Shoelace
//
//  Created by Cp.Li on 15/4/23.
//  Copyright (c) 2015年 Cp.Li All rights reserved.
//

#import "UIView+Plus.h"

@implementation UIView (Plus)

-(CGFloat)x         {   return self.frame.origin.x;         }
-(CGFloat)y         {   return self.frame.origin.y;         }
-(CGFloat)width     {   return self.frame.size.width;       }
-(CGFloat)height    {   return self.frame.size.height;      }
-(CGPoint)origin    {   return self.frame.origin;           }
-(CGSize)size       {   return self.frame.size;             }
-(CGFloat)left      {   return CGRectGetMinX(self.frame);   }
-(CGFloat)right     {   return CGRectGetMaxX(self.frame);   }
-(CGFloat)top       {   return CGRectGetMinY(self.frame);   }
-(CGFloat)bottom    {   return CGRectGetMaxY(self.frame);   }
-(CGFloat)centerX   {   return self.center.x;               }
-(CGFloat)centerY   {   return self.center.y;               }
-(CGPoint)boundsCenter  {   return CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));   };


-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    frame.size.width = MAX(self.right-left, 0);
    self.frame = frame;
}

-(void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.size.width = MAX(right-self.left, 0);
    self.frame = frame;
}

-(void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    frame.size.height = MAX(self.bottom-top, 0);
    self.frame = frame;
}

-(void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.size.height = MAX(bottom-self.top, 0);
    self.frame = frame;
}

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}






//-(void)addSubFullView:(UIView *)view{
//
//    float left = 0;
//    float top = 0;
//    float width = kWidth(self);
//    float height = kHeight(self);
//    CGRect frame = CGRectMake(left, top, width, height);
//    view.frame = frame;
//
//    [self addSubview:view];
//
//}



- (UIView*)superviewWithClass:(Class)class{
    
    UIView *superview = nil;
    superview = self.superview;
    while (superview != nil && ![superview isKindOfClass:class]) {
        superview = superview.superview;
    }
    return superview;
}



- (void)earthquake{
    
    UIView *itemView = self;
    CGFloat t = 2.0;
    CGAffineTransform leftQuake = CGAffineTransformTranslate(CGAffineTransformIdentity, t, -t);
    CGAffineTransform rightQuake = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, t);
    itemView.transform = leftQuake;
    [UIView beginAnimations:@"earthquake" context:(__bridge void *)(itemView)];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:2];
    [UIView setAnimationDuration:0.05];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(earthquakeEnded:finished:context:)];
    itemView.transform = rightQuake;
    [UIView commitAnimations];
}

- (void)earthquakeEnded:(NSString *)animation finished:(NSNumber *)finished context:(void *)context {
    if ([finished boolValue]) {
        UIView *item = (__bridge UIView *) context;
        
        item.transform = CGAffineTransformIdentity;
    }
}



-(void)setRadiusByCorners:(UIRectCorner)corners radius:(float)radius{
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius,radius)];
    
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}


@end
