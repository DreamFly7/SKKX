//
//  UIViewController+Plus.m
//  Shoelace
//
//  Created by Cp.Li on 15/4/21.
//  Copyright (c) 2015年 Cp.Li All rights reserved.
//

#import "UIViewController+Plus.h"
#import "Imports.h"

@implementation UIViewController (Plus)


#pragma mark- On Nav Bars

-(void)createBackBtnWithDismissAction{
    hAddEvent([self createCustomCancelBtn],cancelAction);
}

-(void)createBackButtonWithPopAction{
    hAddEvent([self createCustomBackBtn], popBack);
}


-(void)createCustomBackBtnWithInnerAction:(NSString *)imageName{
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:0];
    [button setFrame:CGRectMake(0, 0,32,32)];
    button.showsTouchWhenHighlighted = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    hAddEvent(button, popBack);
}

-(UIButton *)createCustomCancelBtn{
    
    NSString * imageName = @"backBtn_default";
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:0];
    [button setFrame:CGRectMake(0, 0,32,32)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(7, 0, 7, 8)];
    button.showsTouchWhenHighlighted = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return button;
    
}

-(UIButton *)createCustomBackBtn{
    
    UIImage *image = [[UIImage imageNamed:@"zuojiantou"] imageWithTintColor:[UIColor whiteColor]];
    
    UIButton *button =  [[UIButton alloc]initWithFrame:CGRectMake(0, 0,21,18)];
    [button setImage:image forState:UIControlStateNormal];
//    button setImageEdgeInsets:UIEdgeInsetsMake(0, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return button;
}

-(void)closeKeyBoardTapAnyway{
    hAddGestureSingleTab(self.view, closekeyboard);
}

-(void)closekeyboard{
    [self.view endEditing:YES];
}



//leftButton with title
-(UIButton*)createLeftButtonWithTitle:(NSString *)title{
    
    UIButton *button = [self createLeftBarItemButton];
    [button setTitle:title];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return button;
    
}

//leftButton with title
-(UIButton*)createLeftButtonWithImgName:(NSString *)image{
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[[UIImage imageNamed:image] imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0,32,32)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(8, 3, 8, 7)];
    button.showsTouchWhenHighlighted = YES;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    return button;
    
}

-(UIButton *)createLeftBarItemButton{
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0,80,32)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor whiteColor]];
    
    return button;
}



//rightButton with image
-(UIButton *)createRightButtonWithImageName:(NSString *)image{
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[[UIImage imageNamed:image] imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0,32,32)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    button.showsTouchWhenHighlighted = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return button;

}

//rightButton with title
-(UIButton*)createRightButtonWithTitle:(NSString *)title{
    
    UIButton *button = [self createRightBarItemButton];
    [button setTitle:title];
    button.titleLabel.font = hFontSize(15);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return button;
    
}

-(UIButton *)createRightBarItemButton{
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0,80,32)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.titleLabel.font = hFontSize(15);
    [button setTitleColor:[UIColor whiteColor]];
    
    return button;
}






-(void)popBack{
    hPopViewController;
}


-(void)cancelAction{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

@end
