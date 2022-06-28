//
//  RegisterViewController.h
//  SalaryMS
//
//  Created by BayCi Gou on 2020/8/17.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewController : UIViewController
{
    UITextField *inputName;//登陆用户名
    UITextField *inputPassword;//登陆密码
    UIButton *RegisterButton;//登陆按钮
}
@property (nonatomic,copy)NSString *queryUsername;//用户名
@property (nonatomic,copy)NSString *queryUsProfession;//用户职业
@property (nonatomic,copy)NSString *queryOffice;//用户科室
@property (nonatomic,copy)NSString *queryCompany;//用户公司

@end

NS_ASSUME_NONNULL_END
