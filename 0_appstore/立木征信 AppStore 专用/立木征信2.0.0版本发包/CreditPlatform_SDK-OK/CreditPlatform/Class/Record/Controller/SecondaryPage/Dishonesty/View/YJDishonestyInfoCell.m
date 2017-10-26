//
//  YJDishonestyInfoCell.m
//  CreditPlatform
//
//  Created by yj on 2016/11/15.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJDishonestyInfoCell.h"
#import "reportDishonestyModel.h"
@interface YJDishonestyInfoCell ()
{
    NSMutableArray *_leftLbArray;
    NSMutableArray *_rightLbArray;
    
    NSMutableArray *_leftTitles;
    
    CGFloat _leftLbWidth;
    CGFloat _rightLbWidth;
    
    UIView *_lastView; // 上一个控件
    UIView  *_topLine;
    UIView  *_midLine;
    UIView  *_bottomLine;
    
    UILabel *_titleLB;
    
}



@end

@implementation YJDishonestyInfoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        
    }
    return self;
}





#pragma mark--保单
- (void)setReportDishonestyModel:(reportDishonestyModel *)reportDishonestyModel {
    _reportDishonestyModel = reportDishonestyModel;
    
    _leftTitles = [NSMutableArray arrayWithObject:@"序号"];
    
    if (![self.reportDishonestyModel.sex isEqualToString:@""]) { // 个人
        [_leftTitles addObjectsFromArray:@[@"被执行人姓名",@"身份证号码",@"性别(个人)",@"年龄(个人)"]];

    } else { // 机构
        [_leftTitles addObjectsFromArray:@[@"被执行机构名称",@"组织机构代码",@"法定代表人\n负责人姓名"]];
    }
    
     [_leftTitles addObjectsFromArray:@[@"执行法院",@"省份",@"执行依据文号",@"立案时间",@"案号",@"做出执行依据单位",  @"生效法律文书\n确定的义务",@"被执行人的履行情况",@"具体情形",@"发布时间"]];
    
    [self creatUI];
    
    [self loadPolicyInfo];
    
    [self layoutSubview];
    
}


#pragma mark--创建UI

- (void)creatUI {
    
    _leftLbWidth = 140;
    
    
    _rightLbWidth = SCREEN_WIDTH - kMargin_15 * 3 - _leftLbWidth;
    
    [self addSubViewToCell];
    
    
}



#pragma mark--加载数据

/**
 保单信息
 */
- (void)loadPolicyInfo {
    
    MYLog(@"==================loadPolicyInfo");
    
    if (_rightLbArray.count == 0) {
        return;
    }
    // 序号
    if (self.reportDishonestyModel.no) {
        
        UILabel *lb = _rightLbArray[0];
        lb.text = self.reportDishonestyModel.no;
        
    }
    // 被执行人姓名、被执行机构名称
    if (self.reportDishonestyModel.name) {
        UILabel *lb = _rightLbArray[1];
        lb.text = self.reportDishonestyModel.name;
        
    }
    // 身份证号码、组织机构代码
    if (self.reportDishonestyModel.identityNo) {
        UILabel *lb = _rightLbArray[2];
        lb.text = self.reportDishonestyModel.identityNo;
        
    }
    int nextIndex = 0;
    
    if (![self.reportDishonestyModel.sex isEqualToString:@""]) { // 个人
        // 性别(个人)
        if (self.reportDishonestyModel.sex) { // 个人
            UILabel *lb = _rightLbArray[3];
            lb.text = self.reportDishonestyModel.sex;
        }
        // 年龄(个人)
        if (self.reportDishonestyModel.age) {
            UILabel *lb = _rightLbArray[4];
            lb.text = self.reportDishonestyModel.age;
        }
        
        nextIndex = 5;
    } else { // 机构
        // 法定代表人\n负责人姓名
        if (self.reportDishonestyModel.corpLegalPerson) { // 个人
            UILabel *lb = _rightLbArray[3];
            lb.text = self.reportDishonestyModel.corpLegalPerson;
        }
        nextIndex = 4;    }

    
    
    
    // 执行法院
    if (self.reportDishonestyModel.executiveCourt) {
        UILabel *lb = _rightLbArray[nextIndex];
        lb.text = self.reportDishonestyModel.executiveCourt;
        
    }
    // 省份
    if (self.reportDishonestyModel.province) {
        UILabel *lb = _rightLbArray[nextIndex+1];
        lb.text = self.reportDishonestyModel.province;
        
    }
    
    if (self.reportDishonestyModel.executiveBaiscNo) {
        UILabel *lb = _rightLbArray[nextIndex+2];
        lb.text = self.reportDishonestyModel.executiveBaiscNo;
        
    }
    // 立案时间
    if (self.reportDishonestyModel.filingTime) {
        UILabel *lb = _rightLbArray[nextIndex+3];
        lb.text = self.reportDishonestyModel.filingTime;
    }
    // 案号
    if (self.reportDishonestyModel.caseNo) {
        
        UILabel *lb = _rightLbArray[nextIndex+4];
        lb.text = self.reportDishonestyModel.caseNo;
        
    }
    // 做出执行依据单位
    if (self.reportDishonestyModel.executiveArm) {
        UILabel *lb = _rightLbArray[nextIndex+5];
        lb.text = self.reportDishonestyModel.executiveArm;
        
        
    }
    // 生效法律文书\n确定的义务
    if (self.reportDishonestyModel.legalObligation) {
        UILabel *lb = _rightLbArray[nextIndex+6];
        lb.text = self.reportDishonestyModel.legalObligation;
        
        
    }
    // 被执行人的履行情况
    if ([self.reportDishonestyModel.executiveCase isEqualToString:@"部分未履行"]) {
        NSString *details = [NSString stringWithFormat:@"(已履行:%@未履行:%@)",self.reportDishonestyModel.executed ,self.reportDishonestyModel.unExecuted];
        
        UILabel *lb = _rightLbArray[nextIndex+7];
        lb.text = [self.reportDishonestyModel.executiveCase stringByAppendingString:details];
        
        
    } else {
        UILabel *lb = _rightLbArray[nextIndex+7];
        lb.text = self.reportDishonestyModel.executiveCase;
//        self.executiveCaseLB.text = self.reportDishonestyModel.executiveCase;
        
    }
    // 具体情形
    if (self.reportDishonestyModel.specificSituation) {
        UILabel *lb = _rightLbArray[nextIndex+8];
        lb.text = self.reportDishonestyModel.specificSituation;
        
    }
    // 发布时间
    if (self.reportDishonestyModel.releaseTime) {
        UILabel *lb = _rightLbArray[nextIndex+9];
        lb.text = self.reportDishonestyModel.releaseTime;
        
    }
    
}


- (void)addSubViewToCell {
    
    
    _topLine = [UIView separationLine];
    _midLine = [UIView separationLine];
    _bottomLine = [UIView separationLine];
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = Font18;
    _titleLB.textColor = RGB_black;
    _titleLB.text = @"失信人执行信息";
    
    _leftLbArray = [NSMutableArray arrayWithCapacity:6];
    _rightLbArray = [NSMutableArray arrayWithCapacity:6];
    
    
    [self.contentView sd_addSubviews:@[_topLine,_midLine,_bottomLine,_titleLB]];
    
    for (NSString *title in _leftTitles) {
        // 左侧灰字
        UILabel *leftLB = [UILabel grayTitleLBWithTitle:title];
        [_leftLbArray addObject:leftLB];
        
        // 左侧内容
        UILabel *rightLB = [UILabel contentLB];
        [_rightLbArray addObject:rightLB];
        
        [self.contentView sd_addSubviews:@[leftLB, rightLB]];
    }
    
    
}

#pragma mark--布局
- (void)layoutSubview {
    
    _topLine.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .topSpaceToView(self.contentView, 0)
    .heightIs(.5);
    
    
    _midLine.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 0)
    .topSpaceToView(self.contentView, 45)
    .heightIs(.5);
    
    
    _titleLB.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(_topLine, 0)
    .bottomSpaceToView(_midLine, 0);
    
    
    _bottomLine.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0)
    .heightIs(.5);
    
    int count = (int)_leftLbArray.count;
    
    _lastView = _midLine;
    
    for (int i = 0; i < count; i ++) {
        UILabel *leftLB = _leftLbArray[i];
        UILabel *rightLB = _rightLbArray[i];
        
        CGFloat leftH = [leftLB heightOfLabelMaxWidth:_leftLbWidth];
        CGFloat rightH = [rightLB heightOfLabelMaxWidth:_rightLbWidth];
        
        leftLB.sd_layout
        .topSpaceToView(_lastView,kMargin_15)
        .leftSpaceToView(self.contentView,kMargin_15)
        .widthIs(_leftLbWidth)
        .heightIs(leftH);
        
        rightLB.sd_layout
        .leftSpaceToView(leftLB, kMargin_15)
        .topEqualToView(leftLB)
        .widthIs(_rightLbWidth)
        .heightIs(rightH);
        
        // 控制同行的Label最高的作为下一个参考
        if (leftH > rightH) {
            _lastView = leftLB;
        } else {
            _lastView = rightLB;
        }
        
    }
    
    
    
    
    
    [self setupAutoHeightWithBottomView:_lastView bottomMargin:kMargin_15];
    
    
    for (UILabel *lb in _leftLbArray) {
        lb.textAlignment = NSTextAlignmentRight;
    }
    
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
