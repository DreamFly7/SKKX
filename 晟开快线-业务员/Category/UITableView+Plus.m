//
//  UITableView+Plus.m
//  Shoelace
//
//  Created by Cp.Li on 15/4/22.
//  Copyright (c) 2015年 Cp.Li All rights reserved.
//

#import "UITableView+Plus.h"

@implementation UITableView (Plus)


- (void)hideEmptySeparators{
    
    UIView *footerView = self.tableFooterView;
    
    if (footerView && footerView.tag == 1001) {
        return;
    }
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    v.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:v];
}


@end
