//
//  YJComboPurchaseDetCell.m
//  CreditPlatform
//
//  Created by yj on 2016/10/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJComboPurchaseDetCell.h"
#import "YJComboPurchaseDetModel.h"
@interface YJComboPurchaseDetCell ()
/**
 序号
 */
@property (weak, nonatomic) IBOutlet UILabel *NoLB;
/**
 身份证号码
 */
@property (weak, nonatomic) IBOutlet UILabel *identityCardNoLB;
/**
 消费金额
 */
@property (weak, nonatomic) IBOutlet UILabel *amtLB;


/**
 1
 */
@property (weak, nonatomic) IBOutlet UILabel *itemTitle1LB;

/**
 1-1
 */
@property (weak, nonatomic) IBOutlet UILabel *itemTitle1ValueLB;

/**
 2
 */
@property (weak, nonatomic) IBOutlet UILabel *itemTitle2LB;
/**
 2-2
 */
@property (weak, nonatomic) IBOutlet UILabel *itemTitle2ValueLB;

/**
 3
 */
@property (weak, nonatomic) IBOutlet UILabel *itemTitle3LB;

/**
 3-3
 */
@property (weak, nonatomic) IBOutlet UILabel *itemTitle3ValueLB;
/**
 4
 */
@property (weak, nonatomic) IBOutlet UILabel *itemTitle4LB;

/**
 4-4
 */
@property (weak, nonatomic) IBOutlet UILabel *itemTitle4ValueLB;

/**
 5
 */
@property (weak, nonatomic) IBOutlet UILabel *itemTitle5LB;

/**
 5-5
 */
@property (weak, nonatomic) IBOutlet UILabel *itemTitle5ValueLB;

/**
 6
 */
@property (weak, nonatomic) IBOutlet UILabel *itemTitle6LB;

/**
 6-6
 */
@property (weak, nonatomic) IBOutlet UILabel *itemTitle6ValueLB;

@end
@implementation YJComboPurchaseDetCell

+ (instancetype)comboPurchaseDetCellWithTableView:(UITableView *)tableView {
    
    YJComboPurchaseDetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comboPurchaseDetCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJComboPurchaseDetCell" owner:nil options:nil] lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return cell;
    
    
}

- (void)setComboDetRow:(YJComboPurchaseDetRow *)comboDetRow {
    self.identityCardNoLB.text = comboDetRow.identityCardNo;
    
    if (comboDetRow.amt.length) {
        self.amtLB.text = [@"￥" stringByAppendingString: [NSString stringWithFormat:@"%.2f",[comboDetRow.amt floatValue]]];
    } else {
        self.amtLB.text = comboDetRow.amt;
    }
    
    
    
    // 类型对应的次数
    YJComboPurchaseItem *item0 = comboDetRow.statisMap[0];
    self.itemTitle1LB.text = item0.packageTitle;
    self.itemTitle1ValueLB.attributedText = [self setCount:item0.packageCount];
    
    YJComboPurchaseItem *item1 = comboDetRow.statisMap[1];
    self.itemTitle2LB.text = item1.packageTitle;
    self.itemTitle2ValueLB.attributedText = [self setCount:item1.packageCount];
    
    YJComboPurchaseItem *item2 = comboDetRow.statisMap[2];
    self.itemTitle3LB.text = item2.packageTitle;
    self.itemTitle3ValueLB.attributedText = [self setCount:item2.packageCount];
    
    YJComboPurchaseItem *item3 = comboDetRow.statisMap[3];
    self.itemTitle4LB.text = item3.packageTitle;
    self.itemTitle4ValueLB.attributedText = [self setCount:item3.packageCount];
    
    YJComboPurchaseItem *item4 = comboDetRow.statisMap[4];
    self.itemTitle5LB.text = item4.packageTitle;
    self.itemTitle5ValueLB.attributedText = [self setCount:item4.packageCount];
    
    YJComboPurchaseItem *item5 = comboDetRow.statisMap[5];
    self.itemTitle6LB.text = item5.packageTitle;
    self.itemTitle6ValueLB.attributedText = [self setCount:item5.packageCount];

    
    
    
    
}

- (NSMutableAttributedString *)setCount:(NSString *)count {
    NSString *str = [NSString stringWithFormat:@"%d 次",[count intValue]];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:str];
    [att addAttributes:@{NSForegroundColorAttributeName:RGB_black,NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, str.length)];
    
    NSRange amtRange = [str rangeOfString:@"次"];
    NSDictionary *attributtedDict = @{NSForegroundColorAttributeName:RGB_grayPlaceHoldText,NSFontAttributeName:[UIFont systemFontOfSize:10]};
    
    [att addAttributes:attributtedDict range:amtRange];
    
    return att;
}

- (void)setIndex:(NSInteger)index {
    self.NoLB.text = [NSString stringWithFormat:@"%ld",index+1];
}
- (void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
