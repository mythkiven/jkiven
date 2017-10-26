//
//  YJTaoBaoModel.h
//  CreditPlatform
//
//  Created by yj on 16/10/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
/**************1.基本信息***********/
@interface YJTaoBaoBasicInfo : NSObject

/**
 *  用户名
 */
@property (nonatomic, copy) NSString *username;


/**
 *  昵称
 */
@property (nonatomic, copy) NSString *nickName;
/**
 *  性别
 */
@property (nonatomic, copy) NSString *gender;
/**
 *  出生日期
 */
@property (nonatomic, copy) NSString *birthday;

/**
 *  真实姓名
 */
@property (nonatomic, copy) NSString *realName;

/**
 *  身份证
 */
@property (nonatomic, copy) NSString *identityNo;

/**
 *  认证渠道
 */
@property (nonatomic, copy) NSString *identityChannel;
/**
 *  是否实名认证（已认证、未认证）
 */
@property (nonatomic, copy) NSString *identityStatus;
/**
 *  登录邮箱
 */
@property (nonatomic, copy) NSString *email;

/**
 *  绑定手机
 */
@property (nonatomic, copy) NSString *mobile;

/**
 *  会员等级
 */
@property (nonatomic, copy) NSString *vipLevel;

/**
 *  成长值
 */
@property (nonatomic, copy) NSString *growthValue;

/**
 *  信用积分
 */
@property (nonatomic, copy) NSString *creditScore;
/**
 *  好评率
 */
@property (nonatomic, copy) NSString *favorableRate;
/**
 *  安全等级
 */
@property (nonatomic, copy) NSString *securityLevel;



@end

/**************2.绑定的支付宝信息***********/
@interface YJTaoBaoAlipayInfo : NSObject

/**
 *  支付账户名
 */
@property (nonatomic, copy) NSString *username;


/**
 *  绑定邮箱
 */
@property (nonatomic, copy) NSString *email;
/**
 *  绑定手机
 */
@property (nonatomic, copy) NSString *mobile;
/**
 *  实名认证姓名
 */
@property (nonatomic, copy) NSString *realName;

/**
 *  实名认证省份证号
 */
@property (nonatomic, copy) NSString *identityNo;


/**
 *  实名认证状态
 */
@property (nonatomic, copy) NSString *identityStatus;


/**
 *  账户余额
 */
@property (nonatomic, copy) NSString *accBal;
/**
 *  余额宝余额
 */
@property (nonatomic, copy) NSString *yuebaoBal;
/**
 *  余额宝历史累计收益
 */
@property (nonatomic, copy) NSString *yuebaoHisIncome;

/**
 *  花呗消费额度
 */
@property (nonatomic, copy) NSString *huabeiLimit;

/**
 *  花呗可用额度
 */
@property (nonatomic, copy) NSString *huabeiAvailableLimit;
@end



/**************3.收货地址***********/
@interface YJTaoBaoAddresses : NSObject

/**
 *  收货姓名
 */
@property (nonatomic, copy) NSString *name;


/**
 *  收货地址
 */
@property (nonatomic, copy) NSString *address;
/**
 *  收货联系手机号或电话
 */
@property (nonatomic, copy) NSString *mobile;
/**
 *  邮编
 */
@property (nonatomic, copy) NSString *zipCode;

/**
 *  是否未默认收货地址（是，不是）
 */
@property (nonatomic, copy) NSString *defaultAddr;

@end

/**************4.1订单商品信息***********/
@interface yjTaoBaoOrderItem : NSObject
/**
 *  商品ID
 */
@property (nonatomic, copy) NSString *itemId;
/**
 *  商品名称
 */
@property (nonatomic, copy) NSString *itemName;
/**
 *  商品Url
 */
@property (nonatomic, copy) NSString *itemUrl;

/**
 *  商品单价
 */
@property (nonatomic, copy) NSString *itemPrice;
/**
 *  商品数量
 */
@property (nonatomic, copy) NSString *itemQuantity;


@end

/**************4.2订单物流信息***********/
@interface YJTaoBaoLogisticsInfo : NSObject
/**
 *  运送方式
 */
@property (nonatomic, copy) NSString *deliverType;
/**
 *  物流公司
 */
@property (nonatomic, copy) NSString *deliverCompany;
/**
 *  送货单号
 */
@property (nonatomic, copy) NSString *deliverId;

/**
 *  收货人姓名
 */
@property (nonatomic, copy) NSString *receivePersonName;
/**
 *  收货人联系电话
 */
@property (nonatomic, copy) NSString *receivePersonMobile;

/**
 *  收货地址
 */
@property (nonatomic, copy) NSString *receiveAddress;


@end
/**************4.订单信息***********/
@interface YJTaoBaoOrderDetails : NSObject

/**
 *  订单号
 */
@property (nonatomic, copy) NSString *orderId;

/**
 *  订单时间
 */
@property (nonatomic, copy) NSString *orderTime;
/**
 *  订单金额
 */
@property (nonatomic, copy) NSString *orderAmt;
/**
 *  订单状态（交易成功、交易关闭、等待买家付款、买家已付款、买家已发货、退款中）
 */
@property (nonatomic, copy) NSString *orderStatus;

/**
 *  商品信息）
 */
@property (nonatomic, copy) NSArray *items;

/**
 *  物流信息
 */
@property (nonatomic, strong) NSDictionary *logisticsInfo;
/**
 *  物流信息模型
 */
@property (nonatomic, strong) YJTaoBaoLogisticsInfo *taoBaoLogisticsInfo;




@end




/**************淘宝数据***********/
@interface YJTaoBaoModel : NSObject

/**
 *  基本信息
 */
@property (nonatomic, strong) NSDictionary *basicInfo;
/**
 *  基本信息模型
 */
@property (nonatomic, strong) YJTaoBaoBasicInfo *taoBaoBasicInfo;

/**
 *  绑定的支付宝信息
 */
@property (nonatomic, strong) NSDictionary *alipayInfo;
/**
 *  绑定的支付宝信息模型
 */
@property (nonatomic, strong) YJTaoBaoAlipayInfo *taoBaoAlipayInfo;


/**
 *  收货地址
 */
@property (nonatomic, strong) NSArray *addresses;

/**
 *  订单信息
 */
@property (nonatomic, strong) NSArray *orderDetails;


@end


/************消费统计*************/
@interface YJTaobaoStatisticsModel : NSObject

/**
 *  历史消费地址统计
 */
@property (nonatomic, strong) NSArray *taobaoAddrStatistics;

/**
 *  按月消费统计
 */
@property (nonatomic, strong) NSArray *taobaoConsuStatistics;

@end
/************按地址消费统计*************/
@interface YJTaobaoAddrStatistic : NSObject

/**
 *  收货姓名
 */
@property (nonatomic, strong) NSString *receivePersonName;

/**
 *  收货地址
 */
@property (nonatomic, strong) NSString *receiveAddress;

/**
 *  最近送货时间
 */
@property (nonatomic, strong) NSString *receiveTime;

/**
 *  消费金额统计
 */
@property (nonatomic, strong) NSString *totalAmount;

/**
 *  收货号码
 */
@property (nonatomic, strong) NSString *receivePersonMobile;
@end

/************按月消费统计*************/
@interface YJTaobaoConsuStatistic : NSObject

/**
 *  月份
 */
@property (nonatomic, strong) NSString *month;

/**
 *  消费笔数
 */
@property (nonatomic, strong) NSString *totalNumberOfPens;

/**
 *  消费金额
 */
@property (nonatomic, strong) NSString *totalAmount;


@end
