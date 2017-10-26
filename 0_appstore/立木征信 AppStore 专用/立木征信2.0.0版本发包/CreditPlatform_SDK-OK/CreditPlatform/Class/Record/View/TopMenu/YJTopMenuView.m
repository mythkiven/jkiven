//
//  YJTopMenuView.m
//  顶部菜单
//
//  Created by yj on 16/7/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTopMenuView.h"
#import "YJTopMenuPullView.h"

#import "YJTabBarController.h"

// 改成可定义
//#define kItemBtnWidth (SCREEN_WIDTH / 4.5)


@interface YJTopMenuView ()

/**
 *  用于显示所有的item
 */
@property (nonatomic, weak) UIScrollView *listTabBar;
/**
 *  选中item的背景View
 */
@property (nonatomic, weak) UIView *btnBgView;
/**
 *  当前选中的item按钮
 */
@property (nonatomic, weak) UIButton *currentSelectedBtn;

/**
 *  当前选中的滚动条
 */
@property (nonatomic, weak) UIView *scrollLine;

/**
 *  装有所有item的数组
 */
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, assign) CGFloat currentOffsetX;

@end

@implementation YJTopMenuView
{
    // 宽度
    CGFloat kItemBtnWidth;
    // 显示的个数
    CGFloat kItemBtnShow;
    // 总的个数
    CGFloat kItemBtnALL;
    
    UIView *separateLine;
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        _items = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    
    return self;
}


- (void)initView{
    
    //设置滚动的listTabBar
    UIScrollView *listTabBar = [[UIScrollView alloc] init];
    listTabBar.showsHorizontalScrollIndicator = NO;
    self.listTabBar = listTabBar;
    [self addSubview:self.listTabBar];
    
    // 分割线
    separateLine = [[UIView alloc] init];
    separateLine.backgroundColor = RGB_grayLine;
    separateLine.frame = CGRectMake(0, kMenuHeight-.5, SCREEN_WIDTH, .5);
    [self addSubview:separateLine];
    
    // 滚动条
    UIView *scrollLine = [[UIView alloc] init];
    scrollLine.backgroundColor = RGB_navBar;
    scrollLine.frame = CGRectMake(0, kMenuHeight-2, kItemBtnWidth, 2);
    [listTabBar addSubview:scrollLine];
 
    self.scrollLine = scrollLine;
   // 设置默认
    if (iPhone5|iPhone4s) {
        kItemBtnShow = 4;
    } else {
        kItemBtnShow= 4;
    }
    
    
    
    UIView *whiteV = [[UIView alloc] init];
    whiteV.backgroundColor = [UIColor whiteColor];
    whiteV.frame = CGRectMake(self.width - 15, 0, 15, 40);
    [self addSubview:whiteV];
    
    // 右侧添加更多菜单按钮
    UIButton *showBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    showBtn.frame = CGRectMake(self.width - 35 - 15, 0, 35, 40);
    [showBtn setBackgroundImage:[UIImage imageNamed:@"record_cover"] forState:UIControlStateNormal];
     [showBtn setBackgroundImage:[UIImage imageNamed:@"record_cover"] forState:UIControlStateHighlighted];
    [showBtn setImage:[UIImage imageNamed:@"record_open"] forState:(UIControlStateNormal)];
    [showBtn setImage:[UIImage imageNamed:@"record_open"] forState:(UIControlStateHighlighted)];
    [showBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    [self addSubview:showBtn];
    
    [showBtn addTarget:self action:@selector(showMoreMenu) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}


/**
 *  重写属性currentItemIndex的setter方法
 */
- (void)setCurrentItemIndex:(NSInteger)currentItemIndex{
    
    _currentItemIndex = currentItemIndex;
    
    separateLine.frame = CGRectMake(0, kMenuHeight-.5, _items.count*kItemBtnWidth, .5);
    
    UIButton *button = _items[currentItemIndex];
    
    [self settingSelectedButton:button];
    

    
    [UIView animateWithDuration:0.25 animations:^{
        if (currentItemIndex <= 1) {
            self.listTabBar.contentOffset = CGPointMake(0, 0);
        } else if (currentItemIndex > 1 && currentItemIndex < _items.count - 2) {
            self.listTabBar.contentOffset = CGPointMake(kItemBtnWidth*(currentItemIndex-1), 0);
        } else if (currentItemIndex >= _items.count - 2) {
            self.listTabBar.contentOffset = CGPointMake(kItemBtnWidth * (_items.count- 1 - 3), 0);
        }
    }];
    
    [self scrollLineAnimation];
}

/**
 *  重写属性setItemsTitle的setter方法(在控制器中调用itemsTitle的setter方法是就会来到这里->self.itemsTitle=)
 */
- (void)setItemsTitle:(NSArray *)itemsTitle{
    kItemBtnALL = itemsTitle.count;
    _itemsTitle = itemsTitle;
    
    CGFloat rightMargin = 35 + 15; // 45为按钮宽度
    if (self.itemsTitle.count<=4) {
        if (iPhone5|iPhone4s) {
            kItemBtnShow = 3.3;
        } else {
            kItemBtnShow= 3.5;
        }
    }
    CGFloat widthL=0;
    //设置宽度
    if (_itemWidth) {
        widthL =(SCREEN_WIDTH -itemsTitle.count*_itemWidth)/(itemsTitle.count+1);
        kItemBtnWidth = _itemWidth;
        self.scrollLine.frame = CGRectMake(widthL, kMenuHeight-2, kItemBtnWidth, 2);
        
        
    }else{
        kItemBtnWidth= ((SCREEN_WIDTH-rightMargin) / kItemBtnShow);
        self.scrollLine.frame = CGRectMake(0, kMenuHeight-2, kItemBtnWidth, 2);
        
        
    }
    CGFloat buttonX = 0;
    CGFloat buttonW = kItemBtnWidth+widthL;
    
    int count = (int)itemsTitle.count;
    for (int i = 0; i < count; i ++) {
        buttonX = i * buttonW;
        //        if (i > 0) {
        //            buttonX -= 0.5 * i;
        //        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //取得item的标题
        NSString *title = _itemsTitle[i];
        if (iPhone5|iPhone4s) {
            button.titleLabel.font = Font13;
        } else {
            button.titleLabel.font = Font15;
        }
        
        button.frame = CGRectMake(buttonX, 0, buttonW , kMenuHeight);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:RGB_blueText forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemsDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            [self itemsDidClick:button];
            
        }
        [self.listTabBar addSubview:button];
        
        [self.items addObject:button];
        
    }
    
    self.listTabBar.contentSize = CGSizeMake(buttonW * count+rightMargin, 0);
    
    
}
//- (void)setItemsTitle:(NSArray *)itemsTitle{
//    kItemBtnALL = itemsTitle.count;
//    _itemsTitle = itemsTitle;
//    if (self.itemsTitle.count<=4) {
//        if (iPhone5|iPhone4s) {
//            kItemBtnShow = 3.3;
//        } else {
//            kItemBtnShow= 3.5;
//        }
//    }
//    CGFloat widthL=0;
//    //设置宽度
//    if (_itemWidth) {
//        widthL =(SCREEN_WIDTH -itemsTitle.count*_itemWidth)/(itemsTitle.count+1);
//        kItemBtnWidth = _itemWidth;
//        self.scrollLine.frame = CGRectMake(widthL, kMenuHeight-2, kItemBtnWidth, 2);
//        
//
//    }else{
//        kItemBtnWidth= (SCREEN_WIDTH / kItemBtnShow);
//        self.scrollLine.frame = CGRectMake(0, kMenuHeight-2, kItemBtnWidth, 2);
//        
//
//    }
//    CGFloat buttonX = 0;
//    CGFloat buttonW = kItemBtnWidth+widthL;
//
//    int count = (int)itemsTitle.count;
//    for (int i = 0; i < count; i ++) {
//        buttonX = i * buttonW;
////        if (i > 0) {
////            buttonX -= 0.5 * i;
////        }
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        //取得item的标题
//        NSString *title = _itemsTitle[i];
//        if (iPhone5|iPhone4s) {
//            button.titleLabel.font = Font15;
//        } else {
//            button.titleLabel.font = Font16;
//        }
//        
//        button.frame = CGRectMake(buttonX, 0, buttonW , kMenuHeight);
//        [button setTitle:title forState:UIControlStateNormal];
//        [button setTitleColor:RGB_blueText forState:UIControlStateSelected];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(itemsDidClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//        if (i == 0) {
//            [self itemsDidClick:button];
//
//        }
//        [self.listTabBar addSubview:button];
//        
//        [self.items addObject:button];
//        
//    }
//    
//    self.listTabBar.contentSize = CGSizeMake(buttonW * count, 0);
//
//    
//}

/**
 *  item按钮的点击事件
 */
- (void)itemsDidClick:(UIButton *)button{
    
    [self settingSelectedButton:button];
    
    NSInteger index = [_items indexOfObject:button];
    
    if ([self.delegate respondsToSelector:@selector(topMenuView:didSelectedItemIndex:)]) {
        
        [self.delegate topMenuView:self didSelectedItemIndex:index];
    }
    
    [self scrollLineAnimation];
}


/**
 *  设置button为选中状态（主要是改变选中按钮的title颜色）
 */
- (void)settingSelectedButton:(UIButton *)button{

    self.currentSelectedBtn.selected = NO;
    button.selected = YES;
    self.currentSelectedBtn = button;
}

-(void)setItemWidth:(CGFloat)itemWidth{
    _itemWidth = itemWidth;
    kItemBtnWidth = _itemWidth;
}

- (void)scrollLineAnimation {
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollLine.x = _currentItemIndex * self.scrollLine.width;
    }];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.listTabBar.frame = CGRectMake(0, 0, SCREEN_WIDTH,kMenuHeight);
}


#pragma mark --显示更多菜单
- (void)showMoreMenu {
    
    
    // 弹出菜单
//    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    YJTopMenuPullView *pullView = [YJTopMenuPullView topMenuPullView];
    pullView.frame = _contentView.bounds;
    pullView.selectedIndex = (int)_currentItemIndex;
    [_contentView addSubview:pullView];
    // 处理回调
    __weak typeof(self) weakSelf = self;
    pullView.selectedIndexBlock = ^(int index){
        [weakSelf itemsDidClick:_items[index]];
    };
    
    pullView.transform = CGAffineTransformTranslate(pullView.transform, 0, -pullView.frame.size.height);
    pullView.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        // 1.scrollView从上面 -> 下面
        pullView.transform = CGAffineTransformIdentity;
        pullView.alpha = 1;
        
        // 隐藏tabbar
        YJTabBarController *tabBarVc = [YJTabBarController shareTabBarVC];
        tabBarVc.tabBar.alpha = 0;
        
        
      
    }];
    
    
    
    MYLog(@"====显示更多菜单");
}



#pragma mark---对外暴露

- (void)setProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex {
    
    UIButton *sourceBtn = self.items[sourceIndex];
    UIButton *targetBtn = self.items[targetIndex];
    
    
    // 2.处理滑块的逻辑
    CGFloat moveTotalX = targetBtn.frame.origin.x - sourceBtn.frame.origin.x;
    CGFloat moveX = moveTotalX * progress;
    
    CGRect frame = self.scrollLine.frame;
    frame.origin.x = sourceBtn.frame.origin.x + moveX;
    self.scrollLine.frame = frame;
    
    //    // 3.颜色的渐变
//    [sourceBtn setTitleColor:RGB(48 * (1 -  progress), 113 * (1 -  progress), 242 * (1 -  progress)) forState:(UIControlStateNormal)];
//    
//    [targetBtn setTitleColor:RGB(48 * (1 +  progress), 113 * (1 +  progress), 242 * (1 +  progress)) forState:(UIControlStateNormal)];
    
    MYLog(@"sourceIndex=%d,=====targetIndex=%d",sourceIndex,targetIndex);
    
    
}





@end
