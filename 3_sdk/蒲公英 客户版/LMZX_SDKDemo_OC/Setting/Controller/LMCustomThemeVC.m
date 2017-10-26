//
//  SettingViewController.m
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/2/13.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMCustomThemeVC.h"
#import "LMZXSettingCell.h"
#import "LMZXSDK.h"
#import "LMZXColorViewController.h"
//#import "LMZXColorsController.h"
@interface LMCustomThemeVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *colorArray;
@end

static NSString *cellId = @"settingCellId";
@implementation LMCustomThemeVC

- (NSMutableArray *)colorArray {
    if (!_colorArray) {
        LMZXSDK *sdk = [LMZXSDK shared];
        
        _colorArray = [NSMutableArray arrayWithObjects:
                       sdk.lmzxThemeColor?sdk.lmzxThemeColor:[UIColor blackColor],
                       sdk.lmzxSubmitBtnColor?sdk.lmzxSubmitBtnColor:[UIColor blackColor],
                       sdk.lmzxPageBackgroundColor?sdk.lmzxPageBackgroundColor:[UIColor blackColor],
                       sdk.lmzxProtocolTextColor?sdk.lmzxProtocolTextColor:[UIColor blackColor],
                       sdk.lmzxTitleColor?sdk.lmzxTitleColor:[UIColor blackColor],nil];
    }
    return _colorArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LMZXSettingCell" bundle:nil] forCellReuseIdentifier:cellId];

    self.tableView.rowHeight = 44.0;
    self.tableView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    
    self.tableView.sectionFooterHeight = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.colorArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        LMZXSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.colorView.backgroundColor = self.colorArray[indexPath.row];
        switch (indexPath.row) {
            case 0:
                cell.titleLB.text = @"导航栏";
                break;
            case 1:
                cell.titleLB.text = @"提交按钮";
                break;
            case 2:
                cell.titleLB.text = @"页面背景";
                break;
            case 3:
                cell.titleLB.text = @"协议文字、动画";
                break;
            case 4:
                cell.titleLB.text = @"页面标题、返回按钮";
                break;
            default:
                break;
        }
        return cell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCellId"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"statusCellId"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dict = [self styleArray][indexPath.section-1];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:dict[@"styles"]];
    seg.selectedSegmentIndex = 0;
    seg.userInteractionEnabled = NO;
    //            [seg addTarget:self action:@selector(switchStatusBarStyle:) forControlEvents:(UIControlEventValueChanged)];
    
    cell.accessoryView = seg;
    cell.textLabel.text = dict[@"title"];
    
    
    
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"颜色搭配";
    } else if (section == 1) {
        return @"状态栏样式";
    }
    return @"退出模式";
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.section) {
        case 0:
        {
            

            LMZXSettingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            LMZXColorViewController *colorVc = [[LMZXColorViewController alloc] init];
            
            
            colorVc.colorBlock = ^(UIColor *color){
                [_colorArray replaceObjectAtIndex:indexPath.row withObject:color];
                
                switch (indexPath.row) {
                    case 0:
                        [LMZXSDK shared].lmzxThemeColor = color;
                        break;
                    case 1:
                        [LMZXSDK shared].lmzxSubmitBtnColor = color;
                        break;
                    case 2:
                        [LMZXSDK shared].lmzxPageBackgroundColor = color;
                        break;
                    case 3:
                        [LMZXSDK shared].lmzxProtocolTextColor = color;
                        break;
                    case 4:
                        [LMZXSDK shared].lmzxTitleColor = color;
                        break;
                    default:
                        break;
                }
                
                [tableView reloadData];
                
            };
            
            colorVc.title = cell.titleLB.text;
            colorVc.testColor = self.colorArray[indexPath.row];
            [self.navigationController pushViewController:colorVc animated:YES];
            
           break;
        }

            
        default:
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UISegmentedControl *seg = (UISegmentedControl *)cell.accessoryView;

            seg.selectedSegmentIndex = seg.selectedSegmentIndex ? 0 : 1;
            
            LMZXSDK *sdk = [LMZXSDK shared];
            if (indexPath.section == 1) {
                sdk.lmzxStatusBarStyle = seg.selectedSegmentIndex == 0 ? LMZXStatusBarStyleLightContent : LMZXStatusBarStyleDefault;
            } else {
                sdk.lmzxQuitOnSuccess = seg.selectedSegmentIndex == 0 ? true : false;
            }
            
            
             break;
        }
           
    }
    
    
    
}


- (NSArray *)styleArray {
    
    return @[
             @{
                 @"title": @"Default / LightContent",
                 @"styles": @[@"白",@"黑"]
               },
             @{
                 @"title": @"选择退出模式",
                 @"styles": @[@"查询成功退出",@"登录成功退出"]
                }
             
             ];
}


@end
