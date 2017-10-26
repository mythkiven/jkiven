//
//  YJTaoBaoGoodsDetailVC.m
//  CreditPlatform
//
//  Created by yj on 16/10/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTaoBaoGoodsDetailVC.h"
#import "YJTaoBaoGoodsDetailCell.h"
#import "YJTaoBaoGoodsDetailFooferView.h"

@interface YJTaoBaoGoodsDetailVC ()



@end

@implementation YJTaoBaoGoodsDetailVC

//- (UIView *)titleView {
//    if (!_titleView) {
//        _titleView = [[UIView alloc] init];
//        _titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
//        UILabel *titleLB = [[UILabel alloc] init];
//        titleLB.text = self.title;
//        titleLB.textColor = RGB_white;
//        titleLB.textAlignment = NSTextAlignmentCenter;
//        titleLB.backgroundColor = RGB_navBar;
//        titleLB.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
//        
//        [_titleView addSubview:titleLB];
//        
//    }
//    return _titleView;
//}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买详情";
    
    self.tableView.backgroundColor = RGB_pageBackground;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 60, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.rowHeight = 150;
    
    if (self.orderDetails.items.count == 0) {
        [self.view addSubview:[YJNODataView NODataView]];
    } else {
//        [self setupHeaderView];
        
        [self setupFooterView];
    }

    
}
- (void)setupHeaderView {
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = RGB_white;
    bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB_lightGray;
    line.frame = CGRectMake(0, 0, SCREEN_WIDTH, .5);
    [bg addSubview:line];
    
    UILabel *lb = [[UILabel alloc] init];
    lb.text = @"购买商品信息";
    lb.font = Font18;
    lb.backgroundColor = [UIColor clearColor];
    lb.frame = CGRectMake(15, 0, SCREEN_WIDTH-30, 45);
    [bg addSubview:lb];
    
    self.tableView.tableHeaderView = bg;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    self.tableView.tableHeaderView = self.titleView;
    
    MYLog(@"-------viewWillAppear");
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [_titleLB removeFromSuperview];
//    self.view.transform = CGAffineTransformIdentity;
    MYLog(@"-------viewDidAppear");

}


- (void)setupFooterView {
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = RGB_pageBackground;
    bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);

    YJTaoBaoGoodsDetailFooferView *footerView = [YJTaoBaoGoodsDetailFooferView  taoBaoGoodsDetailFooferView];
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    [bg addSubview:footerView];
    footerView.logisticsInfo = self.orderDetails.taoBaoLogisticsInfo;
    
    self.tableView.tableFooterView = bg;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderDetails.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJTaoBaoGoodsDetailCell *cell = [YJTaoBaoGoodsDetailCell taoBaoGoodsDetailCellWithTableView:tableView];
    
    cell.orderItem = self.orderDetails.items[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    yjTaoBaoOrderItem *orderItem = self.orderDetails.items[indexPath.row];

    CGSize size = [NSString calculateTextSize:CGSizeMake(SCREEN_WIDTH-105, MAXFLOAT) Content:orderItem.itemName font:Font15];
    CGFloat h = (size.height <= 20) ? 20 :size.height;
    
    if (h > 20) {
        return 150 + h+5 -20;
    }
    
    return 150+10;
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
//    __weak typeof(self) weakSelf = self;

    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"取消" style:(UIPreviewActionStyleDestructive) handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
//        NSLog(@"-------%@",previewViewController);
    }];
    
    return @[action2];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
