//
//  CommonSearchBaseVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/11/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>


#define LM_RGB(r,g,b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]


////// 运营商,京东,淘宝,学信,等相似 VC 共用此基类1 /////


#import "LMZXFactoryView.h"


#import "LMZXBaseViewController.h"

#import "LMZXSearchCellModel.h"



#import "LMZXBaseSearchDataTool.h"

/** 点击查询报告 事件*/
typedef void(^ClickedReport)(id);

/** 勾选协议 事件 */
typedef void(^ClickedProtocol)(id);


@interface LMZXSearchBaseVC : LMZXBaseViewController <UITableViewDelegate,UITableViewDataSource>

/** 所有控制器间传递的查询参数 model */
@property (strong,nonatomic) LMZXQueryInfoModel *lmQueryInfoModel;


/**
 轮循请求
 */
@property (nonatomic, strong)     LMZXBaseSearchDataTool *searchtool;





@property (copy,nonatomic) ClickedReport            clickedReport;
@property (copy,nonatomic) ClickedProtocol          clickedProtocol;

//////////////////////// 子类自定义UI //////////////////////////////////////////////




/** tableView: 输入框 Cell ,子类需要载入数据源方法 */
@property (nonatomic,strong,readwrite) UITableView *tableView;

/** tableView cell 数据源*/
@property (strong,nonatomic,readwrite) NSMutableArray   *commonCellData;

/**底部提示文字*/
@property (strong,nonatomic,readonly) UILabel       *markLabel;

/**勾选按钮*/
@property (strong,nonatomic,readonly) UIButton      *btnSelected;

/**查询报告按钮*/
@property (strong,nonatomic,readwrite) UIButton     *btnSearch;


@property (nonatomic, strong) UITextField   *zeroTextField;
//手机号 账号 第1个输入框
@property (nonatomic, strong) NSString      *firstTextField;
//第2个输入框 密码
@property (nonatomic, strong) NSString      *twoTextField;
//第3个输入框  客服密码.真实姓名。其他

@property (nonatomic, strong) NSString      *threeTextField;



/**是否展示协议:用于基类中判别 不展示协议的子控制器*/
@property (assign,nonatomic,readwrite) BOOL     showProtocol;



/** 用于判断首个 cell 是否为二级页面入口:城市\公司选择 默认NO */
@property (nonatomic, assign,readwrite) BOOL    showAllowCell;

/** 总共需要校验的数量 */
@property (nonatomic, assign) NSInteger         verifyNum;

/**每个tview的最大文宽 */
@property (assign,nonatomic,readwrite) CGFloat      titleWidth;


// 解决页面退出,键盘收缩的延时问题
@property (assign,nonatomic) BOOL      isVCOut;



/** 子类结束编辑之前,需要实现,用于父类中统一获取输入框信息.*/
- (void)textFieldTextDidEndEditingSuper:(NSNotification *)noti;


//////////// 如果需要重写,可使用如下:


/**底部view:除了输入框 Cell 之外的底部视图*/
@property (nonatomic,strong,readwrite) UIView   *bottomView;


@property (strong,nonatomic) NSString *protocolTitle;

//
//*是否为手机,单独校验:获取键盘/
//@property (nonatomic, assign) BOOL  isPhone;

@end











