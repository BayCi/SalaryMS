//
//  ModificationInfoViewController.h
//  SalaryMS
//
//  Created by BayCi Gou on 2020/9/1.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ModificationInfoViewController : UIViewController<ZCDropDownDelegate>{
    ListView *listView;
    UITextField *name;                    //需要添加的员工姓名
    UIButton *selectOffice;               //需要添加的科室
    UIButton *selectCareer;               //需要添加的职业
    UIButton *selectSex;                  //需要添加的员工性别
    UITextField *age;                     //需要添加的员工年龄
    UITextField *inputBaseSalary;         //需要添加的员工基本工资
    UITextField *inputWelfare;            //需要添加的员工福利补贴
    UITextField *inputBonusWage;          //需要添加的员工奖励工资
    UITextField *inputHousingFund;        //需要添加的员工住房公积金
    UITextField *inputUnemployInsurance;  //需要添加的员工失业保险
    
}
@property (nonatomic, retain)NSMutableArray *officeDataArr;
@property (nonatomic, retain)NSMutableArray *careerDataArr;
@property (nonatomic, retain)NSMutableArray *sexDataArr;

@property (nonatomic,copy)NSString *beModifiedEmployeeName;    //需要修改的员工名字
@property (nonatomic,copy)NSString *beModifiedEmployeeOffice;    //需要修改的员工科室
@property (nonatomic,copy)NSString *beModifiedEmployeeCareer;    //需要修改的员工职业
@property (nonatomic,copy)NSString *beModifiedEmployeeSex;    //需要修改的员工性别
@property (nonatomic,copy)NSString *beModifiedEmployeeAge;    //需要修改的员工年龄
@property (nonatomic,copy)NSString *beModifiedEmployeeBaseSalary;    //需要修改的员工基本工资
@property (nonatomic,copy)NSString *beModifiedEmployeeWefare;    //需要修改的员工福利补贴
@property (nonatomic,copy)NSString *beModifiedEmployeeBonusWage;    //需要修改的员工奖励工资
@property (nonatomic,copy)NSString *beModifiedEmployeeHousingFund;   //需要修改的员工失业保险 //需要修改的员工住房公积金
@property (nonatomic,copy)NSString *beModifiedEmployeeUnemployInsurance;    //需要修改的员工失业保险

@end

NS_ASSUME_NONNULL_END
