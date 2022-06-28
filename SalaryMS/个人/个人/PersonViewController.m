//
//  PersonViewController.m
//  SalaryMS
//
//  Created by BayCi Gou on 2020/8/17.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import "PersonViewController.h"
#import "RegisterViewController.h"
#import "ModifyPasswordViewController.h"
@interface PersonViewController ()

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"个人主页";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};//导航栏title颜色
    
//    self->TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 63, 375, 567) style:(UITableViewStyleGrouped)];
    self->TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 63, [[UIScreen mainScreen]bounds].size.width , [[UIScreen mainScreen]bounds].size.height) style:(UITableViewStyleGrouped)];
    TableView.backgroundColor = [self colorWithHexString:@"EEEEEE" alpha:1.0f];
    TableView.sectionHeaderHeight = 10.0f;//设置每个cell的上间距
    TableView.sectionFooterHeight = 10.0f;//设置每个cell的下间距
    TableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);//设置第一组cell的导航栏的距离
    TableView.separatorStyle = UITableViewCellSeparatorStyleNone;//设置cell之间的分割线为无
    [TableView setDataSource:self];
    [TableView setDelegate:self];
    [self.view addSubview:TableView];
    
    UIButton *ifRegister = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    ifRegister.layer.cornerRadius = 8.0;
    ifRegister.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-120)/2, 475, 120, 40);
    //(127.5, 475, 120, 40)
    [ifRegister setTitle:@"退出登录" forState:(UIControlStateNormal)];
    ifRegister.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];//设置按钮的标题字体类型及大小
    [ifRegister setBackgroundColor:[UIColor redColor]];
    [ifRegister setTintColor:[UIColor whiteColor]];
    [TableView addSubview:ifRegister];
    [ifRegister addTarget:self action:@selector(exit) forControlEvents:(UIControlEventTouchUpInside)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 4;
    }else
        return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    int section = (int)indexPath.section;
    int row = (int)indexPath.row;
    static NSString *CellIdentifier = @"???";
    Cell = (UITableViewCell*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:CellIdentifier];
    if (Cell == nil){
        Cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:CellIdentifier];
        Cell.layer.cornerRadius = 9.0f;
        Cell.textColor = [UIColor blackColor];
        Cell.backgroundColor = [UIColor whiteColor];
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //Cell.selectedTextColor = [self colorWithHexString:@"BFE5FA" alpha:0.5];
        
        switch (section) {
            case 0:
                switch (row) {
                    case 0:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"姓名";
                        Cell.detailTextLabel.textColor = [UIColor blackColor];
                        Cell.detailTextLabel.text = _username;
                        NSLog(@"姓名：%@",Cell.detailTextLabel.text);
                        Cell.accessoryType = UITableViewCellAccessoryNone;
                        break;
                        
                     case 1:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"职业";
                        Cell.detailTextLabel.textColor = [UIColor blackColor];
                        Cell.detailTextLabel.text = _profession;
                        NSLog(@"职业：%@",Cell.detailTextLabel.text);
                        Cell.accessoryType = UITableViewCellAccessoryNone;
                        break;
                     case 2:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"科室";
                        Cell.detailTextLabel.textColor = [UIColor blackColor];
                        Cell.detailTextLabel.text = _office;
                        NSLog(@"科室：%@",Cell.detailTextLabel.text);
                        Cell.accessoryType = UITableViewCellAccessoryNone;
                        break;
                      case 3:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"公司";
                        Cell.detailTextLabel.textColor = [UIColor blackColor];
                        Cell.detailTextLabel.text = _company;
                        NSLog(@"公司：%@",Cell.detailTextLabel.text);
                        Cell.accessoryType = UITableViewCellAccessoryNone;
                        break;

                    default:
                        break;
                }
                break;
            case 1:
                switch (row) {
                        case 0:
                            Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                            Cell.textLabel.text = @"修改密码";
                            Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                            break;

                        default:
                            break;
                }
                break;
                default:
                break;
        }
    }
    return Cell;
}

//设置某一个row对应的cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{    //cell的点击响应事件
    
    UIAlertController *change_password = [UIAlertController alertControllerWithTitle:@"请输入新的密码：" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
    //change_tel.view.backgroundColor = [UIColor whiteColor];
    change_password.view.tintColor = [UIColor systemBlueColor];
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:

                    break;

                case 1:

                    break;

                case 2:

                    break;

                case 3:

                    break;

                default:
                    break;
            }
            break;

        case 1:
            if (indexPath.row == 0) {
                NSLog(@"传递的用户名:%@",_username);
                ModifyPasswordViewController *modifyPasswordView = [[ModifyPasswordViewController alloc]init];
                //用户名值传递head
                modifyPasswordView.username = _username;
                //用户名值传递tail
                [self.navigationController pushViewController:modifyPasswordView animated:YES];
                
                //exit(0);//主动结束进程，退出app
                //[self dismissViewControllerAnimated:YES completion:nil];
            }

            break;
        default:
            break;
    }
}

- (void)exit{
    [self dismissViewControllerAnimated:YES completion:nil];//模态弹入返回根视图（登陆界面）
    NSLog(@"退出成功！");
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
