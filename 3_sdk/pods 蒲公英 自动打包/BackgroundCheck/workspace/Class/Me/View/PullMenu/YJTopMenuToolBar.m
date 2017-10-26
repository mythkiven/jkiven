//
//  YJTopMenuToolBar.m
//  下拉菜单
//
//  Created by yj on 16/9/21.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTopMenuToolBar.h"
#import "YJTopMenuButton.h"
#import "YJBottomMenuView.h"
@interface YJTopMenuToolBar ()
{
    YJTypeMenu *_typeMenu;
//    YJDateMenu *_dateMenu;
    YJBottomMenuView *_showingMenu; // 正在展示的底部菜单
    
    
    UIView *_topLine;
    UIView *_bottomLine;
    UIView *_midLine1;
    UIView *_midLine2;
    
    YJTopMenuButton *_typeBtn;
    YJTopMenuButton *_dateBtn;
    YJTopMenuButton *_childAccountBtn;
    

}
@property (nonatomic, weak) UIButton *currentBtn;

@end

@implementation YJTopMenuToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
        
        
    }
    return self;
}

- (void)setupSubviews {
    // 上下分割线
    if (!_topLine) {
        _topLine = [self line];
    }
    
    if (!_bottomLine) {
        _bottomLine = [self line];
    }
    

    if (!_midLine1) {
        _midLine1 = [self line];
    }
    

    
    // 按钮
    if (!_typeBtn) {
        _typeBtn = [self menuBtnWithTitle:@"类型"];
        _typeBtn.tag = YJTopMenuToolBarFormType;

    }
    
    if (!_dateBtn) {
        _dateBtn = [self menuBtnWithTitle:@"时间"];
        _dateBtn.tag = YJTopMenuToolBarFormDate;
        
    }
    
    

}

- (void)setIsHasChildAccount:(BOOL)isHasChildAccount {
    _isHasChildAccount = isHasChildAccount;
    
    
    [self setupSubviews];
    
    if (isHasChildAccount) {
        
        if (!_midLine2) {
            _midLine2 = [self line];
        }
        
        // 按钮
        if (!_childAccountBtn) {
            _childAccountBtn = [self menuBtnWithTitle:@"子账号"];
            _childAccountBtn.tag = YJTopMenuToolBarFormChildAccount;
            
        }
            
      
        

        
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _topLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    _bottomLine.frame = CGRectMake(0, kTopMenuToolBarH-.5, SCREEN_WIDTH, 0.5);
    
    CGFloat btnW = 0;
    if (self.isHasChildAccount) {
        btnW = SCREEN_WIDTH / 3;
        
    } else {
        btnW = SCREEN_WIDTH*.5;
    }
    
    _midLine1.frame = CGRectMake(btnW, 5, .5, kTopMenuToolBarH-10);
    _midLine2.frame = CGRectMake(btnW * 2, 5, .5, kTopMenuToolBarH-10);

    _typeBtn.frame = CGRectMake(0, 0, btnW, kTopMenuToolBarH);
    _dateBtn.frame = CGRectMake(btnW , 0, btnW, kTopMenuToolBarH);
    
    _childAccountBtn.frame = CGRectMake(btnW*2, 0, btnW, kTopMenuToolBarH);


    
}


- (YJTopMenuButton *)menuBtnWithTitle:(NSString *)title {
    YJTopMenuButton *btn = [[YJTopMenuButton alloc] init];

    [btn setTitle:title forState:(UIControlStateNormal)];
    
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    btn.backgroundColor = [UIColor clearColor];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(btnClcik:) forControlEvents:(UIControlEventTouchUpInside)];
    return btn;
}



- (void)btnClcik:(YJTopMenuButton *)item {
    // 1.控制选中状态
    self.currentBtn.selected = NO;
    if (self.currentBtn == item) {
        self.currentBtn = nil;
        
        // 隐藏底部菜单
        [self hideBottomMenu];
    } else {
        item.selected = YES;
        self.currentBtn = item;
        
        // 显示底部菜单
        [self showBottomMenu:item];
    }
    
}

#pragma mark 隐藏底部菜单
- (void)hideBottomMenu
{
    
    [_showingMenu hide];
    _showingMenu = nil;
}

#pragma mark 显示底部菜单
- (void)showBottomMenu:(YJTopMenuButton *)item
{

    
    
     BOOL animted = _showingMenu == nil;
    if (_showingMenu == _dateMenu) {
        [_dateMenu hide];
    }
    
    [_showingMenu removeFromSuperview];
    
    if (item.tag == YJTopMenuToolBarFormType) {
        if (_typeMenu == nil) {
            _typeMenu = [[YJTypeMenu alloc] init];
            _typeMenu.menuType = self.menuType;
        }

        
        _showingMenu = _typeMenu;
    } else if (item.tag == YJTopMenuToolBarFormDate) {
        if (_dateMenu == nil) {
            _dateMenu = [[YJDateMenu alloc] initWithToday:self.isHasToday];
            
        }

        _showingMenu = _dateMenu;
        
    }else if (item.tag == YJTopMenuToolBarFormChildAccount) {
        if (_ChildAccountMenu == nil) {
            _ChildAccountMenu = [[YJChildAccountListMenuView alloc] init];
            
        }
        
        _showingMenu = _ChildAccountMenu;
        
    }
    
    
    _showingMenu.frame = CGRectMake(0, kTopMenuToolBarH, _contentView.bounds.size.width, _contentView.bounds.size.height);
    __weak typeof(self) weakSelf = self;
    
    _showingMenu.hideBlock = ^ {
        weakSelf.currentBtn.selected = NO;
        weakSelf.currentBtn = nil;
        
        _showingMenu = nil;
        
        
        
    };
    
    [_contentView insertSubview:_showingMenu belowSubview:self];
    

    if (animted) {
        [_showingMenu show];

    }
    
}


- (UIView *)line {
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB_grayLine;
    [self addSubview:line];
    
    return line;
}

@end
