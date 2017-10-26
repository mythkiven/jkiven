//
//  ReportCompanyInfoCompanyPublishVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ReportCompanyInfoMCompanyPublishVC.h"

#import "ReportCompanyInfoBusinessPublishVC.h"

#import "YJBaseItem.h"
#import "YJItemGroup.h"
#import "YJArrowItem.h"
#import "YJSearchConditionModel.h"
#import "YJMeCell.h"
#import "YJTextItem.h"

@interface ReportCompanyInfoMCompanyPublishVC ()<UIViewControllerPreviewingDelegate,UIGestureRecognizerDelegate,UITextViewDelegate>


@end

@implementation ReportCompanyInfoMCompanyPublishVC




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
    
}


#pragma mark 创建view
-(void)creatGroupDataArray {
    
        
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




#pragma mark -
#pragma mark - UITableViewDataSource
#pragma mark section数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
    
    
}
#pragma mark row数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YJItemGroup *group = self.dataSource[section];
            return group.groups.count;
    
    
}

#pragma mark cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
   
    
    
}
#pragma mark 头部title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataSource[section] headerTitle];
    
}
#pragma mark 尾部title
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [self.dataSource[section] footerTitle];
    
}
#pragma mark 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   return 45.0;
    
}

#pragma mark 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

