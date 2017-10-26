//
//  BaseLinkedMMDetailVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/11.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "BaseLinkedMMDetailVC.h"

#import "ReportLinkedinBaseInfoView.h"

#import "ReportLinkedinFriendInfoCell.h"
#import "JFactoryView.h"
#import "ReportLinkedinFriendInfoDetailVC.h"

#import "ReportLinkedinJobView.h"
#import "ReportLinkedinEducationView.h"

#import "MMMainModel.h"
#import "LinkedMainModel.h"

#import "YJNODataView.h"
@interface BaseLinkedMMDetailVC ()

@end

@implementation BaseLinkedMMDetailVC
{
    NSInteger rowH;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = RGB_pageBackground;
    switch (self.itemType) {
        case LinkedMMDetailBaseInfo://
        {
            self.title = @"基本信息";
            rowH = 44;
            break;
        }case LinkedMMDetailFriendInfo://
        {
            self.title = @"好友信息";
            rowH = 120.5;
            break;
        }case LinkedMMDetailWork://
        {
            self.title = @"工作经历";
            rowH = 44;
            break;
        }case LinkedMMDetailEducation://
        {
            self.title = @"教育经历";
            rowH = 44;
            break;
        }default:
            break;
    }

    if (!_dataDic && !_dataList.count) {
        self.tableView.delegate = nil;
        self.tableView.dataSource = nil;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = RGB_pageBackground;
        [self.view addSubview:[YJNODataView NODataView:NODataTypeRedNormal]];
        return;
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGB_pageBackground;
    if (self.itemType == LinkedMMDetailEducation|self.itemType == LinkedMMDetailWork) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    }else{
        self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 60, 0);
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 213;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    if (!_dataList) {
        self.dataList = [NSMutableArray arrayWithCapacity:1];
    }
    
    
    
    
}
//-(void)viewWillAppear:(BOOL)animated{
//    if (!_dataDic && !_dataList.count) {
//        [self.view sendSubviewToBack:self.tableView];
//        [self.view addSubview:[JFactoryView JGrayViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]];
//        [self.view addSubview:[YJNODataView NODataView:NODataTypeRedNormal]];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark--UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.itemType == LinkedMMDetailEducation|self.itemType == LinkedMMDetailWork) {
        return 10;
    }
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.itemType == LinkedMMDetailEducation|self.itemType == LinkedMMDetailWork) {
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        header.backgroundColor = RGB_pageBackground;
        return header;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.itemType == LinkedMMDetailEducation|self.itemType == LinkedMMDetailWork) {
        if (self.dataList.count) {
            return self.dataList.count;
        }
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.itemType == LinkedMMDetailEducation|self.itemType == LinkedMMDetailWork) {
        return 1;
    }
    if (self.dataList.count) {
        return self.dataList.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.itemType) {
        case LinkedMMDetailBaseInfo://
        {
            static NSString *TableSampleIdentifier = @"ReportLinkedinBaseInfoView";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
            if (cell == nil) {
                cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
                ReportLinkedinBaseInfoView *view = [ReportLinkedinBaseInfoView reportLinkedinBaseInfoView:self.searchType];
                view.searchType =self.searchType;
                if (self.dataDic) {
                    if (self.searchType == SearchItemTypeMaimai) {
                        view.mmModel = _dataDic;
                    } else if ( self.searchType ==SearchItemTypeLinkedin){
                        view.linkModel = _dataDic;
                    }
                }
                view.frame = cell.contentView.frame;
                view.backgroundColor =RGB_white;
                [cell.contentView addSubview:view];
                
            }
            return cell;
            
            break;
        }case LinkedMMDetailFriendInfo://
        {
            ReportLinkedinFriendInfoCell *cell = [ReportLinkedinFriendInfoCell reportLinkedinFriendInfoCell:tableView];
            cell.searchType =self.searchType;
            if (self.searchType == SearchItemTypeMaimai) {
                cell.mmModel = self.dataList[indexPath.row];
            } else if ( self.searchType ==SearchItemTypeLinkedin){
                cell.linkModel = self.dataList[indexPath.row];
            }
            if (indexPath.row == 0) {
                [cell addSubview:[JFactoryView JLineWith:CGRectMake(0, 0, SCREEN_WIDTH, 0.5) Super:cell.contentView]];
            }
            return cell;
            break;
        }case LinkedMMDetailWork://
        {
            ReportLinkedinJobView *cell = [[ReportLinkedinJobView alloc] reportLinkedinJobViewWith:tableView];
            cell.searchType =self.searchType;
            if (indexPath.row == 0) {
                [cell addSubview:[JFactoryView JLineWith:CGRectMake(0, 0, SCREEN_WIDTH, 0.5) Super:cell.contentView]];
            }
            
            if (self.searchType == SearchItemTypeMaimai) {
                cell.mmModel = self.dataList[indexPath.section];
            } else if ( self.searchType ==SearchItemTypeLinkedin){
                cell.linkModel = self.dataList[indexPath.section];
            }
            return cell;
            break;
        }case LinkedMMDetailEducation://
        {
            ReportLinkedinEducationView *cell = [[ReportLinkedinEducationView alloc] reportLinkedinEducationCell:tableView];
            cell.searchType =self.searchType;
            if (indexPath.row == 0) {
                [cell addSubview:[JFactoryView JLineWith:CGRectMake(0, 0, SCREEN_WIDTH, 0.5) Super:cell.contentView]];
            }
            if (self.dataList.count) {
                if (self.searchType == SearchItemTypeMaimai) {
                    cell.mmModel = self.dataList[indexPath.section];
                } else if ( self.searchType ==SearchItemTypeLinkedin){
                    cell.linkModel = self.dataList[indexPath.section];
                }
            }
            return cell;
            break;
        }default:
            break;
    }
    
    
    
    
    
    ReportLinkedinFriendInfoCell *cell = [ReportLinkedinFriendInfoCell reportLinkedinFriendInfoCell:tableView];
    cell.searchType =self.searchType;
    if (self.searchType == SearchItemTypeMaimai) {
        cell.mmModel = self.dataList[indexPath.row];
    } else if ( self.searchType ==SearchItemTypeLinkedin){
        cell.linkModel = self.dataList[indexPath.row];
    }
    if (indexPath.row == 0) {
        [cell addSubview:[JFactoryView JLineWith:CGRectMake(0, 0, SCREEN_WIDTH, 0.5) Super:cell.contentView]];
    }
    return cell;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str;
    switch (self.itemType) {
        case LinkedMMDetailBaseInfo://
        {
            if (self.dataDic) {
                if (self.searchType == SearchItemTypeMaimai) {
                    baseInfoMM *model = _dataDic ;
                    str = model.myIntroduction;
                } else if ( self.searchType ==SearchItemTypeLinkedin){
                    baseInfoLY *model = _dataDic;
                    str = model.myIntroduction;
                }
            }
            
            return [ReportLinkedinBaseInfoView cellHelight:str:self.searchType];
            break;
        }case LinkedMMDetailFriendInfo://
        {
            return 120.5;
            break;
        }case LinkedMMDetailWork://
        {
            if (self.dataList[indexPath.row]) {
                if (self.searchType == SearchItemTypeMaimai) {
                    workInfoMM *model = self.dataList[indexPath.section];
                    str = model.workDesc;
                } else if ( self.searchType ==SearchItemTypeLinkedin){
                    workInfoLY *model = self.dataList[indexPath.section];
                    str = model.workDesc;
                }
            }
            
            return [ReportLinkedinJobView cellHelight:str :self.searchType];
            break;
        }case LinkedMMDetailEducation://
        {
            if (self.dataList.count) {
                if (self.dataList[indexPath.row]) {
                    if (self.searchType == SearchItemTypeMaimai) {
                        educationInfoMM *model = self.dataList[indexPath.section];
                        str = model.educationDesc;
                    } else if ( self.searchType ==SearchItemTypeLinkedin){
                        educationInfoLY *model = self.dataList[indexPath.section];
                        str = model.educationDesc;
                    }
                }
            }
            
            
            return [ReportLinkedinEducationView  cellHelight:str :self.searchType];
            break;
        }default:
            break;
    }

    
    return 0;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.itemType == LinkedMMDetailFriendInfo) {
        ReportLinkedinFriendInfoDetailVC * detail = [[ReportLinkedinFriendInfoDetailVC alloc]init];
        detail.searchType = self.searchType;
        detail.data = self.dataList[indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}



@end
