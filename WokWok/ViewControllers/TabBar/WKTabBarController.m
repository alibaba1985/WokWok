//
//  WKTabBarController.m
//  WokWok
//
//  Created by 王坜 on 15/8/13.
//  Copyright (c) 2015年 王坜. All rights reserved.
//

#import "WKTabBarController.h"
#import "WKNavigationController.h"
#import "WKConveneViewController.h"
#import "WKMessageViewController.h"
#import "WKEventViewController.h"
#import "WKDiscoveryViewController.h"
#import "WKUserViewController.h"

@interface WKTabBarController ()
{
    NSMutableArray *_customTabBarItems;
    NSMutableArray *_customViewControllers;
}

@end

@implementation WKTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureProperties];
    [self makeViewControllers];
    [self makeTabBarItems];
    
}


- (void)configureProperties
{
    self.tabBar.tintColor = [UIColor redColor];
}


- (void)makeViewControllers
{
    NSArray *classes = @[[WKConveneViewController class],
                         [WKMessageViewController class],
                         [WKEventViewController class],
                         [WKDiscoveryViewController class],
                         [WKUserViewController class]];
    
    _customViewControllers = [[NSMutableArray alloc] init];
    
    for (Class class in classes) {
        WKNavigationController *navi = [self navigationControllerWithClass:class];
        [_customViewControllers addObject:navi];
        
    }
    
    self.viewControllers = _customViewControllers;
    
}


- (WKNavigationController *)navigationControllerWithClass:(Class)class
{
    UIViewController *viewController = [[class alloc] init];
    WKNavigationController *naviController = [[WKNavigationController alloc] initWithRootViewController:viewController];
    
    return naviController;
    
}


- (void)makeTabBarItems
{
    _customTabBarItems = [[NSMutableArray alloc] init];
    
    NSArray *titles = @[@"召集", @"消息", @"活动", @"发现", @"我的"];
    NSArray *normalImages = @[@"Tab1_Normal", @"Tab4_Normal", @"Tab3_Normal", @"Tab4_Normal", @"Tab5_Normal"];
    NSArray *selectedImages = @[@"Tab1_Selected", @"Tab4_Selected", @"Tab3_Selected", @"Tab4_Selected", @"Tab5_Selected"];
    
    for (NSInteger i = 0; i < 5; i++) {
        
        NSString *title = [titles objectAtIndex:i];
        UIImage *normalImage = [UIImage imageNamed:[normalImages objectAtIndex:i]];
        UIImage *selectedImage = [UIImage imageNamed:[selectedImages objectAtIndex:i]];
        
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
        [_customTabBarItems addObject:item];
        UIViewController *viewController = [_customViewControllers objectAtIndex:i];
        viewController.tabBarItem = item;
    }
}


@end
