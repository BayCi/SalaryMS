//
//  SalaryViewController.h
//  SalaryMS
//
//  Created by BayCi Gou on 2020/8/17.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SalaryViewController : UIViewController<ZCDropDownDelegate>{
    ListView *listView;
    UITextField *name;//姓名输入框
    UIButton *selectOffice;//科室下拉框按钮
    UIButton *selectCareer;//职业下拉框按钮
    UIButton *selectSex;//性别下拉框按钮
    UITextField *age;//年龄输入框
//    NSString *selectSqlInfoCount;//查询信息count查询sql语句
    NSString *selectSqlInfo;//查询信息查询sql语句
//    int infoCount;//存储查询信息的个数
//    NSString *info;//存储查询信息的临时变量
    NSMutableArray *mutableArray;//存储临时变量的可变数组
    
}
@property (nonatomic, retain)NSMutableArray *officeDataArr;
@property (nonatomic, retain)NSMutableArray *careerDataArr;
@property (nonatomic, retain)NSMutableArray *sexDataArr;

@property (nonatomic,copy)NSString *inputName;   //需要查询的员工名
@property (nonatomic,copy)NSString *inputOffice; //需要查询的员工科室
@property (nonatomic,copy)NSString *inputCareer;//需要查询的员工职业
@property (nonatomic,copy)NSString *inputSex;    //需要查询的员工性别
@property (nonatomic,copy)NSString *inputAge;    //需要查询的员工年龄

@end

NS_ASSUME_NONNULL_END
