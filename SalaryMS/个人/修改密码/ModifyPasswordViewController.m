//
//  ModifyPasswordViewController.m
//  SalaryMS
//
//  Created by BayCi Gou on 2020/9/3.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "sqlite3.h"
@interface ModifyPasswordViewController ()
{
     char *error;
     sqlite3 * db;
}
@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [self colorWithHexString:@"EEEEEE" alpha:1.0f];
    //self.view.backgroundColor = [self colorWithHexString:@"FFC0CB" alpha:1.0f];
    
    self.navigationItem.title = @"";
    UILabel *PageTitle = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 175, 50)];
    PageTitle.textColor = [UIColor blackColor];
    PageTitle.text = @"密码修改";
    PageTitle.textAlignment = NSTextAlignmentCenter;
    [PageTitle setFont:[UIFont systemFontOfSize:25]];
    [self.view addSubview:PageTitle];
    
    //原始密码
    originalPassword = [[UITextField alloc]initWithFrame:CGRectMake(130, 200, 185, 30)];
    originalPassword.textColor = [UIColor blackColor];
    [originalPassword setDelegate:self];
    originalPassword.clearButtonMode = UITextFieldViewModeAlways;
    //originalPassword.placeholder = @"请输入用户名";
    NSAttributedString *attrPsdString = [[NSAttributedString alloc] initWithString:@"请输入原密码" attributes:

        @{NSForegroundColorAttributeName:[UIColor grayColor],

                    NSFontAttributeName:originalPassword.font }];

    originalPassword.attributedPlaceholder = attrPsdString;
    if (@available(iOS 11.0, *)) {
        originalPassword.textContentType = UITextContentTypePassword;
    }else{
        if (@available(iOS 12.0, *)) {
            originalPassword.textContentType = UITextContentTypeNewPassword;
        }else{
            //Fallback on earlier versions.
        }
    }
    
    //新密码
    newPassword = [[UITextField alloc]initWithFrame:CGRectMake(originalPassword.frame.origin.x, originalPassword.frame.origin.y+originalPassword.frame.size.height+40, 185, 30)];
    newPassword.textColor = [UIColor blackColor];
    [newPassword setDelegate:self];
    newPassword.clearButtonMode = UITextFieldViewModeAlways;
    //newPassword.placeholder = @"请输入密码";
    NSAttributedString *attrNewPsdString = [[NSAttributedString alloc] initWithString:@"请输入新密码" attributes:

        @{NSForegroundColorAttributeName:[UIColor grayColor],

                    NSFontAttributeName:newPassword.font }];
    newPassword.attributedPlaceholder = attrNewPsdString;
    if (@available(iOS 11.0, *)) {
        newPassword.textContentType = UITextContentTypePassword;
    }else{
        if (@available(iOS 12.0, *)) {
            newPassword.textContentType = UITextContentTypeNewPassword;
        }else{
            //Fallback on earlier versions.
        }
    }
    //newPassword.secureTextEntry = YES;
    
    //再次输入密码
    againPassword = [[UITextField alloc]initWithFrame:CGRectMake(newPassword.frame.origin.x, newPassword.frame.origin.y+newPassword.frame.size.height+40, 185, 30)];
    againPassword.textColor = [UIColor blackColor];
    [againPassword setDelegate:self];
    againPassword.clearButtonMode = UITextFieldViewModeAlways;
    //againPassword.placeholder = @"请输入密码";
    NSAttributedString *attrAgainPsdString = [[NSAttributedString alloc] initWithString:@"请再次输入密码" attributes:

        @{NSForegroundColorAttributeName:[UIColor grayColor],

                    NSFontAttributeName:againPassword.font }];
    againPassword.attributedPlaceholder = attrAgainPsdString;
    if (@available(iOS 11.0, *)) {
        againPassword.textContentType = UITextContentTypePassword;
    }else{
        if (@available(iOS 12.0, *)) {
            againPassword.textContentType = UITextContentTypeNewPassword;
        }else{
            //Fallback on earlier versions.
        }
    }
    //againPassword.secureTextEntry = YES;
    
    [self.view addSubview:originalPassword];
    [self.view addSubview:newPassword];
    [self.view addSubview:againPassword];
    
    self->updateButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    self->updateButton.layer.cornerRadius = 8.0;
    self->updateButton.frame = CGRectMake(127.5, 512, 120, 40);
    [self->updateButton setTitle:@"更改" forState:(UIControlStateNormal)];
    self->updateButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];//设置按钮的标题字体类型及大小
    [self->updateButton setBackgroundColor:[UIColor greenColor]];
    [self->updateButton setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self->updateButton];
    [self->updateButton addTarget:self action:@selector(commit) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)commit{
    if ([newPassword.text isEqual:againPassword.text]) {
        [self openSqlite];
        [self creatTable];
        if ([self selectSql] == YES) {
            [self updateSql];
            NSLog(@"密码修改成功！");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"原始密码错误，请重试！");
            UIAlertController *tipsAlertView = [UIAlertController alertControllerWithTitle:@"更改密码提示" message:@"原始密码错误，请重试！！" preferredStyle:(UIAlertControllerStyleActionSheet)];
            
            UIView *subView = tipsAlertView.view.subviews.firstObject;//firstObject
            UIView *backgroundContentView = subView.subviews.firstObject;
            UIView *alertContentView = backgroundContentView.subviews.firstObject;
            [subView setBackgroundColor:[UIColor clearColor]];//设置最底层视图的颜色为透明色
            [backgroundContentView setBackgroundColor:[UIColor clearColor]];//设置背景视图的颜色为透明色
            //[alertContentView setBackgroundColor:[self colorWithHexString:@"F2C200" alpha:1.0f]];//设置alert整体视图的颜色为白色
            
            //title
            NSMutableAttributedString *alertControllerTitleStr = [[NSMutableAttributedString alloc]initWithString:@"更改密码提示"];
            [alertControllerTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, [[alertControllerTitleStr string] length])];
            [alertControllerTitleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [[alertControllerTitleStr string] length])];
            [tipsAlertView setValue:alertControllerTitleStr forKey:@"attributedTitle"];
            //message
            NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc]initWithString:@"原始密码错误，请重试！"];
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
                popover.sourceView = self->updateButton;
                popover.sourceRect = self->updateButton.bounds;
                popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
            }
            [self presentViewController:tipsAlertView animated:YES completion:nil];
        }
        [self closeSqlite];
    }else{
        NSLog(@"两次输入密码不一致，请重试！");
        UIAlertController *tipsAlertView = [UIAlertController alertControllerWithTitle:@"更改密码提示" message:@"两次输入密码不一致，请重试！" preferredStyle:(UIAlertControllerStyleActionSheet)];
        
        UIView *subView = tipsAlertView.view.subviews.firstObject;//firstObject
        UIView *backgroundContentView = subView.subviews.firstObject;
        UIView *alertContentView = backgroundContentView.subviews.firstObject;
        [subView setBackgroundColor:[UIColor clearColor]];//设置最底层视图的颜色为透明色
        [backgroundContentView setBackgroundColor:[UIColor clearColor]];//设置背景视图的颜色为透明色
        //[alertContentView setBackgroundColor:[self colorWithHexString:@"F2C200" alpha:1.0f]];//设置alert整体视图的颜色为白色
        
        //title
        NSMutableAttributedString *alertControllerTitleStr = [[NSMutableAttributedString alloc]initWithString:@"更改密码提示"];
        [alertControllerTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, [[alertControllerTitleStr string] length])];
        [alertControllerTitleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [[alertControllerTitleStr string] length])];
        [tipsAlertView setValue:alertControllerTitleStr forKey:@"attributedTitle"];
        //message
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc]initWithString:@"两次输入密码不一致，请重试！"];
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
            popover.sourceView = self->updateButton;
            popover.sourceRect = self->updateButton.bounds;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
        [self presentViewController:tipsAlertView animated:YES completion:nil];
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
    int movementDistance = -100; // tweak as needed
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
    NSString *createSql=@"create table if not exists member(e_name text(20) primary key,e_sex text(1),e_age integer,e_prof text(10),e_place text(10),e_depart text(5));create table if not exists wages(e_name text(20) primary key,basepay real(10),welfare real(10),rewards real(10),claim real(10),hfound real(10),r_wages real(10));create view if not exists realwages as select e_name,r_wages from wages;create table if not exists user(username text(10) primary key not null unique,password text not null,e_prof text(10),e_depart text(10),e_place text(5));";
    
    if (sqlite3_exec(db, [createSql UTF8String], NULL, NULL, &error)==SQLITE_OK){
        
        NSLog(@"成功创建表");
    }else{
            NSLog(@"创建错误信息：%s",error);
            //每次使用完清空错误信息，提供给下次使用
            sqlite3_free(error);
     }
}

-(void)updateSql
{
    //修改记录

    NSString*updateSql=[NSString stringWithFormat:@"update user set password = '%@' where username = '%@';",newPassword.text,_username];

    if (sqlite3_exec(db, [updateSql UTF8String], NULL, NULL, &error) == SQLITE_OK) {
        NSLog(@"update operation is ok.");
    } else {
        NSLog(@"错误信息: %s", error);

        // 每次使用完毕清空 error 字符串，提供给下一次使用
        sqlite3_free(error);
    }

}

-(BOOL)selectSql
{
    // @"select * from myTable"  查询所有 key 值内容
    
    //查询记录
    sqlite3_stmt *statementUserPsw = NULL;//登陆用户的密码查询
    
    //登陆用户的密码查询sql语句
    NSString *selectSqlUserPsw=[NSString stringWithFormat:@"select password from user where username = '%@' ",_username];
    
    if ( sqlite3_prepare_v2(db, [selectSqlUserPsw UTF8String], -1, &statementUserPsw, nil) == SQLITE_OK ) {
        
        while( sqlite3_step(statementUserPsw) == SQLITE_ROW ) {
            
            // 查询 密码 的值
            NSString * queryPassword = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementUserPsw, 0)];
                    
//            NSLog(@"密码：%@", queryPassword);
//            NSLog(@"inputPassword:%@",self->inputPassword.text);
            
            if ( [self->originalPassword.text  isEqual: queryPassword] ) {
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
