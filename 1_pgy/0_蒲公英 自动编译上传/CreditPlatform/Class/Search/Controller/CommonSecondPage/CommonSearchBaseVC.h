//
//  CommonSearchBaseVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/11/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonSearchCellModel.h"
#import "CommonSearchSortModel.h"

#import "ListHookVC.h"
#import "ListHookModel.h"

#import "YJSearchConditionModel.h"
/** 点击查询报告*/
typedef void(^ClickedReport)(id);

/** 勾选协议*/
typedef void(^ClickedProtocol)(id);


@interface CommonSearchBaseVC : UIViewController <UITableViewDelegate,UITableViewDataSource>

/** */
@property (nonatomic,strong,readwrite) UITableView *tableView;

@property (copy,nonatomic) ClickedReport            clickedReport;
@property (copy,nonatomic) ClickedProtocol          clickedProtocol;



/**数据源*/
@property (strong,nonatomic,readwrite) NSMutableArray   *commonCellData;
 


/**装协议的url*/
@property (strong,nonatomic,readwrite) NSArray          *protocolData;
/**装协议的title*/
@property (strong,nonatomic,readwrite) NSArray          *protocolTitleData;


/**类型*/
@property (nonatomic, assign,readwrite) SearchItemType  searchItemType;


/**头部view*/
@property (nonatomic,strong,readwrite) UIView   *HeaderView;
/**底部view*/
@property (nonatomic,strong,readwrite) UIView   *bottomView;


/**展示协议*/
@property (assign,nonatomic,readwrite) BOOL     showProtocol;
//是否为手机，单独校验
@property (nonatomic, assign) BOOL  isPhone;
/**展示城市、公司选择等allowCell 默认NO*/
@property (nonatomic, assign,readwrite) BOOL    showAllowCell;


//总共需要校验的数量
@property (nonatomic, assign) NSInteger         verifyNum;




/**底部提示文字*/
@property (strong,nonatomic,readonly) UILabel       *markLabel;

/**勾选按钮*/
@property (strong,nonatomic,readonly) UIButton      *btnSelected;
/**查询报告按钮*/
@property (strong,nonatomic,readwrite) UIButton     *btnSearch;


/**每个tview的最大文宽 */
@property (assign,nonatomic,readwrite) CGFloat      titleWidth;




@property (nonatomic, strong) UITextField   *zeroTextField;

@property (nonatomic, strong) NSString      *firstTextField;//手机号 账号 第1个输入框
@property (nonatomic, strong) NSString      *twoTextField;//第2个输入框 密码
@property (nonatomic, strong) NSString      *threeTextField;//第3个输入框  客服密码.真实姓名。其他

/** */
- (void)textFieldTextDidEndEditingSuper:(NSNotification *)noti;
@end











