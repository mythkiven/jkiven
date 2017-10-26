//
//  YJBaseSettingViewController.m
//  inZhua
//
//  Created by yj on 16/5/25.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "YJBaseSettingViewController.h"
#import "YJMeCell.h"
#import "YJTextItem.h"

@interface YJBaseSettingViewController ()<UIGestureRecognizerDelegate,UITextViewDelegate>

@end

@implementation YJBaseSettingViewController


- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.backgroundColor = YJColor(245, 245, 245);
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = 45.0;
    // 系统手势返回
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
#pragma mark--UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}


#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YJItemGroup *group = self.dataSource[section];
    
    return group.groups.count;
}


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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [self.dataSource[section] headerTitle];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    return [self.dataSource[section] footerTitle];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    YJMeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
//    YJItemGroup *group = self.dataSource[indexPath.section];
////    YJBaseItem *item = group.groups[indexPath.row];
//    
    return 45.0;
}

#pragma mark--UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YJMeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.item isKindOfClass:[YJArrowItem class]]) {
        YJArrowItem *item = (YJArrowItem *)cell.item;
        if (item.destVC) {
            
            
            UIViewController *vc =[[item.destVC alloc] init];
            
//            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"dddddd" style:(UIBarButtonItemStyleDone) target:self action:NULL];
            
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
        return 10;
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    //    __weak typeof(self) weakSelf = self;
    
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"取消" style:(UIPreviewActionStyleDestructive) handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    
    return @[action];
}

@end
