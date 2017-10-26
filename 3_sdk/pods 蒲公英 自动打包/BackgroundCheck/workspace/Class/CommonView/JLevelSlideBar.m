//
//  JLevelSlideBar.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "JLevelSlideBar.h"

@interface JLevelSlideBar ()

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

@implementation JLevelSlideBar
{
    // 宽度
    CGFloat kItemBtnWidth;
    // 显示的个数
    CGFloat kItemBtnShow;
    // 总的个数
    CGFloat kItemBtnALL;
    
    UIView *separateLine;
    
    CGFloat widthL;
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
//    self.listTabBar.backgroundColor =RGB_red;
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
        kItemBtnShow= 4.5;
    }
    
}


/**
 *  重写属性currentItemIndex的setter方法
 */
- (void)setCurrentItemIndex:(NSInteger)currentItemIndex{
    
    _currentItemIndex = currentItemIndex;
    
    separateLine.frame = CGRectMake(0, kMenuHeight-.5, _items.count*kItemBtnWidth, .5);
    
    UIButton *button = _items[currentItemIndex];
    
    [self settingSelectedButton:button];
    
    CGFloat listTabBatF = kItemBtnWidth;
    
    CGFloat rightButtonMaxX = CGRectGetMaxX(button.frame);
    CGFloat offsetX = rightButtonMaxX - listTabBatF;
    CGFloat oldsetx = (self.listTabBar.contentOffset).x;
    NSInteger num =self.itemsTitle.count;
    
    //多个数据展示 定位在第二个位置
    if (num>=5 && (rightButtonMaxX > listTabBatF)) {
        if ((_currentItemIndex < self.itemsTitle.count )) {
            if (offsetX < (kItemBtnALL-kItemBtnShow)*kItemBtnWidth) {//容差0 显示全
                offsetX = offsetX -kItemBtnWidth*0.5;
                [self.listTabBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            } else if ((offsetX == (kItemBtnALL-kItemBtnShow)*kItemBtnWidth)|(oldsetx  <  (kItemBtnALL-kItemBtnShow)*kItemBtnWidth)) {
                offsetX = (kItemBtnALL-kItemBtnShow)*kItemBtnWidth;
                [self.listTabBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            }
        }else if (oldsetx<=(self.itemsTitle.count/2)*kItemBtnWidth &&(_currentItemIndex >= num - 3)) {
            [self.listTabBar setContentOffset:CGPointMake((num-2)*kItemBtnWidth-kItemBtnWidth-kMenuWidth/(kItemBtnShow-0.0), 0) animated:YES];
        }
        // 4个数据展示
    }else if (num<5 && (rightButtonMaxX > listTabBatF)) {
        if (_currentItemIndex>=1 &&(_currentItemIndex < self.itemsTitle.count - 1) &&(_currentItemIndex < num - 2)) {
            offsetX = offsetX -kItemBtnWidth*0.5;
            [self.listTabBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        }
        if (offsetX < (kItemBtnALL-kItemBtnShow)*kItemBtnWidth) {//容差0 显示全
            offsetX = offsetX -kItemBtnWidth*0.5;
            [self.listTabBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            
        } else if ((offsetX == (kItemBtnALL-kItemBtnShow)*kItemBtnWidth)|(oldsetx  <  (kItemBtnALL-kItemBtnShow)*kItemBtnWidth)) {
            offsetX = (kItemBtnALL-kItemBtnShow)*kItemBtnWidth;
            [self.listTabBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            
        }
        
    }else{
        [self.listTabBar setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    [self scrollLineAnimation];
}

/**
 *  重写属性setItemsTitle的setter方法(在控制器中调用itemsTitle的setter方法是就会来到这里->self.itemsTitle=)
 */
- (void)setItemsTitle:(NSArray *)itemsTitle{
    kItemBtnALL = itemsTitle.count;
    _itemsTitle = itemsTitle;
    if (self.itemsTitle.count<=4) {
        if (iPhone5|iPhone4s) {
            kItemBtnShow = 3.3;
        } else {
            kItemBtnShow= 3.5;
        }
    }
    
    //设置宽度
    if (_itemWidth) {
        widthL =(SCREEN_WIDTH -itemsTitle.count*_itemWidth)/(itemsTitle.count+1);
        kItemBtnWidth = _itemWidth;
        self.scrollLine.frame = CGRectMake(widthL, kMenuHeight-2, kItemBtnWidth, 2);
        [self bringSubviewToFront:self.scrollLine];
    }else{
        kItemBtnWidth= (SCREEN_WIDTH / kItemBtnShow);
        self.scrollLine.frame = CGRectMake(0, kMenuHeight-2, kItemBtnWidth, 2);
        
    }
    CGFloat buttonX = 0;
    CGFloat buttonW = kItemBtnWidth;
    
    int count = (int)itemsTitle.count;
    for (int i = 0; i < count; i ++) {
        buttonX = i * (buttonW+widthL)+widthL;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //取得item的标题
        NSString *title = _itemsTitle[i];
        if (iPhone5|iPhone4s) {
            button.titleLabel.font = Font15;
        } else {
            button.titleLabel.font = Font16;
        }
//        button.backgroundColor =RGB_yellow;
        button.frame = CGRectMake(buttonX, 0, buttonW , kMenuHeight);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:RGB_blueText forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemsDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
//        if (i == 0) {
//            [self itemsDidClick:button];
//        }
        
        [self.listTabBar addSubview:button];
        
        [self.items addObject:button];
        
    }
    
    self.listTabBar.contentSize = CGSizeMake(buttonW * count, 0);
    
    
}

/**
 *  item按钮的点击事件
 */
- (void)itemsDidClick:(UIButton *)button{
    
    [self settingSelectedButton:button];
    
    NSInteger index = [_items indexOfObject:button];
    
    if ([self.delegate respondsToSelector:@selector(jLevelSlideBar:didSelectedItemIndex:)]) {
        _currentItemIndex = index;
        [self.delegate jLevelSlideBar:self didSelectedItemIndex:index];
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
        self.scrollLine.x = _currentItemIndex * (self.scrollLine.width +widthL)+widthL;
    }];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.listTabBar.frame = CGRectMake(0, 0, SCREEN_WIDTH,kMenuHeight);
}



@end
