//
//  SalaryDetailViewController.m
//  SalaryMS
//
//  Created by BayCi Gou on 2020/8/17.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import "SalaryDetailViewController.h"
#import "PersonalInfoViewController.h"
#import "sqlite3.h"
@interface SalaryDetailViewController ()
{
     char *error;
     sqlite3 * db;
}
@end

@implementation SalaryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [self colorWithHexString:@"EEEEEE" alpha:1.0f];
    //self.view.backgroundColor = [self colorWithHexString:@"FFC0CB" alpha:1.0f];
    
    self.navigationItem.title = @"工资详情";
    UILabel *PageTitle = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 175, 50)];
    PageTitle.textColor = [UIColor blackColor];
    PageTitle.text = @"工资详情";
    PageTitle.textAlignment = NSTextAlignmentCenter;
    [PageTitle setFont:[UIFont systemFontOfSize:25]];
    [self.view addSubview:PageTitle];
    
    UILabel *baseSalary = [[UILabel alloc]initWithFrame:CGRectMake(37.5, 120, 70, 30)];
    baseSalary.textColor = [UIColor blackColor];
    baseSalary.text = @"基本工资";
    [self.view addSubview:baseSalary];
    inputBaseSalary = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 155, 300, 30)];
    inputBaseSalary.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    inputBaseSalary.textColor = [UIColor blackColor];
    [inputBaseSalary setDelegate:self];
    inputBaseSalary.keyboardType = UIKeyboardTypeNumberPad;
    inputBaseSalary.clearButtonMode = UITextFieldViewModeAlways;
    inputBaseSalary.layer.borderWidth = 1;
    inputBaseSalary.layer.borderColor = [[UIColor blackColor] CGColor];
    inputBaseSalary.layer.cornerRadius = 5;
    [self.view addSubview:inputBaseSalary];
    
    UILabel *welfare = [[UILabel alloc]initWithFrame:CGRectMake(37.5, 195, 70, 30)];
    welfare.textColor = [UIColor blackColor];
    welfare.text = @"福利补贴";
    [self.view addSubview:welfare];
    inputWelfare = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 230, 300, 30)];
    inputWelfare.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    inputWelfare.textColor = [UIColor blackColor];
    [inputWelfare setDelegate:self];
    inputWelfare.keyboardType = UIKeyboardTypeNumberPad;
    inputWelfare.clearButtonMode = UITextFieldViewModeAlways;
    inputWelfare.layer.borderWidth = 1;
    inputWelfare.layer.borderColor = [[UIColor blackColor] CGColor];
    inputWelfare.layer.cornerRadius = 5;
    [self.view addSubview:inputWelfare];
    
    UILabel *bonusWage = [[UILabel alloc]initWithFrame:CGRectMake(37.5, 270, 70, 30)];
    bonusWage.textColor = [UIColor blackColor];
    bonusWage.text = @"奖励工资";
    [self.view addSubview:bonusWage];
    inputBonusWage = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 305, 300, 30)];
    inputBonusWage.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    inputBonusWage.textColor = [UIColor blackColor];
    [inputBonusWage setDelegate:self];
    inputBonusWage.keyboardType = UIKeyboardTypeNumberPad;
    inputBonusWage.clearButtonMode = UITextFieldViewModeAlways;
    inputBonusWage.layer.borderWidth = 1;
    inputBonusWage.layer.borderColor = [[UIColor blackColor] CGColor];
    inputBonusWage.layer.cornerRadius = 5;
    [self.view addSubview:inputBonusWage];
    
    UILabel *housingFund = [[UILabel alloc]initWithFrame:CGRectMake(37.5, 345, 90, 30)];
    housingFund.textColor = [UIColor blackColor];
    housingFund.text = @"住房公积金";
    [self.view addSubview:housingFund];
    inputHousingFund = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 380, 300, 30)];
    inputHousingFund.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    inputHousingFund.textColor = [UIColor blackColor];
    [inputHousingFund setDelegate:self];
    inputHousingFund.keyboardType = UIKeyboardTypeNumberPad;
    inputHousingFund.clearButtonMode = UITextFieldViewModeAlways;
    inputHousingFund.layer.borderWidth = 1;
    inputHousingFund.layer.borderColor = [[UIColor blackColor] CGColor];
    inputHousingFund.layer.cornerRadius = 5;
    [self.view addSubview:inputHousingFund];
    
    UILabel *unemployInsurance = [[UILabel alloc]initWithFrame:CGRectMake(37.5, 420, 70, 30)];
    unemployInsurance.textColor = [UIColor blackColor];
    unemployInsurance.text = @"失业保险";
    [self.view addSubview:unemployInsurance];
    inputUnemployInsurance = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 455, 300, 30)];
    inputUnemployInsurance.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    inputUnemployInsurance.textColor = [UIColor blackColor];
    [inputUnemployInsurance setDelegate:self];
    inputUnemployInsurance.keyboardType = UIKeyboardTypeNumberPad;
    inputUnemployInsurance.clearButtonMode = UITextFieldViewModeAlways;
    inputUnemployInsurance.layer.borderWidth = 1;
    inputUnemployInsurance.layer.borderColor = [[UIColor blackColor] CGColor];
    inputUnemployInsurance.layer.cornerRadius = 5;
    [self.view addSubview:inputUnemployInsurance];
    
    UIButton *previousButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    previousButton.layer.cornerRadius = 8.0;
    previousButton.frame = CGRectMake(70, 512, 45, 45);
    [previousButton setImage:[UIImage imageNamed:@"previous.png"] forState:(UIControlStateNormal)];
    
    //[previousButton setTitle:@"上一步" forState:(UIControlStateNormal)];
    //[previousButton setBackgroundColor:[UIColor greenColor]];
    [previousButton setTintColor:[UIColor darkGrayColor]];
    [self.view addSubview:previousButton];
    [previousButton addTarget:self action:@selector(previous_clickFuction) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *commitButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    commitButton.layer.cornerRadius = 8.0;
    commitButton.frame = CGRectMake(220, 512, 120, 45);
    [commitButton setTitle:@"添加" forState:(UIControlStateNormal)];
    commitButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];//设置按钮的标题字体类型及大小
    [commitButton setBackgroundColor:[UIColor greenColor]];
    [commitButton setTintColor:[UIColor whiteColor]];
    [self.view addSubview:commitButton];
    [commitButton addTarget:self action:@selector(commitFuction) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)previous_clickFuction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commitFuction{
    
//对新增员工的个人及薪资的输入信息进行判空操作，任一项输入信息内容为空则不进行插入操作，并返回薪资管理页面
    if (   (![_inputName  isEqual: @""] && (![_inputOffice  isEqual: @"请选择"] && ![_inputCareer  isEqual: @"请选择"] && ![_inputSex  isEqual: @"请选择"]) && ![_inputAge  isEqual: @""])
         &&
        (![inputBaseSalary.text  isEqual: @""] && ![inputWelfare.text  isEqual: @""] && ![inputBonusWage.text  isEqual: @""] && ![inputHousingFund.text  isEqual: @""] && ![inputUnemployInsurance.text  isEqual: @""] )   ) {
        NSLog(@"新增员工数据不为空！");
        [self openSqlite];
        [self creatTable];
        //对数据库插入操作结果进行判断
        if([self insertSql] == YES){
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"员工新增成功！" preferredStyle:(UIAlertControllerStyleAlert) ];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action){
                NSLog(@"员工新增成功已确认！");
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            [alertView addAction:sureAction];
            [self presentViewController:alertView animated:YES completion:nil];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"员工新增失败，请重试！" preferredStyle:(UIAlertControllerStyleAlert) ];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action){
                NSLog(@"员工新增失败已确认！");
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            [alertView addAction:sureAction];
            [self presentViewController:alertView animated:YES completion:nil];
        };
        [self closeSqlite];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        NSLog(@"信息未填写完善，新增失败，请重试！");
        
        UIAlertController *tipsAlertView = [UIAlertController alertControllerWithTitle:@"新增数据提示" message:@"信息未填写完善，新增失败，请重试！" preferredStyle:(UIAlertControllerStyleActionSheet)];
        
        UIView *subView = tipsAlertView.view.subviews.firstObject;//firstObject
        UIView *backgroundContentView = subView.subviews.firstObject;
        UIView *alertContentView = backgroundContentView.subviews.firstObject;
        [subView setBackgroundColor:[UIColor clearColor]];//设置最底层视图的颜色为透明色
        [backgroundContentView setBackgroundColor:[UIColor clearColor]];//设置背景视图的颜色为透明色
        //[alertContentView setBackgroundColor:[self colorWithHexString:@"F2C200" alpha:1.0f]];//设置alert整体视图的颜色为白色
        
        //title
        NSMutableAttributedString *alertControllerTitleStr = [[NSMutableAttributedString alloc]initWithString:@"新增数据提示"];
        [alertControllerTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, [[alertControllerTitleStr string] length])];
        [alertControllerTitleStr addAttribute:NSForegroundColorAttributeName value:[self colorWithHexString:@"FF0033" alpha:1.0f] range:NSMakeRange(0, [[alertControllerTitleStr string] length])];
        [tipsAlertView setValue:alertControllerTitleStr forKey:@"attributedTitle"];
        //message
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc]initWithString:@"信息未填写完善，新增失败，请重试！"];
        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0, [[alertControllerMessageStr string] length])];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, [[alertControllerMessageStr string] length])];
        [tipsAlertView setValue:alertControllerMessageStr forKey:@"attributedMessage"];
        
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定返回！");
            [self.navigationController popToRootViewControllerAnimated:YES];//返回根视图（薪资管理页面）
        }];
        [sure setValue:[UIColor whiteColor] forKey:@"titleTextColor"];//设置按钮的title颜色为白色
        [tipsAlertView addAction:sure];
        [self presentViewController:tipsAlertView animated:YES completion:nil];
    }
}

//工资总和计算方法
- (float)salarycalculatingFuction{
    float result = [inputBaseSalary.text floatValue] + [inputWelfare.text floatValue];
    return result;
}

-(void)openSqlite
{
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *databasePath = [[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"salaryMS_database.sqlite"] ];
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    NSString *realPath = [documentPath stringByAppendingPathComponent:@"salaryMS_database.sqlite"];

    NSLog(@"数据库所在路径：%@", realPath);
    
    //NSFileManager *fileManager = [NSFileManager defaultManager];
    const char *dbpath = [databasePath UTF8String];
    
    
        if (sqlite3_open(dbpath, &db)==SQLITE_OK)
        {
            NSLog(@"打开数据库");
        }else
        {
            NSLog(@"数据库打开失败");
        }
}

-(void)creatTable
{
     /*
     sql 语句，专门用来操作数据库的语句。
     create table if not exists 是固定的，如果表不存在就创建。
     myTable() 表示一个表，myTable 是表名，小括号里是字段信息。
     字段之间用逗号隔开，每一个字段的第一个单词是字段名，第二个单词是数据类型，primary key 代表主键，autoincrement 是自增。
     */
    NSString *createSql=@"create table if not exists member(e_name text(20) primary key,e_sex text(1),e_age integer,e_prof text(10),e_place text(10),e_depart text(5));create table if not exists wages(e_name text(20) primary key,basepay real(10),welfare real(10),rewards real(10),claim real(10),hfound real(10),r_wages real(10));create view if not exists realwages as select e_name,r_wages from wages;create table if not exists user(username text(10) primary key not null unique,password text not null,e_prof text(10),e_depart text(10),e_place text(5));";
    
    if (sqlite3_exec(db, [createSql UTF8String], NULL, NULL, &error)==SQLITE_OK){
        
        NSLog(@"成功创建表");
    }else{
            NSLog(@"创建错误信息：%s",error);
            //每次使用完清空错误信息，提供给下次使用
            sqlite3_free(error);
     }
}
-(BOOL)insertSql
{
    //插入记录
    //新增员工个人信息的插入sql语句
    NSString*infoInserSql=[NSString stringWithFormat:@"insert into member(e_name, e_sex,e_age,e_prof,e_place,e_depart) values ('%@','%@','%@','%@','%@','%@')",_inputName,_inputSex,_inputAge,_inputCareer,[NSString stringWithUTF8String:"新型有限公司"],_inputOffice];
    
    //新增员工个人各项工资的插入sql语句
    NSString*salaryInserSql=[NSString stringWithFormat:@"insert into wages(e_name, basepay,welfare,rewards,claim,hfound,r_wages) values ('%@','%@','%@','%@','%@','%@','%@')",_inputName,inputBaseSalary.text,inputWelfare.text,inputBonusWage.text,inputUnemployInsurance.text,inputHousingFund.text,[NSString stringWithFormat:@"%f",[self salarycalculatingFuction]]];
    
//    NSString*salaryInserSql=[NSString stringWithFormat:@"update wages set basepay = '%@', welfare = '%@', rewards = '%@', claim = '%@', hfound = '%@', r_wages = '%@' where e_name = '%@';",inputBaseSalary.text,inputWelfare.text,inputBonusWage.text,inputUnemployInsurance.text,inputHousingFund.text,[NSString stringWithFormat:@"%f",[self salarycalculation]],_inputName];
    
//    NSString*salaryInserSql=[NSString stringWithFormat:@"update wages set basepay = '%@', welfare = '%@', rewards = '%@', claim = '%@', hfound = '%@' where e_name = '%@';",inputBaseSalary.text,inputWelfare.text,inputBonusWage.text,inputUnemployInsurance.text,inputHousingFund.text,_inputName];
    
    if ((sqlite3_exec(db, [infoInserSql UTF8String], NULL, NULL, &error)==SQLITE_OK) && (sqlite3_exec(db, [salaryInserSql UTF8String], NULL, NULL, &error)==SQLITE_OK)) {
        NSLog(@"插入数据成功");
        NSLog(@"新增员工数据添加成功！");
        return YES;
    }else
    {
        NSLog(@"错误信息：%s",error);
        sqlite3_free(error);
        return NO;
    }
}
-(void)closeSqlite
{
    //关闭数据库
    int closeResult = sqlite3_close(db);
    while (closeResult == SQLITE_BUSY) {
        closeResult = SQLITE_OK;
        sqlite3_stmt *stmt = sqlite3_next_stmt(db, NULL);
        if (stmt != NULL) {
            closeResult = sqlite3_finalize(stmt);
            if (closeResult == SQLITE_OK) {
                closeResult = sqlite3_close(db);
                //NSLog(@"关闭数据库");
            }
        }
    }
    if (closeResult == SQLITE_OK) {
        NSLog(@"关闭数据库");
    }
}

//设置键盘隐藏手势
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    int movementDistance = -75; // tweak as needed
    float movementDuration = 0.3f; // tweak as needed
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];

}

- (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {//十六进制色号自定义颜色
    hexString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    NSRegularExpression *RegEx = [NSRegularExpression regularExpressionWithPattern:@"^[a-fA-F|0-9]{6}$" options:0 error:nil];
    NSUInteger match = [RegEx numberOfMatchesInString:hexString options:NSMatchingReportCompletion range:NSMakeRange(0, hexString.length)];
    
    if (match == 0) {return [UIColor clearColor];}
    
    NSString *rString = [hexString substringWithRange:NSMakeRange(0, 2)];
    NSString *gString = [hexString substringWithRange:NSMakeRange(2, 2)];
    NSString *bString = [hexString substringWithRange:NSMakeRange(4, 2)];
    unsigned int r, g, b;
    BOOL rValue = [[NSScanner scannerWithString:rString] scanHexInt:&r];
    BOOL gValue = [[NSScanner scannerWithString:gString] scanHexInt:&g];
    BOOL bValue = [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    if (rValue && gValue && bValue) {
        return [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:alpha];
    } else {
        return [UIColor clearColor];
    }
}
@end
