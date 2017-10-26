//
//  JLoadingManagerView.h
//  JCombineLoadingAnimation
//
//  Created by https://github.com/mythkiven/ on 15/01/18.
//  Copyright © 2015年 mythkiven. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 
 成功退出模式:
     阶段1 10s,进度为20%,               [主提示: "提交中..."         副提示: 无]
     阶段2 40s,进度为99%,                [主提示变更为: "获取数据中..." 副提示: 无]
     阶段3 进度为99%(超50s,仍未查询成功),  [主提示: "获取数据中..."     副提示: "该过程可能持续1-3分钟,请耐心等待."]
     阶段3 获取到数据.                   [主提示: "成功获取数据"     副提示: "无"]
  eg.
     在15%,登录成功,则动画进入阶段2:时间为40s,进度为15%-99%.                 [主提示变更为: "获取数据中..."  副提示: "登录成功,可退出继续查询"]
     在30%,登录成功,则动画进入阶段2:时间为(99-30)*40/(99-20)s,进度为30%-99%. [主提示变更为: "获取数据中..."  副提示: "登录成功,可退出继续查询"]
     在18%,查询成功,则动画快进到100%:时间为1s,进度为18%-100%. [主提示: "查询成功..." 副提示: 无]
     在40%,查询成功,则动画快进到100%:时间为1s,进度为40%-100%. [主提示变更为: "查询成功..." 副提示: 无]
 
 
 登录退出模式:
     阶段1 5s,进度为50%, [主提示: "提交中..."         副提示: 无]
     阶段2 5s,进度为99%. [主提示: "提交中..."         副提示: 无]
     阶段3 进度为99%. [主提示: "提交中..."         副提示: "该过程可能持续1-3分钟,请耐心等待."]
     阶段3 登录成功.                   [主提示: "登录成功"     副提示: "无"]
 
     在任意阶段,如果登录成功,则从当前进度,快进到100%,时间为1s.然后提示登录成功. [主提示变更为: "登录成功..." 副提示: "登录成功,可以退出继续查询" ]
 
 
 */

typedef void (^jLoadingCompleteBlock)(void);





@interface LMZXLoadingManagerView : UIView

// 登录成功   用于改变文字状态
@property (nonatomic,assign) BOOL isLoginSuccess;


// 如果不配置,就是用默认的配置.有本类自行管理.

// 1阶段时长
@property (nonatomic,assign) CGFloat LoginTime;
// 2阶段时长
@property (nonatomic,assign) CGFloat checkDataTime;
// 1阶段进度 整数
@property (nonatomic,assign) CGFloat LoginValue;










/** 开始动画 */
-(void)beginAnimationCompleteBlock:(jLoadingCompleteBlock)completeblock;
/** 暂停之后,重新动画 */
-(void)reBeginAnimationCompleteBlock:(jLoadingCompleteBlock)completeblock;
/** 暂停动画 */
-(void)endAnimation;

/** 查询成功  加载数据的动画,用于快进到100% */
-(void)successAnimation:(jLoadingCompleteBlock)completeblock;


/** 登录成功   成功加载数据的动画,用于快进到100% 
 
 不用设置 isLoginSuccess =YES */
-(void)loginSuccessAnimation:(jLoadingCompleteBlock)completeblock;




@end
