//
//  TabBarViewController.h
//  SalaryMS
//
//  Created by BayCi Gou on 2020/8/17.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonViewController.h"
#import "SalaryViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface TabBarViewController : UITabBarController

@property (nonatomic, retain)SalaryViewController *view1;
@property (nonatomic, retain)PersonViewController *view2;

@end

NS_ASSUME_NONNULL_END
