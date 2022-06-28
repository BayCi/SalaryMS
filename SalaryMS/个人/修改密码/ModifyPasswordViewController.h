//
//  ModifyPasswordViewController.h
//  SalaryMS
//
//  Created by BayCi Gou on 2020/9/3.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModifyPasswordViewController : UIViewController
{
    UITextField *originalPassword;//原始密码
    UITextField *againPassword;//再次输入密码
    UITextField *newPassword;//新密码
    UIButton *updateButton;//更新按钮
}
@property (nonatomic,copy)NSString *username;//用户名

@end

NS_ASSUME_NONNULL_END
