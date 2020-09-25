//
//  ModificationInfoViewController.m
//  SalaryMS
//
//  Created by BayCi Gou on 2020/9/1.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import "ModificationInfoViewController.h"
#import "sqlite3.h"
@interface ModificationInfoViewController ()
{
     char *error;
     sqlite3 * db;
}
@end

@implementation ModificationInfoViewController

- (void)selectDataArr_initalize{
    self.officeDataArr = [NSMutableArray array];
    [_officeDataArr addObject:@"经理室"];
    [_officeDataArr addObject:@"财务科"];
    [_officeDataArr addObject:@"技术科"];
    [_officeDataArr addObject:@"销售科"];
    [_officeDataArr addObject:@"请选择"];
    
    
    self.careerDataArr = [NSMutableArray array];
    [_careerDataArr addObject:@"经理"];
    [_careerDataArr addObject:@"财务"];
    [_careerDataArr addObject:@"工程师"];
    [_careerDataArr addObject:@"销售员"];
    [_careerDataArr addObject:@"请选择"];
    
    self.sexDataArr = [NSMutableArray array];
    [_sexDataArr addObject:@"男"];
    [_sexDataArr addObject:@"女"];
    [_sexDataArr addObject:@"请选择"];
}

- (void)viewDidLoad {
        [super viewDidLoad];
        self.view.backgroundColor = [self colorWithHexString:@"EEEEEE" alpha:1.0f];
        //self.view.backgroundColor = [self colorWithHexString:@"FFC0CB" alpha:1.0f];
        
        self.navigationItem.title = @"";
        UILabel *PageTitle = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 175, 50)];
        PageTitle.textColor = [UIColor blackColor];
        PageTitle.text = @"信息修改";
        PageTitle.textAlignment = NSTextAlignmentCenter;
        [PageTitle setFont:[UIFont systemFontOfSize:25]];
        [self.view addSubview:PageTitle];
        
        UILabel *Name = [[UILabel alloc]initWithFrame:CGRectMake(24.5, 140, 50, 30)];
        Name.textColor = [UIColor blackColor];
        Name.text = @"姓名";
        [self.view addSubview:Name];
        name = [[UITextField alloc]initWithFrame:CGRectMake(Name.frame.origin.x+Name.frame.size.width, Name.frame.origin.y, 80, 30)];
        name.text = _beModifiedEmployeeName;
        name.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
        [name setDelegate:self];
        name.textColor = [UIColor blackColor];
        name.clearButtonMode = UITextFieldViewModeAlways;
        name.layer.borderWidth = 1;
        name.layer.borderColor = [[UIColor blackColor] CGColor];
        name.layer.cornerRadius = 5;
        [self.view addSubview:name];
        
        UILabel *Office = [[UILabel alloc]initWithFrame:CGRectMake(Name.frame.origin.x, Name.frame.origin.y+Name.frame.size.height+45, 50, 30)];
        Office.textColor = [UIColor blackColor];
        Office.text = @"科室";
        [self.view addSubview:Office];
    //    UITextField *office = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 260, 300, 30)];
    //    office.backgroundColor = [UIColor systemGray4Color];
    //    [self.view addSubview:office];
        selectOffice = [[UIButton alloc]initWithFrame:CGRectMake(Office.frame.origin.x+Office.frame.size.width, Office.frame.origin.y, 80, 30)];
        [selectOffice setTitle:_beModifiedEmployeeOffice forState:(UIControlStateNormal)];
        [selectOffice setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        selectOffice.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
        [selectOffice addTarget:self action:@selector(officeClick:) forControlEvents:UIControlEventTouchUpInside];
        selectOffice.layer.borderWidth = 1;
        selectOffice.layer.borderColor = [[UIColor blackColor] CGColor];
        selectOffice.layer.cornerRadius = 5;
        [self.view addSubview:selectOffice];
        
        UILabel *Career = [[UILabel alloc]initWithFrame:CGRectMake(Name.frame.origin.x, Office.frame.origin.y+Office.frame.size.height+45, 50, 30)];
        Career.textColor = [UIColor blackColor];
        Career.text = @"职业";
        [self.view addSubview:Career];
    //    UITextField *career = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 335, 300, 30)];
    //    career.backgroundColor = [UIColor systemGray4Color];
    //    [self.view addSubview:career];
        selectCareer = [[UIButton alloc]initWithFrame:CGRectMake(Career.frame.origin.x+Career.frame.size.width, Career.frame.origin.y, 80, 30)];
        [selectCareer setTitle:_beModifiedEmployeeCareer forState:(UIControlStateNormal)];
        [selectCareer setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        selectCareer.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
        [selectCareer addTarget:self action:@selector(careerClick:) forControlEvents:UIControlEventTouchUpInside];
        selectCareer.layer.borderWidth = 1;
        selectCareer.layer.borderColor = [[UIColor blackColor] CGColor];
        selectCareer.layer.cornerRadius = 5;
        [self.view addSubview:selectCareer];
        
        UILabel *Sex = [[UILabel alloc]initWithFrame:CGRectMake(Name.frame.origin.x, Career.frame.origin.y+Career.frame.size.height+45, 50, 30)];
        Sex.textColor = [UIColor blackColor];
        Sex.text = @"性别";
        [self.view addSubview:Sex];
    //    UITextField *sex = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 420, 120, 30)];
    //    sex.backgroundColor = [UIColor systemGray4Color];
    //    [self.view addSubview:sex];
        selectSex = [[UIButton alloc]initWithFrame:CGRectMake(Sex.frame.origin.x+Sex.frame.size.width, Sex.frame.origin.y, 80, 30)];
        [selectSex setTitle:_beModifiedEmployeeSex forState:(UIControlStateNormal)];
        [selectSex setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        selectSex.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
        [selectSex addTarget:self action:@selector(sexClick:) forControlEvents:UIControlEventTouchUpInside];
        selectSex.layer.borderWidth = 1;
        selectSex.layer.borderColor = [[UIColor blackColor] CGColor];
        selectSex.layer.cornerRadius = 5;
        [self.view addSubview:selectSex];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listChanged:) name:@"NOTI" object:nil];
        
        UILabel *Age = [[UILabel alloc]initWithFrame:CGRectMake(Name.frame.origin.x, Sex.frame.origin.y+Sex.frame.size.height+45, 50, 30)];
        Age.textColor = [UIColor blackColor];
        Age.text = @"年龄";
        [self.view addSubview:Age];
        age = [[UITextField alloc]initWithFrame:CGRectMake(Age.frame.origin.x+Age.frame.size.width, Age.frame.origin.y, 80, 30)];
        age.text = _beModifiedEmployeeAge;
        age.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
        age.textColor = [ UIColor blackColor];
        age.keyboardType = UIKeyboardTypeNumberPad;
        [age setDelegate:self];
        age.clearButtonMode = UITextFieldViewModeAlways;
        age.layer.borderWidth = 1;
        age.layer.borderColor = [[UIColor blackColor] CGColor];
        age.layer.cornerRadius = 5;
        [self.view addSubview:age];
    
    
    UILabel *baseSalary = [[UILabel alloc]initWithFrame:CGRectMake(name.frame.origin.x+name.frame.size.width+15, name.frame.origin.y, 70, 30)];
    baseSalary.textColor = [UIColor blackColor];
    baseSalary.text = @"基本工资";
    [self.view addSubview:baseSalary];
    inputBaseSalary = [[UITextField alloc]initWithFrame:CGRectMake(baseSalary.frame.origin.x+baseSalary.frame.size.width+30, baseSalary.frame.origin.y, 80, 30)];
    inputBaseSalary.text = _beModifiedEmployeeBaseSalary;
    inputBaseSalary.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    inputBaseSalary.textColor = [UIColor blackColor];
    [inputBaseSalary setDelegate:self];
    inputBaseSalary.keyboardType = UIKeyboardTypeNumberPad;
    inputBaseSalary.clearButtonMode = UITextFieldViewModeAlways;
    inputBaseSalary.layer.borderWidth = 1;
    inputBaseSalary.layer.borderColor = [[UIColor blackColor] CGColor];
    inputBaseSalary.layer.cornerRadius = 5;
    [self.view addSubview:inputBaseSalary];
    
    UILabel *welfare = [[UILabel alloc]initWithFrame:CGRectMake(selectOffice.frame.origin.x+selectOffice.frame.size.width+15, selectOffice.frame.origin.y, 70, 30)];
    welfare.textColor = [UIColor blackColor];
    welfare.text = @"福利补贴";
    [self.view addSubview:welfare];
    inputWelfare = [[UITextField alloc]initWithFrame:CGRectMake(welfare.frame.origin.x+welfare.frame.size.width+30, welfare.frame.origin.y, 80, 30)];
    inputWelfare.text = _beModifiedEmployeeWefare;
    inputWelfare.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    inputWelfare.textColor = [UIColor blackColor];
    [inputWelfare setDelegate:self];
    inputWelfare.keyboardType = UIKeyboardTypeNumberPad;
    inputWelfare.clearButtonMode = UITextFieldViewModeAlways;
    inputWelfare.layer.borderWidth = 1;
    inputWelfare.layer.borderColor = [[UIColor blackColor] CGColor];
    inputWelfare.layer.cornerRadius = 5;
    [self.view addSubview:inputWelfare];
    
    UILabel *bonusWage = [[UILabel alloc]initWithFrame:CGRectMake(selectCareer.frame.origin.x+selectCareer.frame.size.width+15, selectCareer.frame.origin.y, 70, 30)];
    bonusWage.textColor = [UIColor blackColor];
    bonusWage.text = @"奖励工资";
    [self.view addSubview:bonusWage];
    inputBonusWage = [[UITextField alloc]initWithFrame:CGRectMake(bonusWage.frame.origin.x+bonusWage.frame.size.width+30, bonusWage.frame.origin.y, 80, 30)];
    inputBonusWage.text = _beModifiedEmployeeBonusWage;
    inputBonusWage.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    inputBonusWage.textColor = [UIColor blackColor];
    [inputBonusWage setDelegate:self];
    inputBonusWage.keyboardType = UIKeyboardTypeNumberPad;
    inputBonusWage.clearButtonMode = UITextFieldViewModeAlways;
    inputBonusWage.layer.borderWidth = 1;
    inputBonusWage.layer.borderColor = [[UIColor blackColor] CGColor];
    inputBonusWage.layer.cornerRadius = 5;
    [self.view addSubview:inputBonusWage];
    
    UILabel *housingFund = [[UILabel alloc]initWithFrame:CGRectMake(selectSex.frame.origin.x+selectSex.frame.size.width+15, selectSex.frame.origin.y, 90, 30)];
    housingFund.textColor = [UIColor blackColor];
    housingFund.text = @"住房公积金";
    [self.view addSubview:housingFund];
    inputHousingFund = [[UITextField alloc]initWithFrame:CGRectMake(housingFund.frame.origin.x+housingFund.frame.size.width+10, housingFund.frame.origin.y, 80, 30)];
    inputHousingFund.text = _beModifiedEmployeeHousingFund;
    inputHousingFund.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    inputHousingFund.textColor = [UIColor blackColor];
    [inputHousingFund setDelegate:self];
    inputHousingFund.keyboardType = UIKeyboardTypeNumberPad;
    inputHousingFund.clearButtonMode = UITextFieldViewModeAlways;
    inputHousingFund.layer.borderWidth = 1;
    inputHousingFund.layer.borderColor = [[UIColor blackColor] CGColor];
    inputHousingFund.layer.cornerRadius = 5;
    [self.view addSubview:inputHousingFund];
    
    UILabel *unemployInsurance = [[UILabel alloc]initWithFrame:CGRectMake(age.frame.origin.x+age.frame.size.width+15, age.frame.origin.y, 70, 30)];
    unemployInsurance.textColor = [UIColor blackColor];
    unemployInsurance.text = @"失业保险";
    [self.view addSubview:unemployInsurance];
    inputUnemployInsurance = [[UITextField alloc]initWithFrame:CGRectMake(unemployInsurance.frame.origin.x+unemployInsurance.frame.size.width+30, unemployInsurance.frame.origin.y, 80, 30)];
    inputUnemployInsurance.text = _beModifiedEmployeeUnemployInsurance;
    inputUnemployInsurance.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    inputUnemployInsurance.textColor = [UIColor blackColor];
    [inputUnemployInsurance setDelegate:self];
    inputUnemployInsurance.keyboardType = UIKeyboardTypeNumberPad;
    inputUnemployInsurance.clearButtonMode = UITextFieldViewModeAlways;
    inputUnemployInsurance.layer.borderWidth = 1;
    inputUnemployInsurance.layer.borderColor = [[UIColor blackColor] CGColor];
    inputUnemployInsurance.layer.cornerRadius = 5;
    [self.view addSubview:inputUnemployInsurance];
    
    UIButton *Sure = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    Sure.layer.cornerRadius = 8.0;
    Sure.frame = CGRectMake(127.5, 512, 120, 40);
    [Sure setTitle:@"确定" forState:(UIControlStateNormal)];
    Sure.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];//设置按钮的标题字体类型及大小
    [Sure setBackgroundColor:[UIColor greenColor]];
    [Sure setTintColor:[UIColor whiteColor]];
    [self.view addSubview:Sure];
    [Sure addTarget:self action:@selector(submit) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self selectDataArr_initalize];
}

- (void)submit{
    NSLog(@"提交成功！");
    if ( (![name  isEqual: @""] && (![selectOffice  isEqual: @"请选择"] && ![selectCareer  isEqual: @"请选择"] && ![selectSex  isEqual: @"请选择"]) && ![age  isEqual: @""])
     &&
    (![inputBaseSalary.text  isEqual: @""] && ![inputWelfare.text  isEqual: @""] && ![inputBonusWage.text  isEqual: @""] && ![inputHousingFund.text  isEqual: @""] && ![inputUnemployInsurance.text  isEqual: @""] ) ) {
            [self openSqlite];
            [self creatTable];
        if ([self updateSql] == YES) {
            NSLog(@"更新成功！");
        }
            [self closeSqlite];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)officeClick:(UIButton *)btn{
    CGFloat f;
    if(listView == nil) {
        if (_officeDataArr.count <= 4) {
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

- (void)careerClick:(UIButton *)btn{
    CGFloat f;
    if(listView == nil) {
        if (_careerDataArr.count <= 4) {
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

- (void)sexClick:(UIButton *)btn{
    CGFloat f;
    if(listView == nil) {
        if (_sexDataArr.count <= 4) {
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
-(BOOL)updateSql
{
    //修改记录
    
    NSString*updateSql=[NSString stringWithFormat:@"update member set e_name = '%@', e_sex = '%@', e_age = '%@', e_prof = '%@',e_depart = '%@' where e_name = '%@';update wages set basepay = '%@', welfare = '%@', rewards = '%@', claim = '%@', hfound = '%@' where e_name = '%@';",self->name.text,self->selectSex.titleLabel.text,self->age.text,self->selectCareer.titleLabel.text,self->selectOffice.titleLabel.text,_beModifiedEmployeeName,inputBaseSalary.text,inputWelfare.text,inputBonusWage.text,inputUnemployInsurance.text,inputHousingFund.text,_beModifiedEmployeeName];
    
    if (sqlite3_exec(db, [updateSql UTF8String], NULL, NULL, &error) == SQLITE_OK) {
        NSLog(@"update operation is ok.");
        return YES;
    } else {
        NSLog(@"错误信息: %s", error);

        // 每次使用完毕清空 error 字符串，提供给下一次使用
        sqlite3_free(error);
    }
    return NO;
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
    int movementDistance = -80; // tweak as needed
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
