//
//  WKConveneViewController.m
//  WokWok
//
//  Created by 王坜 on 15/8/13.
//  Copyright (c) 2015年 王坜. All rights reserved.
//

#import "WKConveneViewController.h"
#import "WKConveneListViewController.h"
#import "WMPageController.h"

@interface WKConveneViewController ()
{
    WMPageController *_pageController;
}

@end

@implementation WKConveneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self makePageController];
    [self makeLocalButton];
}



- (void)makePageController
{
    Class class1 = [WKConveneListViewController class];
    Class class2 = [WKConveneListViewController class];
    Class class3 = [WKConveneListViewController class];

    NSArray *viewControllers = @[class1, class2, class3];
    NSArray *titles = @[@"最新", @"热门", @"收藏"];
    
    _pageController = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    _pageController.pageAnimatable = YES;
    _pageController.menuItemWidth = 60;
    //pageController.postNotification = YES;
    _pageController.view.backgroundColor = [UIColor clearColor];
    _pageController.menuBGColor = [UIColor clearColor];
    _pageController.menuViewStyle = WMMenuViewStyleLine;
    _pageController.titleColorSelected = [UIColor whiteColor];
    _pageController.titleColorNormal = [UIColor lightTextColor];
    _pageController.titleSizeSelected = 18;
    _pageController.titleSizeNormal = 18;
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    CGRect frame = _pageController.view.frame;
    frame.origin.y = statusBarHeight;
    frame.size.height -= (statusBarHeight + tabBarHeight + 9);
    _pageController.view.frame = frame;
    
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
}


- (void)localAction
{
    
}

- (void)makeLocalButton
{
    NSString *local = @"上海";
    
    CGSize size = [local newSizeWithFont:[UIFont systemFontOfSize:16] forWidth:80 lineBreakMode:NSLineBreakByTruncatingTail];

    UPLabel *label = [AIViews normalLabelWithFrame:CGRectMake(0, (kNavigationBarHeight - size.height)/2, size.width, kNavigationBarHeight) text:local fontSize:16 color:[UIColor whiteColor]];
    label.userInteractionEnabled = NO;
    
    UIButton *localButton = [AIViews baseButtonWithFrame:CGRectMake(0, 0, 80, kNavigationBarHeight) normalTitle:nil];
    [localButton setTitle:local forState:UIControlStateNormal];
    [localButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [localButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    localButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    localButton.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [localButton addTarget:self action:@selector(localAction) forControlEvents:UIControlEventTouchUpInside];
    localButton.titleLabel.font = [UIFont systemFontOfSize:16];
    //[localButton addSubview:label];
    
    [_pageController.view addSubview:localButton];
}

- (void)addAction
{
    
}

- (void)makeAddButton
{
    
}

- (void)makeAddtionView
{
    
}

- (void)publishAction
{
    
    
}

- (void)filterAction
{
    
}

@end
