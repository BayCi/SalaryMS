//
//  YGViewController.m
//  CustomTableViewCell
//
//  Created by yangguang on 13-10-15.
//  Copyright (c) 2013年 atany. All rights reserved.
//

#import "YGViewController.h"
#import "ModificationInfoViewController.h"
#import "sqlite3.h"
@interface YGViewController ()
{
     char *error;
     sqlite3 * db;
}
@end

@implementation YGViewController

@synthesize stuArray = _stuArray;
@synthesize teaArray = _teaArray;
@synthesize teaCell = _teaCell;

int dataInitiCount = 0;//cell的数据初始化次数
int i = 0;
int ii = 0;
int resultCount = 0;//查询结果的记录条数
NSString *resultName = @"";//员工信息查询的员工名
NSString *selectSqlSalary;//员工个人薪资查询sql语句

//cell的数据初始化方法
- (void)Set_name:(NSString*)name Set_sex:(NSString*)sex Set_age:(int)age Set_office:(NSString*)office Set_career:(NSString*)career Set_company:(NSString*)company Set_totalSalary:(NSString*)totalSalary Set_baseSalary:(NSString*)baseSalary Set_welfare:(NSString*)welfare Set_bonusSalary:(NSString*)bonusSalary Set_unemployInsurance:(NSString*)unemployInsurance Set_housingFund:(NSString*)housingFund{
    NSLog(@"进入cell的数据初始化方法");
    
    int NSDictionaryCount = resultCount;//用于创建cell的NSDictionary个数
    //需修改
    
    //初始化数据
    if (0 <= dataInitiCount <= NSDictionaryCount) {
        if (dataInitiCount == 0) {
            NSLog(@"dataInitiCount == 0");
            
            NSDictionary *tDic1 = [[NSDictionary alloc]initWithObjectsAndKeys:name,@"name",totalSalary,@"totalSalary",sex,@"sex",[NSString stringWithFormat:@"%d",age],@"age",office,@"adminOffice",career,@"position",company,@"organization",baseSalary,@"baseSalary",welfare,@"welfare",bonusSalary,@"bonusSalary",unemployInsurance,@"unemployInsurance",housingFund,@"housingFund",nil];
            _teaArray = [NSMutableArray arrayWithObject:tDic1];
        }else{
            NSDictionary *tDic = [[NSDictionary alloc]initWithObjectsAndKeys:name,@"name",totalSalary,@"totalSalary",sex,@"sex",[NSString stringWithFormat:@"%d",age],@"age",office,@"adminOffice",career,@"position",company,@"organization",baseSalary,@"baseSalary",welfare,@"welfare",bonusSalary,@"bonusSalary",unemployInsurance,@"unemployInsurance",housingFund,@"housingFund",nil];
            [_teaArray addObject:tDic];
        }
    }
    
}

//个人信息查询的员工名初始化方法
- (void)selectSqlSalaryInitFuction:(NSString*)employeeName{
    resultName = employeeName;
    selectSqlSalary=[NSString stringWithFormat:@"select * from wages where e_name='%@'",resultName];
}

//数据库查询操作方法实现
- (void)queryFunction{
    NSLog(@"进入查询页面！");
    dataInitiCount = 0;//cell的数据初始化次数回零
    NSLog(@"cell的数据初始化次数:%d",dataInitiCount);
    
    [self openSqlite];
    [self creatTable];
    [self selectSql];
    [self closeSqlite];
    NSLog(@"需要查询的员工名:%@",_queryName);
    NSLog(@"需要查询的员工科室:%@",_queryOffice);
    NSLog(@"需要查询的员工年龄:%@",_queryAge);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置视图背景色
	self.view.backgroundColor = [self colorWithHexString:@"EEEEEE" alpha:1.0f];
    //设置导航栏右按钮：页面刷新按钮
    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"refrsh.png"] style:(UIBarButtonItemStyleDone) target:self action:@selector(refrshAction)];
    self.navigationItem.rightBarButtonItem = reloadButton;
    
    //数据库查询操作方法调用，用于数据查询及返回
    [self queryFunction];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //数据库查询操作方法调用，用于数据查询及返回
    [self queryFunction];
    [self->YGtableView reloadData];//重载刷新数据
    NSLog(@"页面返回，重载刷新数据");
}

//每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 1?[_stuArray count]:[_teaArray count];

}

//表的分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//定义分区的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section == 1?@"学生信息":@"查询结果";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.backgroundColor = [self colorWithHexString:@"EEEEEE" alpha:1.0f];
    self->YGtableView = tableView;
    
    cell.backgroundView.backgroundColor = [self colorWithHexString:@"EEEEEE" alpha:1.0f];
    if([indexPath section] == 1){
        //通过代码自定义cell
        cell = [self customCellWithOutXib:tableView withIndexPath:indexPath];
    }
    else{
        //通过nib自定义cell
        cell = [self customCellByXib:tableView withIndexPath:indexPath];
    }
    cell = [self customCellByXib:tableView withIndexPath:indexPath];
    assert(cell != nil);
    
    //添加左滑右滑手势
    //    UISwipeGestureRecognizer *swipeLeftGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    //    swipeLeftGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    //    //longPressGR.delegate = self;
    //    [cell addGestureRecognizer:swipeLeftGesture];
    
    //添加长按手势
//    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
//    //[_tableView addGestureRecognizer:longPressGR];
//    longPressGR.minimumPressDuration = 1.0;//设置长按手势的最短触发时间
//    [cell addGestureRecognizer:longPressGR];//cell添加长按手势
    
    return cell;
}

//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 320;
}

//通过代码自定义cell
-(UITableViewCell *)customCellWithOutXib:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    //定义标识符
    static NSString *customCellIndentifier = @"CustomCellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customCellIndentifier];
    
    //定义新的cell
    if(cell == nil){
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCellIndentifier];
        //姓名
        CGRect nameRect = CGRectMake(88, 15, 70, 25);
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
        nameLabel.font = [UIFont boldSystemFontOfSize:nameFontSize];
        nameLabel.tag = nameTag;
        nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:nameLabel];
        
        //班级
        CGRect classTipRect = CGRectMake(88, 40, 40, 14);
        UILabel *classTipLabel = [[UILabel alloc]initWithFrame:classTipRect];
        classTipLabel.text = @"班级:";
        classTipLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        [cell.contentView addSubview:classTipLabel];
        
        
        CGRect classRect = CGRectMake(135, 40, 40, 14);
        UILabel *classLabel = [[UILabel alloc]initWithFrame:classRect];
        classLabel.tag = classTag;
        classLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        [cell.contentView addSubview:classLabel];
        
        //学号
        CGRect stuNameTipRect = CGRectMake(88, 60, 40, 12);
        UILabel *stuNameTipLabel = [[UILabel alloc]initWithFrame:stuNameTipRect];
        stuNameTipLabel.text = @"学号:";
        stuNameTipLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        [cell.contentView addSubview:stuNameTipLabel];
        
        CGRect stuNameRect = CGRectMake(135, 60, 150, 14);
        UILabel *stuNameLabel = [[UILabel alloc]initWithFrame:stuNameRect];
        stuNameLabel.tag = stuNumberTag;
        stuNameLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        
        [cell.contentView addSubview:stuNameLabel];
        
        //图片
        CGRect imageRect = CGRectMake(15, 15, 60, 60);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
        imageView.tag = imageTag;
        
        //为图片添加边框
        CALayer *layer = [imageView layer];
        layer.cornerRadius = 8;
        layer.borderColor = [[UIColor whiteColor]CGColor];
        layer.borderWidth = 1;
        layer.masksToBounds = YES;
        [cell.contentView addSubview:imageView];
    }
    //获得行数
    NSUInteger row = [indexPath row];
    
    //取得相应行数的数据（NSDictionary类型，包括姓名、班级、学号、图片名称）
    NSDictionary *dic = [_stuArray objectAtIndex:row];
    
    //设置图片
    UIImageView *imageV = (UIImageView *)[cell.contentView viewWithTag:imageTag];
    imageV.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
    
    //设置姓名
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:nameTag];
    name.text = [dic objectForKey:@"name"];
    
    //设置班级
    UILabel *class = (UILabel *)[cell.contentView viewWithTag:classTag];
    class.text = [dic objectForKey:@"class"];
    
    //设置学号
    UILabel *stuNumber = (UILabel *)[cell.contentView viewWithTag:stuNumberTag];
    stuNumber.text = [dic objectForKey:@"stuNumber"];
    
    //设置右侧箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

//通过nib文件自定义cell
-(UITableViewCell *)customCellByXib:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];//加载nib文件
        if([nib count]>0){
            cell = _teaCell;
        }
        else{
            assert(NO);//读取文件失败
        }
    }
    NSUInteger row = [indexPath row];
    NSDictionary *dic  = [_teaArray objectAtIndex:row];
    //姓名
    ((UILabel *)[cell.contentView viewWithTag:teaNameTag]).text = [dic objectForKey:@"name"];

    //总工资
    ((UILabel *)[cell.contentView viewWithTag:teaTotalSalaryTag]).text = [dic objectForKey:@"totalSalary"];

    //类型
    ((UILabel *)[cell.contentView viewWithTag:teaTypeTag]).text = [dic objectForKey:@"type"];

    //办公室
    ((UILabel *)[cell.contentView viewWithTag:teaOfficeTag]).text = [dic objectForKey:@"office"];

    //性别
    ((UILabel *)[cell.contentView viewWithTag:teaSexTag]).text = [dic objectForKey:@"sex"];

    //年龄
    ((UILabel *)[cell.contentView viewWithTag:teaAgeTag]).text = [dic objectForKey:@"age"];

    //科室
    ((UILabel *)[cell.contentView viewWithTag:teaAdminOfficeTag]).text = [dic objectForKey:@"adminOffice"];

    //职位
    ((UILabel *)[cell.contentView viewWithTag:teaPositionTag]).text = [dic objectForKey:@"position"];

    //单位
    ((UILabel *)[cell.contentView viewWithTag:teaOrganizationTag]).text = [dic objectForKey:@"organization"];

    //基本工资
    ((UILabel *)[cell.contentView viewWithTag:teaBaseSalaryTag]).text = [dic objectForKey:@"baseSalary"];

    //福利补贴
    ((UILabel *)[cell.contentView viewWithTag:teaWelfareTag]).text = [dic objectForKey:@"welfare"];

    //奖励工资
    ((UILabel *)[cell.contentView viewWithTag:teaBonusSalaryTag]).text = [dic objectForKey:@"bonusSalary"];

    //失业保险
    ((UILabel *)[cell.contentView viewWithTag:teaUnemployInsuranceTag]).text = [dic objectForKey:@"unemployInsurance"];

    //住房公积金
    ((UILabel *)[cell.contentView viewWithTag:teaHousingFundTag]).text = [dic objectForKey:@"housingFund"];

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self->YGtableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"进入编辑");
        
        [self becomeFirstResponder];
        UITableViewCell *YGcell = (UITableViewCell *)[self->YGtableView cellForRowAtIndexPath:indexPath];
        //当前处于被点击状态的cell的员工名字
        NSLog(@"当前点击的cell标题名称：%@",((UILabel *)[YGcell.contentView viewWithTag:teaNameTag]).text);
        
        ModificationInfoViewController *modificationView = [[ModificationInfoViewController alloc]init];
        [self.navigationController pushViewController:modificationView animated:YES];
        //页面跳转传值head
        modificationView.tableView = self->YGtableView;
        modificationView.beModifiedEmployeeName = ((UILabel *)[YGcell.contentView viewWithTag:teaNameTag]).text;//姓名
        modificationView.beModifiedEmployeeOffice = ((UILabel *)[YGcell.contentView viewWithTag:teaAdminOfficeTag]).text;//科室
        modificationView.beModifiedEmployeeCareer = ((UILabel *)[YGcell.contentView viewWithTag:teaPositionTag]).text;//职业
        modificationView.beModifiedEmployeeSex = ((UILabel *)[YGcell.contentView viewWithTag:teaSexTag]).text;//性别
        modificationView.beModifiedEmployeeAge = ((UILabel *)[YGcell.contentView viewWithTag:teaAgeTag]).text;//年龄
        modificationView.beModifiedEmployeeBaseSalary = ((UILabel *)[YGcell.contentView viewWithTag:teaBaseSalaryTag]).text;//基本工资
        modificationView.beModifiedEmployeeWefare = ((UILabel *)[YGcell.contentView viewWithTag:teaWelfareTag]).text;//福利补贴
        modificationView.beModifiedEmployeeBonusWage = ((UILabel *)[YGcell.contentView viewWithTag:teaBonusSalaryTag]).text;//奖励工资
        modificationView.beModifiedEmployeeHousingFund = ((UILabel *)[YGcell.contentView viewWithTag:teaHousingFundTag]).text;//住房公积金
        modificationView.beModifiedEmployeeUnemployInsurance = ((UILabel *)[YGcell.contentView viewWithTag:teaUnemployInsuranceTag]).text;//失业保险
        //传值tail
    }];
    editAction.backgroundColor = [self colorWithHexString:@"EAA7A0" alpha:1.0f];
    //editAction.title
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除？" preferredStyle:(UIAlertControllerStyleAlert) ];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action){
            NSLog(@"取消删除！");
        }];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action){
            NSLog(@"确定删除！");
            
            [self becomeFirstResponder];
            UITableViewCell *YGcell = (UITableViewCell *)[self->YGtableView cellForRowAtIndexPath:indexPath];

            NSLog(@"当前点击的cell标题名称：%@",((UILabel *)[YGcell.contentView viewWithTag:teaNameTag]).text);
            //当前处于被点击状态的cell的员工名字
            NSString *currentlyClickedCellForEmployeeName = ((UILabel *)[YGcell.contentView viewWithTag:teaNameTag]).text;
            [self openSqlite];
            [self creatTable];
            [self deleteSql:currentlyClickedCellForEmployeeName];
            //[self deleteSql];
            [self closeSqlite];
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        [alertView addAction:cancelAction];
        [alertView addAction:sureAction];
        //适配ipad
        UIPopoverPresentationController *popover = alertView.popoverPresentationController;
        if (popover) {
            popover.sourceView =self.view;
            popover.sourceRect = CGRectMake((self.view.frame.size.width - alertView.view.frame.size.width)/2, (self.view.frame.size.height - 100)/2, 100, 100);
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
        [self presentViewController:alertView animated:YES completion:nil];
        
    }];
    deleteAction.backgroundColor = [self colorWithHexString:@"B6B1B1" alpha:1.0f];
    
    return @[deleteAction,editAction];
}

//查询页面添加长按手势
//- (void)longPressAction:(UILongPressGestureRecognizer *)longPressGR
//{
//    if (longPressGR.state==UIGestureRecognizerStateBegan) {
//          //成为第一响应者，需重写该方法
//        [self becomeFirstResponder];
//        CGPoint location = [longPressGR locationInView:self->YGtableView];
//        NSIndexPath * indexPath = [self->YGtableView indexPathForRowAtPoint:location];//可以得到此时你点击的哪一行
//        UITableViewCell *YGcell = (UITableViewCell *)[self->YGtableView cellForRowAtIndexPath:indexPath];
//
//        NSLog(@"当前点击的cell标题名称：%@",((UILabel *)[YGcell.contentView viewWithTag:teaNameTag]).text);
//        //当前处于被点击状态的cell的员工名字
//        NSString *currentlyClickedCellForEmployeeName = ((UILabel *)[YGcell.contentView viewWithTag:teaNameTag]).text;
//
//
//        UIAlertController *tipsAlertView = [UIAlertController alertControllerWithTitle:@"删除数据提示" message:@"是否删除该条数据，请选择：" preferredStyle:(UIAlertControllerStyleActionSheet)];
//        tipsAlertView.view.backgroundColor = [UIColor whiteColor];
//        tipsAlertView.view.tintColor = [UIColor blackColor];
//        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//            NSLog(@"确定删除！");
//            [self openSqlite];
//            [self creatTable];
//            [self deleteSql:currentlyClickedCellForEmployeeName];
//            //[self deleteSql];
//            [self closeSqlite];
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
//        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//            NSLog(@"取消删除！");
//        }];
//        [tipsAlertView addAction:sure];
//        [tipsAlertView addAction:cancel];
//        [self presentViewController:tipsAlertView animated:YES completion:nil];
//
//        NSLog(@"长按手势已生效！");
//    }
//}

//刷新按钮的方法实现
- (void)refrshAction{
    //数据库查询操作方法调用，用于数据查询及返回
    [self queryFunction];
    
    [self->YGtableView reloadData];
    NSLog(@"数据刷新已完成！");
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
-(void)selectSql
{
    // @"select * from myTable"  查询所有 key 值内容
    
    //查询记录
    //sqlite3_stmt *statement;
    sqlite3_stmt *statementInfo = NULL;//个人信息
    sqlite3_stmt *statementInfoCount = NULL;//个人信息查询结果数目
    sqlite3_stmt *statementInfoName = NULL;//个人信息
    sqlite3_stmt *statementSalary = NULL;//各项工资
    
    //员工个人信息的查询结果数目sql语句
    NSString *selectSqlInfoCount=[NSString stringWithFormat:@"select count(*) from member where ( (e_name = '%@' or '%@' is '') and (e_depart = '%@' or '%@' is '请选择') and (e_prof = '%@' or '%@' is '请选择') and (e_sex = '%@' or '%@' is '请选择') and (e_age = '%@' or '%@' is ''))",_queryName,_queryName,_queryOffice,_queryOffice,_queryCareer,_queryCareer,_querySex,_querySex,_queryAge,_queryAge];
    
    //员工个人信息查询sql语句
    NSString *selectSqlInfo=[NSString stringWithFormat:@"select * from member where ( (e_name = '%@' or '%@' is '') and (e_depart = '%@' or '%@' is '请选择') and (e_prof = '%@' or '%@' is '请选择') and (e_sex = '%@' or '%@' is '请选择') and (e_age = '%@' or '%@' is ''))",_queryName,_queryName,_queryOffice,_queryOffice,_queryCareer,_queryCareer,_querySex,_querySex,_queryAge,_queryAge];
    
    //员工个人信息查询员工名sql语句
    NSString *selectSqlInfoName=[NSString stringWithFormat:@"select e_name from member where ( (e_name = '%@' or '%@' is '') and (e_depart = '%@' or '%@' is '请选择') and (e_prof = '%@' or '%@' is '请选择') and (e_sex = '%@' or '%@' is '请选择') and (e_age = '%@' or '%@' is ''))",_queryName,_queryName,_queryOffice,_queryOffice,_queryCareer,_queryCareer,_querySex,_querySex,_queryAge,_queryAge];
    
    //员工个人薪资查询sql语句
    selectSqlSalary;

    if ((sqlite3_prepare_v2(db, [selectSqlInfoCount UTF8String], -1, &statementInfoCount, nil) == SQLITE_OK) && (sqlite3_prepare_v2(db, [selectSqlInfoName UTF8String], -1, &statementInfoName, nil) == SQLITE_OK)) {
        sqlite3_step(statementInfoCount);
        
            // 查询记录数目的值
            resultCount = sqlite3_column_int(statementInfoCount, 0);
            NSLog(@"代码中部初始化执行次数:%d",++i);
        
        if (sqlite3_step(statementInfoName) == SQLITE_ROW) {
            resultName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInfoName, 0)] ;
        }
        
        //对员工个人薪资查询sql语句进行实值初始化
        selectSqlSalary=[NSString stringWithFormat:@"select * from wages where e_name='%@'",resultName];
        
            if ((sqlite3_prepare_v2(db, [selectSqlInfo UTF8String], -1, &statementInfo, nil) == SQLITE_OK) && (sqlite3_prepare_v2(db, [selectSqlSalary UTF8String], -1, &statementSalary, nil) == SQLITE_OK) ) {
                
                while((sqlite3_step(statementInfo) == SQLITE_ROW) && (sqlite3_step(statementSalary) == SQLITE_ROW)) {
                    
                    // 查询 姓名 的值
                    NSString * name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInfo, 0)];
                    self.resNameLabel.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInfo, 0)];
                    NSLog(@"代码尾部初始化执行次数:%d",++ii);
                    
                    // 查询 性别
                    NSString * sex = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInfo, 1)];
                    
                    // 查询 年龄
                    int age = sqlite3_column_int(statementInfo, 2);
                    
                    // 查询 科室
                    NSString * office = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInfo, 5)];
                    
                    // 查询 职位
                    NSString * career = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInfo, 3)];
                    
                    // 查询 单位
                    NSString * company = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInfo, 4)];
                    
                    // 查询 总工资
                    NSString * totalSalary = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementSalary, 6)];
                    
                    // 查询 基本工资
                    //int baseSalary = sqlite3_column_int(statement, 1);
                    NSString * baseSalary = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementSalary, 1)];
                    
                    // 查询 福利补贴
                    NSString * welfare = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementSalary, 2)];
                    
                    // 查询 奖励工资
                    NSString * bonusSalary = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementSalary, 3)];
                    
                    // 查询 失业保险
                    NSString * unemployInsurance = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementSalary, 4)];
                    
                    // 查询 住房公积金
                    NSString * housingFund = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementSalary, 5)];
                    
                    
                    NSLog(@"\n 姓名: %@\n 性别: %@\n 年龄: %i\n 科室: %@\n 职位: %@\n 单位: %@ \n 总工资: %@ \n 基本工资: %@ \n 福利补贴: %@ \n 奖励工资: %@ \n 失业保险: %@ \n 住房公积金: %@ ", name, sex, age, office, career, company, totalSalary, baseSalary, welfare, bonusSalary, unemployInsurance, housingFund);
                    
                    //cell的数据初始化方法调用
                    [self Set_name:name Set_sex:sex Set_age:age Set_office:office Set_career:career Set_company:company Set_totalSalary:totalSalary Set_baseSalary:baseSalary Set_welfare:welfare Set_bonusSalary:bonusSalary Set_unemployInsurance:unemployInsurance Set_housingFund:housingFund];//将查询结果进行cell初始化
                    dataInitiCount += 1;//数据初始化次数自增1
                   
                    if (sqlite3_step(statementInfoName) == SQLITE_ROW) {
                        NSString * nextEmployeeName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInfoName, 0)];
                        
                        [self selectSqlSalaryInitFuction:nextEmployeeName];
                        NSLog(@"到这了前的resultName：%@",resultName);
                        sqlite3_prepare_v2(db, [selectSqlSalary UTF8String], -1, &statementSalary, nil);
                    }
                }
            } else {
                NSLog(@"select operation is fail.");
            }
              sqlite3_finalize(statementInfo);
              sqlite3_finalize(statementSalary);
            
    }else {
        NSLog(@"select operation is fail.");
    }
      sqlite3_finalize(statementInfoCount);
      sqlite3_finalize(statementInfoName);
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
