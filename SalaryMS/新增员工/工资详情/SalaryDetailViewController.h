//
//  SalaryDetailViewController.h
//  SalaryMS
//
//  Created by BayCi Gou on 2020/8/17.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SalaryDetailViewController : UIViewController
{
    UITextField *inputBaseSalary;         //需要添加的员工基本工资
    UITextField *inputWelfare;            //需要添加的员工福利补贴
    UITextField *inputBonusWage;          //需要添加的员工奖励工资
    UITextField *inputHousingFund;        //需要添加的员工住房公积金
    UITextField *inputUnemployInsurance;  //需要添加的员工失业保险
}
    
@property (nonatomic,copy)NSString *inputName;   //需要添加的员工名
@property (nonatomic,copy)NSString *inputOffice; //需要添加的员工科室
@property (nonatomic,copy)NSString *inputCareer; //需要添加的员工职业
@property (nonatomic,copy)NSString *inputSex;    //需要添加的员工性别
@property (nonatomic,copy)NSString *inputAge;    //需要添加的员工年龄
@end

NS_ASSUME_NONNULL_END
