//
//  SalaryViewController.m
//  SalaryMS
//
//  Created by BayCi Gou on 2020/8/17.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import "SalaryViewController.h"
#import "PersonViewController.h"
#import "PersonalInfoViewController.h"
#import "SalaryDetailViewController.h"
#import "YGViewController.h"
//#import "QueryViewController.h"
#import "sqlite3.h"

#define office 0
#define career 1
#define sex 2
@interface SalaryViewController ()
{
     char *error;
     sqlite3 * db;
}
@end

@implementation SalaryViewController

//下拉框数据源初始化的方法实现
- (void)selectDataArr_initalize:(int)symbol
{
    NSLog(@"接收到的标志位：%d",symbol);
    NSLog(@"标志位：%d",office);
    
    switch (symbol) {
        case office:
            self.officeDataArr = [NSMutableArray array];
            //将数据库查询后的返回数据传给科室下拉框数据源数组
            self.officeDataArr = [self listReload:self.officeDataArr];
            break;

        case career:
            self.careerDataArr = [NSMutableArray array];
            //将数据库查询后的返回数据传给职业下拉框数据源数组
            self.careerDataArr = [self listReload:self.careerDataArr];
            break;

        case sex:
            self.sexDataArr = [NSMutableArray array];
            //将数据库查询后的返回数据传给性别下拉框数据源数组
            self.sexDataArr = [self listReload:self.sexDataArr];
            break;

        default:
            break;
    }
}

//下拉框数据刷新方法的实现，封装涉及到的数据库操作
- (NSMutableArray*)listReload:(NSMutableArray*)listMutableArray{
    [self openSqlite];
    [self creatTable];
    [self selectSql:selectSqlInfo];
    listMutableArray = self->mutableArray;
    NSLog(@"收到的可变数组内容为：%@",mutableArray);
    NSLog(@"可变数组内容为：%@",listMutableArray);
    [listMutableArray addObject:@"请选择"];
    [self closeSqlite];
    return listMutableArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [self colorWithHexString:@"EEEEEE" alpha:1.0f];
    //self.view.backgroundColor = [self colorWithHexString:@"FFC0CB" alpha:1.0f];
    self.navigationItem.title = @"薪资管理";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};//导航栏title颜色
    UIBarButtonItem *addBuuton = [[UIBarButtonItem alloc]initWithTitle:nil style:(UIBarButtonItemStylePlain) target:self action:@selector(add_clickFuction)];
    self.navigationItem.rightBarButtonItem = addBuuton;
    [self.navigationItem.rightBarButtonItem setImage:[[UIImage imageNamed:@"add.png"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    
    UILabel *Name = [[UILabel alloc]initWithFrame:CGRectMake(37.5, 100, 50, 30)];
    Name.text = @"姓名";
    Name.textColor = [UIColor blackColor];
    [self.view addSubview:Name];
    name = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 135, 300, 30)];
    name.textColor = [UIColor blackColor];
    name.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    [name setDelegate:self];
    name.clearButtonMode = UITextFieldViewModeAlways;
    name.layer.borderWidth = 1;
    name.layer.borderColor = [[UIColor blackColor] CGColor];
    name.layer.cornerRadius = 5;
    [self.view addSubview:name];
    _inputName = name.text;//保存想要查询的员工名
    
    UILabel *Office = [[UILabel alloc]initWithFrame:CGRectMake(37.5, 175, 50, 30)];
    Office.text = @"科室";
    Office.textColor = [UIColor blackColor];
    [self.view addSubview:Office];
//    UITextField *office = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 210, 300, 30)];
//    office.backgroundColor = [UIColor systemGray4Color];
//    [self.view addSubview:office];
    selectOffice = [[UIButton alloc]initWithFrame:CGRectMake(37.5, 210, 300, 30)];
    [selectOffice setTitle:@"请选择" forState:(UIControlStateNormal)];
    [selectOffice setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    selectOffice.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    [selectOffice addTarget:self action:@selector(officeClick:) forControlEvents:UIControlEventTouchUpInside];
    selectOffice.layer.borderWidth = 1;
    selectOffice.layer.borderColor = [[UIColor blackColor] CGColor];
    selectOffice.layer.cornerRadius = 5;
    [self.view addSubview:selectOffice];
    _inputOffice = selectOffice.titleLabel.text;//保存想要查询的员工科室
    
    UILabel *Career = [[UILabel alloc]initWithFrame:CGRectMake(37.5, 250, 50, 30)];
    Career.text = @"职业";
    Career.textColor = [UIColor blackColor];
    [self.view addSubview:Career];
//    UITextField *career = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 285, 300, 30)];
//    career.backgroundColor = [UIColor systemGray4Color];
//    [self.view addSubview:career];
    selectCareer = [[UIButton alloc]initWithFrame:CGRectMake(37.5, 285, 300, 30)];
    [selectCareer setTitle:@"请选择" forState:(UIControlStateNormal)];
    [selectCareer setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    selectCareer.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    [selectCareer addTarget:self action:@selector(careerClick:) forControlEvents:UIControlEventTouchUpInside];
    selectCareer.layer.borderWidth = 1;
    selectCareer.layer.borderColor = [[UIColor blackColor] CGColor];
    selectCareer.layer.cornerRadius = 5;
    [self.view addSubview:selectCareer];
    _inputCareer = selectCareer.titleLabel.text;//保存想要查询的员工职业
    
    UILabel *Sex = [[UILabel alloc]initWithFrame:CGRectMake(37.5, 335, 50, 30)];
    Sex.text = @"性别";
    Sex.textColor = [UIColor blackColor];
    [self.view addSubview:Sex];
//    UITextField *sex = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 370, 120, 30)];
//    sex.backgroundColor = [UIColor systemGray4Color];
//    [self.view addSubview:sex];
    selectSex = [[UIButton alloc]initWithFrame:CGRectMake(37.5, 370, 120, 30)];
    [selectSex setTitle:@"请选择" forState:(UIControlStateNormal)];
    [selectSex setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    selectSex.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    [selectSex addTarget:self action:@selector(sexClick:) forControlEvents:UIControlEventTouchUpInside];
    selectSex.layer.borderWidth = 1;
    selectSex.layer.borderColor = [[UIColor blackColor] CGColor];
    selectSex.layer.cornerRadius = 5;
    [self.view addSubview:selectSex];
    _inputSex = selectSex.titleLabel.text;//保存想要查询的员工性别
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listChanged:) name:@"NOTI" object:nil];
    
    UILabel *Age = [[UILabel alloc]initWithFrame:CGRectMake(217.5, 335, 50, 30)];
    Age.text = @"年龄";
    Age.textColor = [UIColor blackColor];
    [self.view addSubview:Age];
    age = [[UITextField alloc]initWithFrame:CGRectMake(217.5, 370, 120, 30)];
    age.textColor = [UIColor blackColor];
    age.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    [age setDelegate:self];
    age.keyboardType = UIKeyboardTypeNumberPad;
    age.clearButtonMode = UITextFieldViewModeAlways;
    age.layer.borderWidth = 1;
    age.layer.borderColor = [[UIColor blackColor] CGColor];
    age.layer.cornerRadius = 5;
    [self.view addSubview:age];
    _inputAge = age.text;//保存想要查询的员工年龄
    
    UIButton *queryButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    queryButton.layer.cornerRadius = 8.0;
    queryButton.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-120)/2, 512, 120, 40);
    [queryButton setTitle:@"查询" forState:(UIControlStateNormal)];
    queryButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];//设置按钮的标题字体类型及大小
    [queryButton setBackgroundColor:[UIColor greenColor]];
    [queryButton setTintColor:[UIColor whiteColor]];
    [self.view addSubview:queryButton];
    [queryButton addTarget:self action:@selector(queryFuction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //[self selectDataArr_initalize];  //人员信息下拉框数组进行初始化
}

//薪资管理页面右上角的添加按钮的方法实现
- (void)add_clickFuction{
    PersonalInfoViewController *personalInfoView = [[PersonalInfoViewController alloc]init];
    //self.hidesBottomBarWhenPushed = YES;//下一个页面入栈后隐藏底部分栏器
    [self.navigationController pushViewController:personalInfoView animated:YES];
}

//薪资管理页面查询按钮的方法实现
- (void)queryFuction{
    YGViewController *queryView = [[YGViewController alloc]init];
    //self.hidesBottomBarWhenPushed = YES;//下一个页面入栈后隐藏底部分栏器
    [self.navigationController pushViewController:queryView animated:YES];
    //查询信息传值head
    queryView.queryName = name.text;
    queryView.queryOffice = selectOffice.titleLabel.text;
    queryView.queryCareer = selectCareer.titleLabel.text;
    queryView.querySex = selectSex.titleLabel.text;
    queryView.queryAge = age.text;
    //查询信息传值foot
    NSLog(@"输入的查询员工名:%@",name.text);
    NSLog(@"查询的员工名 传输值:%@",queryView.queryName);
    
    NSLog(@"输入的查询员工科室:%@",selectOffice.titleLabel.text);
    NSLog(@"查询的员工科室 传输值:%@",queryView.queryOffice);
    
    NSLog(@"输入的查询员工年龄:%@",age.text);
    NSLog(@"查询的员工年龄 传输值:%@",queryView.queryAge);
    
    NSLog(@"开始操作数据库");
}

//薪资管理页面，科室下拉框按钮的方法实现
- (void)officeClick:(UIButton *)btn{
    //科室查询信息count查询sql语句
//    self->selectSqlInfoCount = @"select count(distinct e_depart) from member;";
    //科室查询信息查询sql语句
    self->selectSqlInfo = @"select distinct e_depart from member;";
    //调用下拉框数据源初始化方法，标志位：office
    [self selectDataArr_initalize:office];
    
    CGFloat f;
    if(listView == nil) {
        if (_officeDataArr.count <= 5) {
            f = 40*_officeDataArr.count;
        }else{
            f = 120;
        }
        listView = [[ListView alloc]initWithShowDropDown:btn :f :_officeDataArr];
        listView.delegate = self;
    }
    else {
        [listView hideDropDown:btn];
        listView = nil;
    }
}
//薪资管理页面，职业下拉框按钮的方法实现
- (void)careerClick:(UIButton *)btn{
    //职业查询信息count查询sql语句
//    self->selectSqlInfoCount = @"select count(distinct e_prof) from member;";
    //职业查询信息查询sql语句
    self->selectSqlInfo = @"select distinct e_prof from member;";
    //调用下拉框数据源初始化方法，标志位：career
    [self selectDataArr_initalize:career];
    
    CGFloat f;
    if(listView == nil) {
        if (_careerDataArr.count <= 5) {
            f = 40*_careerDataArr.count;
        }else{
            f = 120;
        }
        listView = [[ListView alloc]initWithShowDropDown:btn :f :_careerDataArr];
        listView.delegate = self;
    }
    else {
        [listView hideDropDown:btn];
        listView = nil;
    }
}
//薪资管理页面，性别下拉框按钮的方法实现
- (void)sexClick:(UIButton *)btn{
    //性别查询信息count查询sql语句
//    self->selectSqlInfoCount = @"select count(distinct e_sex) from member;";
    //性别查询信息查询sql语句
    self->selectSqlInfo = @"select distinct e_sex from member;";
    //调用下拉框数据源初始化方法，标志位：sex
    [self selectDataArr_initalize:sex];
    
    CGFloat f;
    if(listView == nil) {
        if (_sexDataArr.count <= 5) {
            f = 40*_sexDataArr.count;
        }else{
            f = 120;
        }
        listView = [[ListView alloc]initWithShowDropDown:btn :f :_sexDataArr];
        listView.delegate = self;
    }
    else {
        [listView hideDropDown:btn];
        listView = nil;
    }
}

- (void)listChanged:(NSNotification *)noti{
    self.sexDataArr = noti.object;
}
- (void)dropDownDelegateMethod: (ListView *) sender {
    listView = nil;
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
    int movementDistance = -50; // tweak as needed
    float movementDuration = 0.3f; // tweak as needed
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];

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
    NSString*createSql=@"create table if not exists member(e_name text(20) primary key,e_sex text(1),e_age integer,e_prof text(10),e_place text(10),e_depart text(5));create table if not exists wages(e_name text(20) primary key,basepay real(10),welfare real(10),rewards real(10),claim real(10),hfound real(10),r_wages real(10));create view if not exists realwages as select e_name,r_wages from wages;";

    if (sqlite3_exec(db, [createSql UTF8String], NULL, NULL, &error)==SQLITE_OK) {
        NSLog(@"成功创建表");
    }else{
        NSLog(@"错误信息：%s",error);
        //每次使用完清空错误信息，提供给下次使用
        sqlite3_free(error);
    }

}

-(void)deleteSql:(NSString *)deletedEmployeeName
{

    //删除记录
    
    NSString *deleteSql=[NSString stringWithFormat:@"delete from member where e_name = '%@';delete from wages where e_name = '%@'",deletedEmployeeName,deletedEmployeeName];
    
    NSLog(@"删除名字：%@",deletedEmployeeName);

    if (sqlite3_exec(db, [deleteSql UTF8String], NULL, NULL, &error) == SQLITE_OK) {
        NSLog(@"delete operation is ok.");
    } else {
        NSLog(@"错误信息: %s", error);

        // 每次使用完毕清空 error 字符串，提供给下一次使用
        sqlite3_free(error);
    }

}
-(void)selectSql:(NSString *)sqlStatement
{
    // @"select * from myTable"  查询所有 key 值内容
    
    //查询记录
    //sqlite3_stmt *statement;
    sqlite3_stmt *statementInfo = NULL;//查询信息
//    sqlite3_stmt *statementInfoCount = NULL;//个人信息查询结果数目
    self->mutableArray = [[NSMutableArray alloc]init];
    
    NSLog(@"sql语句：%@",sqlStatement);
    
    if (sqlite3_prepare_v2(db, [sqlStatement UTF8String], -1, &statementInfo, nil) == SQLITE_OK)
    {
//        if (sqlite3_step(statementInfoCount) == SQLITE_ROW) {
//            //查询信息个数 的值
//            self->infoCount = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInfoCount, 0)] intValue];
//            NSLog(@"查询信息结果的个数：%d",self->infoCount);
//
//        }
        while(sqlite3_step(statementInfo) == SQLITE_ROW)
        {
            //查询信息 的值
//            self->info = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInfo, 0)];
            [self->mutableArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInfo, 0)]];
            NSLog(@"当前行返回结果：%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInfo, 0)]);
        }
    }else{
        NSLog(@"select operation is fail.");
        }
      sqlite3_finalize(statementInfo);
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
