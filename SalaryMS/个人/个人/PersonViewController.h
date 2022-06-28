//
//  PersonViewController.h
//  SalaryMS
//
//  Created by BayCi Gou on 2020/8/17.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *TableView;
    UITableViewCell *Cell;
    UIWindow *window;
}
@property (nonatomic,copy)NSString *username;//用户名
@property (nonatomic,copy)NSString *profession;//用户职业
@property (nonatomic,copy)NSString *office;//用户科室
@property (nonatomic,copy)NSString *company;//用户公司
@property (nonatomic)bool state;//用户登陆状态

@end

NS_ASSUME_NONNULL_END
