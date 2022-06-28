//
//  YGViewController.h
//  CustomTableViewCell
//
//  Created by yangguang on 13-10-15.
//  Copyright (c) 2013年 atany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

//学生
#define nameTag          1
#define classTag         2
#define stuNumberTag     3
#define imageTag         4
#define nameFontSize    15
#define fontSize        12

//老师
#define teaNameTag       1     //姓名
#define teaTypeTag       2     //类型
#define teaOfficeTag     3     //办公室
#define teaTotalSalaryTag     4     //总工资
#define teaSexTag     5     //性别
#define teaAgeTag     6     //年龄
#define teaAdminOfficeTag     7     //科室
#define teaPositionTag     8     //职位
#define teaOrganizationTag     9     //单位
#define teaBaseSalaryTag     10     //基本工资
#define teaWelfareTag     11     //福利补贴
#define teaBonusSalaryTag     12     //奖励工资
#define teaUnemployInsuranceTag     13     //失业保险
#define teaHousingFundTag     14     //住房公积金


@interface YGViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    UITableView *YGtableView;
    UITableViewCell *cell;
}

@property (weak, nonatomic) IBOutlet UILabel *totalSalary;

@property (retain,nonatomic) NSArray *stuArray;//学生资料
@property (retain,nonatomic) NSMutableArray *teaArray;//老师资料
@property (retain, nonatomic) IBOutlet UITableViewCell *teaCell;

@property (weak, nonatomic) IBOutlet UILabel *resNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *resSexLabel;
@property (weak, nonatomic) IBOutlet UILabel *resAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *resOfficeLabel;
@property (weak, nonatomic) IBOutlet UILabel *resCareerLabel;
@property (weak, nonatomic) IBOutlet UILabel *resCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *resTotalSalaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *resBaseSalaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *resWelfareLabel;
@property (weak, nonatomic) IBOutlet UILabel *resRewardsLabel;
@property (weak, nonatomic) IBOutlet UILabel *resUnemployInsuranceLabel;
@property (weak, nonatomic) IBOutlet UILabel *ResHousingFundLabel;


@property (nonatomic,copy)NSString *queryName;   //需要查询的员工名
@property (nonatomic,copy)NSString *queryOffice; //需要查询的员工科室
@property (nonatomic,copy)NSString *queryCareer;//需要查询的员工职业
@property (nonatomic,copy)NSString *querySex;    //需要查询的员工性别
@property (nonatomic,copy)NSString *queryAge;    //需要查询的员工年龄

@end
