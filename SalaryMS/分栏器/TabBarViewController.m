//
//  TabBarViewController.m
//  SalaryMS
//
//  Created by BayCi Gou on 2020/8/17.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import "TabBarViewController.h"
#import "PersonViewController.h"
#import "SalaryViewController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];//设置底部分栏器的颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    _view1 =[[SalaryViewController alloc]init];
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"薪资管理" image:[UIImage imageNamed:@"Salary.png"] tag:101];
    _view1.tabBarItem = item1;
    UINavigationController *navigationController1 = [[UINavigationController alloc]initWithRootViewController:_view1];
    navigationController1.title = @"薪资管理";

    _view2 = [[PersonViewController alloc]init];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"个人" image:[UIImage imageNamed:@"Person.png"] tag:101];
    _view2.tabBarItem = item2;
    UINavigationController *navigationController2 = [[UINavigationController alloc]initWithRootViewController:_view2];
    navigationController2.title = @"个人";

    NSArray *viewController = @[navigationController1,navigationController2];

    [self setViewControllers:viewController animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden = YES;
    //self.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden = NO;
    //self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
}

@end
