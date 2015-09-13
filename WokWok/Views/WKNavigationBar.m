//
//  WKNavigationBar.m
//  WokWok
//
//  Created by 王坜 on 15/9/7.
//  Copyright (c) 2015年 王坜. All rights reserved.
//

#import "WKNavigationBar.h"

@implementation WKNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customizeBar];
    }
    
    return self;
}


- (void)customizeBar
{
    self.opaque = NO;
    
    // 1.设置导航栏的背景图片
    self.tintColor = [UIColor whiteColor];
    [self setBackgroundImage:[UIImage imageNamed:@"NaviBar"] forBarMetrics:UIBarMetricsDefault];
    
    // 2.标题
    [self setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     }];
    
}


@end
