//
//  CitySelectCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXListHookCell.h"
#import "LMZXListHookModel.h"
#import "UIImage+LMZXTint.h"
//#import "LMZXReportCreditBillModel.h"
#import "LMZXDemoAPI.h"
#import "NSString+LMZXCommon.h"
//#import "UIImageView+LMZXWebCache.h"
@interface LMZXListHookCell()
@property (strong, nonatomic)  UIButton *cellClick;

@property (strong, nonatomic)  UILabel *cityText;
@property (strong, nonatomic)  UIImageView *selectImg;
@property (strong, nonatomic)  UIImageView *icon;
@property (strong, nonatomic)  UIView *line;
@end
@implementation LMZXListHookCell

+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview {
    static NSString *ID = @"LMZXListHookCell";
    LMZXListHookCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        //        cell = [[[NSBundle mainBundle] loadNibNamed:@"ListHookCell" owner:nil options:nil] firstObject]; @2x
        cell = [[LMZXListHookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    return cell;
    
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {//这里加载NIB或者直接自行创建代码Cell
        [self configCell];
    }
    return self;
}

- (void)configCell {
    
    self.selectImg.hidden =YES;
    self.cityText.textColor = LM_RGB(100, 100, 100);
    
    CGFloat width = LM_SCREEN_WIDTH;
    CGFloat height = self.frame.size.height;
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    
    
    _cellClick = [[UIButton alloc] initWithFrame:self.contentView.frame];
    [_cellClick addTarget:self action:@selector(tapCell:) forControlEvents:UIControlEventTouchUpInside];
    _cellClick.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_cellClick];
    
    
    _icon=[[UIImageView alloc]initWithFrame:CGRectMake(15, (self.frame.size.height-48*0.7)/2  , 80*0.7, 48*0.7)];
    [self.contentView addSubview:_icon];
    
    
    
    _cityText = [[UILabel alloc]initWithFrame:CGRectMake(10+CGRectGetMaxX(_icon.frame), 0, 300, 44)];
    _cityText.textAlignment = 0;
    _cityText.font =LM_Font(15);
    _cityText.textColor = [UIColor blackColor];
    [self.contentView addSubview:_cityText];
    
    
    // 取消
    _selectImg =[[UIImageView alloc]initWithFrame:CGRectMake(width-25-15, height/2-12/2, 20, 12)];
    _selectImg.hidden =YES;
    UIImage*img =  [UIImage imageFromBundle:@"lmzxResource" name:@"lmzx_checked"];
    [_selectImg setImage:img];
    //    [self.contentView addSubview:_selectImg];
    
    UIView *bline = [[UIView alloc]initWithFrame:CGRectMake(0,  self.frame.size.height-0.5, LM_SCREEN_WIDTH, 0.5)];
    bline.backgroundColor = LM_RGBGrayLine;
    _line = bline;
    [self.contentView addSubview:_line];
    
}

- (void)dealloc {
    self.listHookModel = nil;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat height = self.frame.size.height;
    CGFloat width = LM_SCREEN_WIDTH;
    
    _icon.frame = CGRectMake(15, (self.frame.size.height-48*0.5)/2  , 80*0.5, 48*0.5);
    _cityText.frame = CGRectMake(10+CGRectGetMaxX(_icon.frame), 0, 300, 44);
    _line.frame = CGRectMake(0,  self.frame.size.height-0.5, LM_SCREEN_WIDTH, 0.5);
    _selectImg.frame = CGRectMake(width-25-15, height/2-12/2, 20, 12);
}

- (IBAction)tapCell:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.selectImg.hidden =NO;
        
        if ([LMZXSDK shared].lmzxProtocolTextColor) {
            self.cityText.textColor = [LMZXSDK shared].lmzxProtocolTextColor;
        }else{
            self.cityText.textColor = LM_RGB(48, 113, 242);
        }
        
    }else{
        self.selectImg.hidden =YES;
        self.cityText.textColor = [UIColor blackColor];
        
    }
    if (self.tapListHookCell) {
        self.listHookModel.selected = YES;
        self.tapListHookCell(_listHookModel);
    }
}

-(void)setImgData:(UIImage *)imgData{
    _imgData = imgData;
    [_icon setContentMode:UIViewContentModeScaleAspectFit];
    [_icon setImage:imgData];
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)setListHookModel:(LMZXListHookModel *)listHookModel {
    _listHookModel = listHookModel;
    self.selectImg.hidden =YES;
    self.cityText.textColor = [UIColor blackColor];
    
    if (listHookModel.selected ) {
        self.selectImg.hidden =NO;
        if ([LMZXSDK shared].lmzxProtocolTextColor) {
            self.cityText.textColor = [LMZXSDK shared].lmzxProtocolTextColor;
        }else{
            self.cityText.textColor = LM_RGB(48, 113, 242);
        }
    }
    
    
    // 车险
    if (_listHookModel.companyCarInsuranc){
        NSString *str = _listHookModel.companyCarInsuranc.name;
        self.cityText.text=str;
        //        if (listHookModel.companyCarInsuranc.logo) {
        //            //        UIImage*img =  [UIImage imageFromBundle:@"lmzxResource" name:listHookModel.companyCarInsuranc.img];
        //            if (listHookModel.companyCarInsuranc.logo&&!_icon.image) {
        //                NSURL *ur = [NSURL URLWithString:listHookModel.companyCarInsuranc.logo];
        //                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //                    [_icon setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:ur]]];
        //                });
        //            }
        //        }
        
    }
    // 网银
    else if (_listHookModel.eBankListModel){
        NSString *str = _listHookModel.eBankListModel.name;
        self.cityText.text=str;
        //        if (listHookModel.eBankListModel.logo) {
        //            //        UIImage*img =  [UIImage imageFromBundle:@"lmzxResource" name:listHookModel.eBankListModel.img];
        //            if (listHookModel.eBankListModel.logo&&!_icon.image) {
        //                NSURL *ur = [NSURL URLWithString:listHookModel.companyCarInsuranc.logo];
        //                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //                    [_icon setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:ur]]];
        //                });
        //            }
        //        }
    }
    
    //    [self setNeedsLayout];
    //        [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect {
    if (self.highlighted) {
        self.backgroundColor =  LM_RGB(204, 204, 204);
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.backgroundColor = LM_RGB(204, 204, 204);
    }
    else {
    }
    [self setNeedsDisplay];
}


@end
