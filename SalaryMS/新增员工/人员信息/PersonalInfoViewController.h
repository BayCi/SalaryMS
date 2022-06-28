//
//  PersonalInfoViewController.h
//  SalaryMS
//
//  Created by BayCi Gou on 2020/8/17.
//  Copyright © 2020 Apple lnc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListView.h"
NS_ASSUME_NONNULL_BEGIN

@interface PersonalInfoViewController : UIViewController<ZCDropDownDelegate>{
    ListView *listView;
    UITextField *name;
    UIButton *selectOffice;
    UIButton *selectCareer;
    UIButton *selectSex;
    UITextField *age;
}
@property (nonatomic, retain)NSMutableArray *officeDataArr;
@property (nonatomic, retain)NSMutableArray *careerDataArr;
@property (nonatomic, retain)NSMutableArray *sexDataArr;

@end

NS_ASSUME_NONNULL_END
