//
//  PersonalInfoViewController.m
//  SalaryMS
//
//  Created by BayCi Gou on 2020/8/17.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "SalaryDetailViewController.h"
@interface PersonalInfoViewController ()

@end

@implementation PersonalInfoViewController

- (void)selectDataArr_initalizeFuction{
    self.officeDataArr = [NSMutableArray array];
    [_officeDataArr addObject:@"经理室"];
    [_officeDataArr addObject:@"财务科"];
    [_officeDataArr addObject:@"技术科"];
    [_officeDataArr addObject:@"销售科"];
    
    self.careerDataArr = [NSMutableArray array];
    [_careerDataArr addObject:@"经理"];
    [_careerDataArr addObject:@"财务"];
    [_careerDataArr addObject:@"工程师"];
    [_careerDataArr addObject:@"销售员"];
    
    self.sexDataArr = [NSMutableArray array];
    [_sexDataArr addObject:@"男"];
    [_sexDataArr addObject:@"女"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [self colorWithHexString:@"EEEEEE" alpha:1.0f];
    //self.view.backgroundColor = [self colorWithHexString:@"FFC0CB" alpha:1.0f];
    
    self.navigationItem.title = @"人员信息";
    UILabel *PageTitle = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 175, 50)];
    PageTitle.textColor = [UIColor blackColor];
    PageTitle.text = @"人员信息";
    PageTitle.textAlignment = NSTextAlignmentCenter;
    [PageTitle setFont:[UIFont systemFontOfSize:25]];
    [self.view addSubview:PageTitle];
    
    UILabel *Name = [[UILabel alloc]initWithFrame:CGRectMake(37.5, 120, 50, 30)];
    Name.textColor = [UIColor blackColor];
    Name.text = @"姓名";
    [self.view addSubview:Name];
    name = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 155, 300, 30)];
    name.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    [name setDelegate:self];
    name.textColor = [UIColor blackColor];
    name.clearButtonMode = UITextFieldViewModeAlways;
    name.layer.borderWidth = 1;
    name.layer.borderColor = [[UIColor blackColor] CGColor];
    name.layer.cornerRadius = 5;
    [self.view addSubview:name];
    
    UILabel *Office = [[UILabel alloc]initWithFrame:CGRectMake(37.5, 195, 50, 30)];
    Office.textColor = [UIColor blackColor];
    Office.text = @"科室";
    [self.view addSubview:Office];
//    UITextField *office = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 260, 300, 30)];
//    office.backgroundColor = [UIColor systemGray4Color];
//    [self.view addSubview:office];
    selectOffice = [[UIButton alloc]initWithFrame:CGRectMake(37.5, 230, 300, 30)];
    [selectOffice setTitle:@"请选择" forState:(UIControlStateNormal)];
    [selectOffice setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    selectOffice.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    [selectOffice addTarget:self action:@selector(officeClick:) forControlEvents:UIControlEventTouchUpInside];
    selectOffice.layer.borderWidth = 1;
    selectOffice.layer.borderColor = [[UIColor blackColor] CGColor];
    selectOffice.layer.cornerRadius = 5;
    [self.view addSubview:selectOffice];
    
    UILabel *Career = [[UILabel alloc]initWithFrame:CGRectMake(37.5, 270, 50, 30)];
    Career.textColor = [UIColor blackColor];
    Career.text = @"职业";
    [self.view addSubview:Career];
//    UITextField *career = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 335, 300, 30)];
//    career.backgroundColor = [UIColor systemGray4Color];
//    [self.view addSubview:career];
    selectCareer = [[UIButton alloc]initWithFrame:CGRectMake(37.5, 305, 300, 30)];
    [selectCareer setTitle:@"请选择" forState:(UIControlStateNormal)];
    [selectCareer setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    selectCareer.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    [selectCareer addTarget:self action:@selector(careerClick:) forControlEvents:UIControlEventTouchUpInside];
    selectCareer.layer.borderWidth = 1;
    selectCareer.layer.borderColor = [[UIColor blackColor] CGColor];
    selectCareer.layer.cornerRadius = 5;
    [self.view addSubview:selectCareer];
    
    UILabel *Sex = [[UILabel alloc]initWithFrame:CGRectMake(37.5, 355, 50, 30)];
    Sex.textColor = [UIColor blackColor];
    Sex.text = @"性别";
    [self.view addSubview:Sex];
//    UITextField *sex = [[UITextField alloc]initWithFrame:CGRectMake(37.5, 420, 120, 30)];
//    sex.backgroundColor = [UIColor systemGray4Color];
//    [self.view addSubview:sex];
    selectSex = [[UIButton alloc]initWithFrame:CGRectMake(37.5, 390, 120, 30)];
    [selectSex setTitle:@"请选择" forState:(UIControlStateNormal)];
    [selectSex setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    selectSex.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    [selectSex addTarget:self action:@selector(sexClick:) forControlEvents:UIControlEventTouchUpInside];
    selectSex.layer.borderWidth = 1;
    selectSex.layer.borderColor = [[UIColor blackColor] CGColor];
    selectSex.layer.cornerRadius = 5;
    [self.view addSubview:selectSex];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listChanged:) name:@"NOTI" object:nil];
    
    UILabel *Age = [[UILabel alloc]initWithFrame:CGRectMake(217.5, 355, 50, 30)];
    Age.textColor = [UIColor blackColor];
    Age.text = @"年龄";
    [self.view addSubview:Age];
    age = [[UITextField alloc]initWithFrame:CGRectMake(217.5, 390, 120, 30)];
    age.backgroundColor = [self colorWithHexString:@"9F9F9F" alpha:1.0f];
    age.textColor = [ UIColor blackColor];
    age.keyboardType = UIKeyboardTypeNumberPad;
    [age setDelegate:self];
    age.clearButtonMode = UITextFieldViewModeAlways;
    age.layer.borderWidth = 1;
    age.layer.borderColor = [[UIColor blackColor] CGColor];
    age.layer.cornerRadius = 5;
    [self.view addSubview:age];
    
    UIButton *nextButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    nextButton.layer.cornerRadius = 8.0;
    nextButton.frame = CGRectMake(165, 512, 45, 45);
    [nextButton setImage:[UIImage imageNamed:@"next.png"] forState:(UIControlStateNormal)];
    
    //[nextButton setTitle:@"查询" forState:(UIControlStateNormal)];
    //[nextButton setBackgroundColor:[UIColor greenColor]];
    [nextButton setTintColor:[UIColor darkGrayColor]];
    [self.view addSubview:nextButton];
    [nextButton addTarget:self action:@selector(next_clickFuction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self selectDataArr_initalizeFuction];  //人员信息下拉框数组进行初始化
}

- (void)next_clickFuction{
    SalaryDetailViewController *salaryDetailView = [[SalaryDetailViewController alloc]init];
    [self.navigationController pushViewController:salaryDetailView animated:YES];
    //查询信息传值head
    salaryDetailView.inputName = name.text;
    salaryDetailView.inputOffice = selectOffice.titleLabel.text;
    salaryDetailView.inputCareer = selectCareer.titleLabel.text;
    salaryDetailView.inputSex = selectSex.titleLabel.text;
    salaryDetailView.inputAge = age.text;
    //查询信息传值foot
    NSLog(@"名字:%@",name.text);
    NSLog(@"科室:%@",selectOffice.titleLabel.text);
    NSLog(@"职业:%@",selectCareer.titleLabel.text);
    NSLog(@"性别:%@",selectSex.titleLabel.text);
    NSLog(@"年龄:%@",age.text);
    
    salaryDetailView.navigationItem.hidesBackButton = YES;
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
    int movementDistance = -70; // tweak as needed
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
