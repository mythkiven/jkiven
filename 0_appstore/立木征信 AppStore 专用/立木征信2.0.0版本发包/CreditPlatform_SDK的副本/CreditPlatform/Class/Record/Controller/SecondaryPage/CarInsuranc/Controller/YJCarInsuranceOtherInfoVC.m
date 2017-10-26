//
//  YJCarInsuranceOtherInfoVC.m
//  CreditPlatform
//
//  Created by yj on 2016/11/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCarInsuranceOtherInfoVC.h"
#import "YJCarInsuranceModel.h"

#import "YJCarInsurancePolicyInfoCell.h"
#import "YJCarInsuranceCarInfoCell.h"
#import "YJCarInsuranceTaxInfoCell.h"

@interface YJCarInsuranceOtherInfoVC ()<UITableViewDataSource>



@end

@implementation YJCarInsuranceOtherInfoVC



- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.view.backgroundColor = RGB_pageBackground;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    switch (self.showType) {
        case CarInsuranceShowTypePolicy:
        {
            [self.tableView registerClass:[YJCarInsurancePolicyInfoCell class] forCellReuseIdentifier:NSStringFromClass([YJCarInsurancePolicyInfoCell class])];
            self.title = @"保单信息";
            break;
        }
            
        case CarInsuranceShowTypeCarInfo:
        {
            
            [self.tableView registerClass:[YJCarInsuranceCarInfoCell class] forCellReuseIdentifier:NSStringFromClass([YJCarInsuranceCarInfoCell class])];
            self.title = @"车辆信息";
            break;
        }
            
        case CarInsuranceShowTypeTax:
        {
            self.title = @"代收车船税";
            [self.tableView registerClass:[YJCarInsuranceTaxInfoCell class] forCellReuseIdentifier:NSStringFromClass([YJCarInsuranceTaxInfoCell class])];
            break;
        }
            
        default:
            break;
    }
    
    
    

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    YJCarInsuranceOtherInfoCell *cell = [YJCarInsuranceOtherInfoCell carInsuranceOtherInfoCellWithTableView:tableView];;
    
    
    
    
    switch (self.showType) {
        case CarInsuranceShowTypePolicy:
        {

            YJCarInsurancePolicyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YJCarInsurancePolicyInfoCell class])];
            
            cell.policyDetails = self.policyDetails;
            return cell;
            break;
        }
            
        case CarInsuranceShowTypeCarInfo:
        {

            YJCarInsuranceCarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YJCarInsuranceCarInfoCell class])];
            YJCarInsuranceVehicleInfo *vehicleInfo = self.policyDetails.vehicleInfoModel;
            
            cell.vehicleInfo = vehicleInfo;
            return cell;
            break;
        }
            
        case CarInsuranceShowTypeTax:
        {

            YJCarInsuranceTaxInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YJCarInsuranceTaxInfoCell class])];
            YJCarInsuranceVehicleVesselTax *vehicleVesselTax = self.policyDetails.vehicleVesselTaxModel;
            
            cell.vehicleVesselTax = vehicleVesselTax;
            return cell;
            break;
        }
            
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MYLog(@"----heightForRowAtIndexPath%ld",indexPath.row);
    

    CGFloat cellH = 0;
    switch (self.showType) {
        case CarInsuranceShowTypePolicy:
        {
            
            cellH = [self.tableView cellHeightForIndexPath:indexPath model:self.policyDetails keyPath:@"policyDetails" cellClass:[YJCarInsurancePolicyInfoCell class] contentViewWidth:[self cellContentViewWith]];
            
            break;
        }
            
            
        case CarInsuranceShowTypeCarInfo:
        {
            YJCarInsuranceVehicleInfo *vehicleInfo = self.policyDetails.vehicleInfoModel;
            
            cellH = [self.tableView cellHeightForIndexPath:indexPath model:vehicleInfo keyPath:@"vehicleInfo" cellClass:[YJCarInsuranceCarInfoCell class] contentViewWidth:[self cellContentViewWith]];
            break;
        }
            
        case CarInsuranceShowTypeTax:
        {
            YJCarInsuranceVehicleVesselTax *vehicleVesselTax = self.policyDetails.vehicleVesselTaxModel;
            
            cellH = [self.tableView cellHeightForIndexPath:indexPath model:vehicleVesselTax keyPath:@"vehicleVesselTax" cellClass:[YJCarInsuranceTaxInfoCell class] contentViewWidth:[self cellContentViewWith]];
            break;
        }
            
        default:
            break;
    }
    
    return cellH;
    
    
}



- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
