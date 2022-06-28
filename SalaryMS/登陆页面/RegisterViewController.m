//
//  RegisterViewController.m
//  SalaryMS
//
//  Created by BayCi Gou on 2020/8/17.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import "RegisterViewController.h"
#import "TabBarViewController.h"
#import "sqlite3.h"
#import "AppDelegate.h"
@interface RegisterViewController ()
{
     char *error;
     sqlite3 * db;
}
@end

@implementation RegisterViewController

double currentMainScreenWidth = 0;//记录当前屏幕尺寸的宽度

- (void)viewDidLoad {
    [super viewDidLoad];
    //数据库初始化
    [self openSqlite];
    [self creatTable];
    [self initializeTable];
    [self closeSqlite];
//    UINavigationController *navigationControl = [[UINavigationController alloc]initWithRootViewController:self];
//    navigationControl.title = @"";
    //self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43, [[UIScreen mainScreen]bounds].size.width , [[UIScreen mainScreen]bounds].size.height)];//登陆背景图
    backgroundView.image = [UIImage imageNamed:@"background.png"];
    [self.view addSubview:backgroundView];
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 275, 30)];
    //
    title1.textColor = [UIColor blackColor];
    title1.text = @"新 型 有 限 公 司";
    [title1 setFont:[UIFont systemFontOfSize:35]];
    //title1.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(125, 180, 200, 30)];
    //
    title2.textColor = [UIColor blackColor];
    title2.text = @" 员 工 薪 资";
    [title2 setFont:[UIFont systemFontOfSize:35]];
    //title2.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(125, 260, 200, 30)];
    //
    title3.textColor = [UIColor blackColor];
    title3.text = @" 管 理 系 统";
    [title3 setFont:[UIFont systemFontOfSize:35]];
    //title3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:title1];
    [self.view addSubview:title2];
    [self.view addSubview:title3];
    
    UILabel *username = [[UILabel alloc]initWithFrame:CGRectMake(50, 380, 80, 30)];
    //
    username.textColor = [UIColor blackColor];
    username.text = @"用户名";
    [username setFont:[UIFont systemFontOfSize:20]];
    //username.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel *password = [[UILabel alloc]initWithFrame:CGRectMake(50, 450, 50, 30)];
    //
    password.textColor = [UIColor blackColor];
    password.text = @"密码";
    [password setFont:[UIFont systemFontOfSize:20]];
    //password.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:username];
    [self.view addSubview:password];
    
    inputName = [[UITextField alloc]initWithFrame:CGRectMake(140, 380, 185, 30)];
    //
    inputName.textColor = [UIColor blackColor];
    [inputName setDelegate:self];
    inputName.clearButtonMode = UITextFieldViewModeAlways;
    //inputName.placeholder = @"请输入用户名";
    NSAttributedString *attrNameString = [[NSAttributedString alloc] initWithString:@"请输入用户名" attributes:

        @{NSForegroundColorAttributeName:[UIColor grayColor],

                    NSFontAttributeName:inputName.font }];

    inputName.attributedPlaceholder = attrNameString;
    //inputName.translatesAutoresizingMaskIntoConstraints = NO;
    
    inputPassword = [[UITextField alloc]initWithFrame:CGRectMake(140, 450, 185, 30)];
    //
    [inputPassword setDelegate:self];
    inputPassword.clearButtonMode = UITextFieldViewModeAlways;
    //inputPassword.placeholder = @"请输入密码";
    NSAttributedString *attrPasswordString = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:
        @{NSForegroundColorAttributeName:[UIColor grayColor],
                    NSFontAttributeName:inputName.font }];
    inputPassword.attributedPlaceholder = attrPasswordString;
    inputPassword.textColor = [UIColor blackColor];
    inputPassword.secureTextEntry = YES;
    if (@available(iOS 11.0, *)) {
        inputPassword.textContentType = UITextContentTypePassword;
    }else{
        if (@available(iOS 12.0, *)) {
            inputPassword.textContentType = UITextContentTypeNewPassword;
        }else{
            //Fallback on earlier versions.
        }
    }
    
    //inputPassword.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:inputName];
    [self.view addSubview:inputPassword];
    
    self->RegisterButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    self->RegisterButton.layer.cornerRadius = 8.0;
    [self->RegisterButton.layer setBorderWidth:2.0];//设置按钮的边界宽度
    self->RegisterButton.frame = CGRectMake(127.5, 542, 120, 40);
    [self->RegisterButton setTitle:@"登陆" forState:(UIControlStateNormal)];
    [self->RegisterButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    //[self->Register setBackgroundColor:[UIColor yellowColor]];
    [self->RegisterButton setTintColor:[UIColor blackColor]];
    self->RegisterButton.layer.borderColor = [UIColor blackColor].CGColor;//设置按钮的边界颜色
    //Register.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self->RegisterButton];
    [self->RegisterButton addTarget:self action:@selector(register_click) forControlEvents:(UIControlEventTouchUpInside)];
    
    //添加自动布局约束
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=150)-[username]-10-[inputName]-(>=50)-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(username,inputName)]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=150)-[password]-30-[inputPassword]-(>=50)-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(password,inputPassword)]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(350)-[Register(120)]-(>=50)-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(Register)]];
//
//
//    NSString *vflStringV = @"V:|-(>=50,<=150)-[title1(>=30,<=40)]-50-[title2(>=30,<=40)]-50-[title3(>=30,<=40)]-(>=50,<=150)-[inputName(>=30,<=40)]-50-[inputPassword(>=30,<=40)]-60-[Register(40)]-(>=50)-|";
//    //NSString *vflStringH = @"|-(>=50)-[username]-10-[inputName(>=30,<=40)]-(>=50)-|";
//
//    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflStringV options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(title1,title2,title3,username,password,inputName,inputPassword,Register)]];
    
    //@"H:[Register(120)]"
}
//登陆方法实现
- (void)register_click{
    [self openSqlite];
    [self creatTable];
    //登陆功能，数据库查询操作，判断用户名和密码是否匹配
    if ([self selectSql] == YES) {
        NSLog(@"登陆成功！");
        //登陆成功后清除密码框内容，防止异常登陆
        self->inputPassword.text = @"";
        
        TabBarViewController *TabView = [[TabBarViewController alloc]init];
        //登陆用户info值传递head
        TabView.view2.username = _queryUsername;
        TabView.view2.profession = _queryUsProfession;
        TabView.view2.office = _queryOffice;
        TabView.view2.company = _queryCompany;
        //登陆用户info值传递tail
        [self presentViewController:TabView animated:YES completion:nil];//模态弹出进入下一视图（薪资管理界面）
    }else{
        //登陆失败后清除密码框内容，防止异常登陆
        self->inputPassword.text = @"";
        
        UIAlertController *tipsAlertView = [UIAlertController alertControllerWithTitle:@"登陆提示" message:@"用户名或密码不正确，登陆失败，请重试！" preferredStyle:(UIAlertControllerStyleActionSheet)];
        
        UIView *subView = tipsAlertView.view.subviews.firstObject;//firstObject
        UIView *backgroundContentView = subView.subviews.firstObject;
        UIView *alertContentView = backgroundContentView.subviews.firstObject;
        [subView setBackgroundColor:[UIColor clearColor]];//设置最底层视图的颜色为透明色
        [backgroundContentView setBackgroundColor:[UIColor clearColor]];//设置背景视图的颜色为透明色
        //[alertContentView setBackgroundColor:[self colorWithHexString:@"F2C200" alpha:1.0f]];//设置alert整体视图的颜色为白色
        
        //title
        NSMutableAttributedString *alertControllerTitleStr = [[NSMutableAttributedString alloc]initWithString:@"登陆提示"];
        [alertControllerTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, [[alertControllerTitleStr string] length])];
        [alertControllerTitleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [[alertControllerTitleStr string] length])];
        [tipsAlertView setValue:alertControllerTitleStr forKey:@"attributedTitle"];
        //message
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc]initWithString:@"用户名或密码不正确，登陆失败，请重试！"];
        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0, [[alertControllerMessageStr string] length])];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, [[alertControllerMessageStr string] length])];
        [tipsAlertView setValue:alertControllerMessageStr forKey:@"attributedMessage"];
        
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定返回！");
        }];
        [sure setValue:[UIColor systemBlueColor] forKey:@"titleTextColor"];//设置按钮的title颜色为系统默认蓝色
        [tipsAlertView addAction:sure];
        //适配ipad
        UIPopoverPresentationController *popover = tipsAlertView.popoverPresentationController;
        if (popover) {
            popover.sourceView = self->RegisterButton;
            popover.sourceRect = self->RegisterButton.bounds;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
        
        [self presentViewController:tipsAlertView animated:YES completion:nil];
    }
    [self closeSqlite];
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

-(void)initializeTable
{
     /*
     sql 语句，专门用来操作数据库的语句。
     */
    
    NSString *initializeSql=@"insert or ignore into user(username, password,e_prof,e_depart,e_place) values ('Root','123456789','管理员','管理层','新型有限公司'),('Administrator','123456789','管理员','管理层','新型有限公司'),('Manager','784951623','经理','高级管理层','新型有限公司'),('GMD','784951623','总经理','高级管理层','新型有限公司')";
    

    if (sqlite3_exec(db, [initializeSql UTF8String], NULL, NULL, &error)==SQLITE_OK){
        
            NSLog(@"成功初始化user表");
    }else{
        NSLog(@"初始化错误信息：%s",error);
        //每次使用完清空错误信息，提供给下次使用
        sqlite3_free(error);
    }
}

-(BOOL)selectSql
{
    // @"select * from myTable"  查询所有 key 值内容
    
    //查询记录
    sqlite3_stmt *statementUserPsw = NULL;//登陆用户的密码查询
    
    //登陆用户的密码查询sql语句
    NSString *selectSqlUserPsw=[NSString stringWithFormat:@"select * from user where username = '%@' ",self->inputName.text];
    
    if ( sqlite3_prepare_v2(db, [selectSqlUserPsw UTF8String], -1, &statementUserPsw, nil) == SQLITE_OK ) {
        
        while( sqlite3_step(statementUserPsw) == SQLITE_ROW ) {
            // 查询 用户名 的值
            _queryUsername = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementUserPsw, 0)];
            
            // 查询 密码 的值
            NSString * queryPassword = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementUserPsw, 1)];
                    
//            NSLog(@"密码：%@", queryPassword);
//            NSLog(@"inputPassword:%@",self->inputPassword.text);
            
            // 查询 职业 的值
            _queryUsProfession = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementUserPsw, 2)];
            
            // 查询 科室 的值
            _queryOffice= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementUserPsw, 3)];
            
            // 查询 公司 的值
            _queryCompany = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementUserPsw, 4)];
            
            if ( [self->inputPassword.text  isEqual: queryPassword] ) {
                return YES;
            }
        }
    }else {
        NSLog(@"select operation is fail.");
    }
    
    sqlite3_finalize(statementUserPsw);
    
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

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    [self animateTextField:textField up:YES];
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    [self animateTextField:textField up:NO];
//}

//-(void)animateTextField:(UITextField*)textField up:(BOOL)up
//{
//    int movementDistance = -90; // tweak as needed
//    float movementDuration = 0.3f; // tweak as needed
//    int movement = (up ? movementDistance : -movementDistance);
//    [UIView beginAnimations: @"animateTextField" context: nil];
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    [UIView setAnimationDuration: movementDuration];
//    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
//    [UIView commitAnimations];
//
//}

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
