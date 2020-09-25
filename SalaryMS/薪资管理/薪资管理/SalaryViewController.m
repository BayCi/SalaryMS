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

@interface SalaryViewController ()

@end

@implementation SalaryViewController

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
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [self colorWithHexString:@"EEEEEE" alpha:1.0f];
    //self.view.backgroundColor = [self colorWithHexString:@"FFC0CB" alpha:1.0f];
    self.navigationItem.title = @"薪资管理";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};//导航栏title颜色
    UIBarButtonItem *add = [[UIBarButtonItem alloc]initWithTitle:nil style:(UIBarButtonItemStylePlain) target:self action:@selector(add_click)];
    self.navigationItem.rightBarButtonItem = add;
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
    
    UIButton *Query = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    Query.layer.cornerRadius = 8.0;
    Query.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-120)/2, 512, 120, 40);
    [Query setTitle:@"查询" forState:(UIControlStateNormal)];
    Query.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];//设置按钮的标题字体类型及大小
    [Query setBackgroundColor:[UIColor greenColor]];
    [Query setTintColor:[UIColor whiteColor]];
    [self.view addSubview:Query];
    [Query addTarget:self action:@selector(query) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self selectDataArr_initalize];  //人员信息下拉框数组进行初始化
}

- (void)add_click{
    PersonalInfoViewController *personalInfoView = [[PersonalInfoViewController alloc]init];
    //self.hidesBottomBarWhenPushed = YES;//下一个页面入栈后隐藏底部分栏器
    [self.navigationController pushViewController:personalInfoView animated:YES];
}

- (void)query{
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

- (void)officeClick:(UIButton *)btn{
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

- (void)careerClick:(UIButton *)btn{
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

- (void)sexClick:(UIButton *)btn{
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
