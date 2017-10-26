//
//  BaseViewController.h
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/2/13.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMZXDemoAPI.h"
// 自定一个
#import "LMZXLoadingReportBaseVC.h"

//// 数据回调
//typedef void(^LMZXSearchResultBlock)(int,LMZXSDKFunction,id);

//typedef  enum {
//    LMZXWebBusinessTypeTaobao = 0,
//    LMZXWebBusinessTypeJD    ,
//    LMZXWebBusinessTypeLinkedin  ,
//    LMZXWebBusinessTypeDidi  ,
//}LMZXWebBusinessType;
//




// 每个模块的入口 VC 的通用设置

@interface LMZXBaseViewController : UIViewController

///**模块类型*/
//@property (assign,nonatomic) LMZXWebBusinessType webBusinesstype;


//@property (nonatomic,copy) LMZXSearchResultBlock lmSearchResultBlock;

/** 当前查询的类型: 区分子类*/
@property (nonatomic, assign,readwrite) LMZXSearchItemType  searchItemType;


//////////// 用于接收 SDK 设置 //////////////////

// 首个 VC 的 左侧返回按钮
@property (strong,nonatomic) UIImage      *lmBackImg;
@property (strong,nonatomic) NSString      *lmBackTxt;

@property (assign,nonatomic) BOOL      bo;



/**
 *  主题色/导航条颜色
 */
@property (nonatomic,strong) UIColor *lmzxThemeColor;

/**
 *  确认按钮颜色(如果不设置,默认为主题色 lmzxThemeColor)
 */
@property (nonatomic,copy) UIColor *lmzxSureSearchBtnColor;


/**
 *  返回按钮文字\图片颜色,标题颜色
 */
@property (nonatomic,strong) UIColor *lmzxTitleColor;

/**
 *  查询页面协议文字颜色,和查询动画页面的动画颜色,文字颜色相同
 */
@property (nonatomic,strong) UIColor *lmzxProtocolTextColor;

/**
 *  提交按钮颜色
 */
@property (nonatomic,strong) UIColor *lmzxSubmitBtnColor;

/**
 *  页面背景颜色
 */
@property (nonatomic,strong) UIColor *lmzxPageBackgroundColor;



/**
 *  协议地址
 */
@property (nonatomic,copy) NSString *lmzxProtocolUrl;

/**
 *  协议名称
 */
@property (nonatomic,copy) NSString *lmzxProtocolTitle;


///**
// *  勾选框- normal
// */
//@property (nonatomic,copy) UIImage *lmzxProtocolImgNor;
//
///**
// *  勾选框- selected
// */
//@property (nonatomic,copy) UIImage *lmzxProtocolImgSec;


-(void)back;


@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;



@end
