//
//  UIViewController+Plus.h
//  Shoelace
//
//  Created by Cp.Li on 15/4/21.
//  Copyright (c) 2015年 Cp.Li All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Plus)

//right button
-(UIButton *)createRightButtonWithImageName:(NSString *)image;
-(UIButton*)createRightButtonWithTitle:(NSString *)title;

//left button
-(UIButton*)createLeftButtonWithTitle:(NSString *)title;
-(UIButton*)createLeftButtonWithImgName:(NSString *)image;

////back button
-(UIButton *)createCustomCancelBtn;
-(UIButton *)createCustomBackBtn;

//back button
-(void)createBackButtonWithPopAction;
-(void)createBackBtnWithDismissAction;

-(void)closeKeyBoardTapAnyway;

@end
