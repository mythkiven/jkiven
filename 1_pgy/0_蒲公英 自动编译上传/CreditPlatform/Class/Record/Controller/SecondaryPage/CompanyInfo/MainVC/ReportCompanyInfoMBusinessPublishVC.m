//
//  ReportCompanyInfoBaseVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/26.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ReportCompanyInfoMBusinessPublishVC.h"
#import "ReportCompanyInfoBusinessPublishVC.h"

#import "ReportCompanyInfoMainBaseHeaderView.h"

#import "YJBaseItem.h"
#import "YJItemGroup.h"
#import "YJArrowItem.h"
#import "YJSearchConditionModel.h"
#import "YJMeCell.h"
#import "YJTextItem.h"

@interface ReportCompanyInfoMBusinessPublishVC ()<UIViewControllerPreviewingDelegate,UIGestureRecognizerDelegate,UITextViewDelegate>


@end

@implementation ReportCompanyInfoMBusinessPublishVC

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSArray array];
    self.tableView.backgroundColor = RGB_pageBackground;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    [self creatUI];
}
 
#pragma mark - 创建View
- (void)creatUI {
    
    switch (self.type) {
        case ReportCompanyInfoTypeBusinessPublish:{// 工商公示
            //创建头部view
            ReportCompanyInfoMainBaseHeaderView * header = [[ReportCompanyInfoMainBaseHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 555)];
            header.frame = CGRectMake(0, 0, SCREEN_WIDTH, [ReportCompanyInfoMainBaseHeaderView heightOfHeader]);
            self.tableView.tableHeaderView = header;
            
            // 创建cell
            [self creatGroupDataArray];
            
            break;
        }case ReportCompanyInfoTypeCompanyPublish:{//企业公示
            //创建头部view
            
            // 创建cell
            [self creatGroupDataArray];
            
            break;
            
        }case ReportCompanyInfoTypeOtherDepartment:{//其他部门
            
            break;
            
        }case ReportCompanyInfoTypeLawAssist:{// 司法协助
            
            break;
            
        }default:
            break;
    }
    
    
}


#pragma mark 创建view
-(void)creatGroupDataArray {
    if (self.type == ReportCompanyInfoTypeBusinessPublish) {//工商公示
        NSMutableArray *_titleDataArray = [NSMutableArray arrayWithCapacity:0];
        [_titleDataArray addObject:@"登记信息"]; //30
        [_titleDataArray addObject:@"备案信息"];
        [_titleDataArray addObject:@"动产抵押登记信息"];
        [_titleDataArray addObject:@"股权出质登记信息"];
        [_titleDataArray addObject:@"行政处罚信息"];
        [_titleDataArray addObject:@"经营异常信息"];
        [_titleDataArray addObject:@"严重违法信息"];
        [_titleDataArray addObject:@"抽查检查信息"];
         [self.dataSource removeAllObjects];
        for (int i=0 ; i<_titleDataArray.count; i++) {
            YJArrowItem *item = [YJArrowItem itemWithTitle:_titleDataArray[i] destVc:nil];
            __block typeof(self)  sself = self;
            item.option = ^(NSIndexPath *indexPath){
                        
                ReportCompanyInfoBusinessPublishVC  *vc = [[ReportCompanyInfoBusinessPublishVC alloc]init];
                vc.type = 30+i;// 30起
                
                [sself.navigationController pushViewController:vc animated:YES];
            };
          
            YJItemGroup *group = [[YJItemGroup alloc] init];
            group.groups = @[item];
            [self.dataSource addObject:group];
        }
        
        
    } else if ( self.type ==ReportCompanyInfoTypeCompanyPublish){// 企业公示
       
        NSMutableArray *_titleDataArray = [NSMutableArray arrayWithCapacity:0];
        [_titleDataArray addObject:@"股东及出资信息"]; //30
        [_titleDataArray addObject:@"股东及出资变更信息"];
        [_titleDataArray addObject:@"股权变更信息"];
        [_titleDataArray addObject:@"行政许可信息"];
        [_titleDataArray addObject:@"知识产权出质登记信息"];
        [_titleDataArray addObject:@"行政处罚信息"];
        [self.dataSource removeAllObjects];
        for (int i=0 ; i<_titleDataArray.count; i++) {
            YJArrowItem *item = [YJArrowItem itemWithTitle:_titleDataArray[i] destVc:nil];
            __block typeof(self)  sself = self;
            item.option = ^(NSIndexPath *indexPath){
                
                ReportCompanyInfoBusinessPublishVC  *vc = [[ReportCompanyInfoBusinessPublishVC alloc]init];
                vc.type = 40+i;// 40起
                
                [sself.navigationController pushViewController:vc animated:YES];
            };
            
            YJItemGroup *group = [[YJItemGroup alloc] init];
            group.groups = @[item];
            [self.dataSource addObject:group];
        }
        
    }
    
    
}




#pragma mark -
#pragma mark - UITableViewDataSource
#pragma mark section数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    switch (self.type) {
        case ReportCompanyInfoTypeBusinessPublish:{// 工商公示
            return self.dataSource.count;
            break;
            
        }case ReportCompanyInfoTypeCompanyPublish:{//企业公示
            return self.dataSource.count;
            break;
            
        }case ReportCompanyInfoTypeOtherDepartment:{//其他部门
            
            break;
            
        }case ReportCompanyInfoTypeLawAssist:{// 司法协助
            
            break;
            
        }default:
            break;
    }
    
    return 1;
    
}
#pragma mark row数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.type) {
        case ReportCompanyInfoTypeBusinessPublish:{// 工商公示
            YJItemGroup *group = self.dataSource[section];
            return group.groups.count;
            break;
            
        }case ReportCompanyInfoTypeCompanyPublish:{//企业公示
            YJItemGroup *group = self.dataSource[section];
            return group.groups.count;
            break;
            
        }case ReportCompanyInfoTypeOtherDepartment:{//其他部门
            
            break;
            
        }case ReportCompanyInfoTypeLawAssist:{// 司法协助
            
            break;
            
        }default:
            break;
    }
    
    return 0;
    
}

#pragma mark cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.type) {
        case ReportCompanyInfoTypeBusinessPublish:{// 工商公示
            YJMeCell *cell = [YJMeCell meCell:tableView];
            YJItemGroup *group = self.dataSource[indexPath.section];
            YJBaseItem *item = group.groups[indexPath.row];
            cell.item = item;
            
            if (group.groups.count-1 == indexPath.row) {
                UIView *separateLine1 = [[UIView alloc] init];
                separateLine1.frame = CGRectMake(0, 45.0-0.5, SCREEN_WIDTH, 0.5);
                separateLine1.backgroundColor = RGB_grayLine;
                
                [cell.contentView addSubview:separateLine1];
                
            }
            
            return cell;
            break;
            
        }case ReportCompanyInfoTypeCompanyPublish:{//企业公示
            YJMeCell *cell = [YJMeCell meCell:tableView];
            YJItemGroup *group = self.dataSource[indexPath.section];
            YJBaseItem *item = group.groups[indexPath.row];
            cell.item = item;
            
            if (group.groups.count-1 == indexPath.row) {
                UIView *separateLine1 = [[UIView alloc] init];
                separateLine1.frame = CGRectMake(0, 45.0-0.5, SCREEN_WIDTH, 0.5);
                separateLine1.backgroundColor = RGB_grayLine;
                
                [cell.contentView addSubview:separateLine1];
                
            }
            
            return cell;
            break;
            
        }case ReportCompanyInfoTypeOtherDepartment:{//其他部门
            
            break;
            
        }case ReportCompanyInfoTypeLawAssist:{// 司法协助
            
            break;
            
        }default:
            break;
    }
    
    return nil;
    
   
}
#pragma mark 头部title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (self.type) {
        case ReportCompanyInfoTypeBusinessPublish:{// 工商公示
            return [self.dataSource[section] headerTitle];
            break;
            
        }case ReportCompanyInfoTypeCompanyPublish:{//企业公示
            return [self.dataSource[section] headerTitle];
            break;
            
        }case ReportCompanyInfoTypeOtherDepartment:{//其他部门
            
            break;
            
        }case ReportCompanyInfoTypeLawAssist:{// 司法协助
            
            break;
            
        }default:
            break;
    }
    
    return nil;
}
#pragma mark 尾部title
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    switch (self.type) {
        case ReportCompanyInfoTypeBusinessPublish:{// 工商公示
            return [self.dataSource[section] footerTitle];
            break;
            
        }case ReportCompanyInfoTypeCompanyPublish:{//企业公示
            return [self.dataSource[section] footerTitle];
            break;
            
        }case ReportCompanyInfoTypeOtherDepartment:{//其他部门
            
            break;
            
        }case ReportCompanyInfoTypeLawAssist:{// 司法协助
            
            break;
            
        }default:
            break;
    }
    return 0;
}
#pragma mark 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.type) {
        case ReportCompanyInfoTypeBusinessPublish:{// 工商公示
            return 45.0;
            break;
            
        }case ReportCompanyInfoTypeCompanyPublish:{//企业公示
            return 45.0;
            break;
            
        }case ReportCompanyInfoTypeOtherDepartment:{//其他部门
            
            break;
            
        }case ReportCompanyInfoTypeLawAssist:{// 司法协助
            
            break;
            
        }default:
            break;
    }
    
    return 45.0;
}

#pragma mark 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (self.type) {
        case ReportCompanyInfoTypeBusinessPublish:{// 工商公示
            YJMeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if ([cell.item isKindOfClass:[YJArrowItem class]]) {
                YJArrowItem *item = (YJArrowItem *)cell.item;
                if (item.destVC) {
                    UIViewController *vc =[[item.destVC alloc] init];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
            } else if ([cell.item isKindOfClass:[YJTextItem class]]) {
                //        cell.textField.enabled = YES;
                [cell.textField becomeFirstResponder];
                
            }
            
            if (cell.item.option) {
                cell.item.option(indexPath);
            }
            
            break;
            
        }case ReportCompanyInfoTypeCompanyPublish:{//企业公示
            YJMeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if ([cell.item isKindOfClass:[YJArrowItem class]]) {
                YJArrowItem *item = (YJArrowItem *)cell.item;
                if (item.destVC) {
                    UIViewController *vc =[[item.destVC alloc] init];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
            } else if ([cell.item isKindOfClass:[YJTextItem class]]) {
                //        cell.textField.enabled = YES;
                [cell.textField becomeFirstResponder];
                
            }
            
            if (cell.item.option) {
                cell.item.option(indexPath);
            }
            
            break;
            
        }case ReportCompanyInfoTypeOtherDepartment:{//其他部门
            
            break;
            
        }case ReportCompanyInfoTypeLawAssist:{// 司法协助
            
            break;
            
        }default:
            break;
    }
    
    
}
#pragma mark header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}
#pragma mark - 其他
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}






/*
 
 switch (self.type) {
 case ReportCompanyInfoTypeBusinessPublish:{// 工商公示
 
 break;
 
 }case ReportCompanyInfoTypeCompanyPublish:{//企业公示
 
 break;
 
 }case ReportCompanyInfoTypeOtherDepartment:{//其他部门
 
 break;
 
 }case ReportCompanyInfoTypeLawAssist:{// 司法协助
 
 break;
 
 }default:
 break;
 }
 
 **/




@end
