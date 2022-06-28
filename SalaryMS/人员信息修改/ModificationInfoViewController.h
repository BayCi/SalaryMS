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
    UITextField *name;                    //修改页面的员工姓名
    UIButton *selectOffice;               //修改页面的员工科室
    UIButton *selectCareer;               //修改页面的员工职业
    UIButton *selectSex;                  //修改页面的员工性别
    UITextField *age;                     //修改页面的员工年龄
    UITextField *inputBaseSalary;         //修改页面的员工基本工资
    UITextField *inputWelfare;            //修改页面的员工福利补贴
    UITextField *inputBonusWage;          //修改页面的员工奖励工资
    UITextField *inputHousingFund;        //修改页面的员工住房公积金
    UITextField *inputUnemployInsurance;  //修改页面的员工失业保险
    NSString *selectSqlInfo;//查询信息查询sql语句
//    int infoCount;//存储查询信息的个数
//    NSString *info;//存储查询信息的临时变量
    NSMutableArray *mutableArray;//存储临时变量的可变数组
    
}
@property (nonatomic, retain)NSMutableArray *officeDataArr;
@property (nonatomic, retain)NSMutableArray *careerDataArr;
@property (nonatomic, retain)NSMutableArray *sexDataArr;
@property (nonatomic, retain)UITableView *tableView;//用于数据显示的表格视图

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
