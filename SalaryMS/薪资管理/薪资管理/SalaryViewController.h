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
    UITextField *name;
    UIButton *selectOffice;
    UIButton *selectCareer;
    UIButton *selectSex;
    UITextField *age;
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
