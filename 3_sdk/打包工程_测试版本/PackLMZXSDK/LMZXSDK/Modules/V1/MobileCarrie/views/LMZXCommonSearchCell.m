//
//  CommonSearchCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/8/17.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXCommonSearchCell.h"
#import "LMZXSearchCellModel.h"
#import "UIImage+LMZXTint.h"
#import "LMZXDemoAPI.h"

@interface LMZXCommonSearchCell ()<UITextFieldDelegate>

@property (strong, nonatomic)  UILabel *Name;
@property (strong, nonatomic)  UIButton *iconBtn;
@property (strong, nonatomic)  UIView *topLine;
@property (strong, nonatomic)  UIView *bottomLine;
@property (strong, nonatomic)  UIButton *seeBTn;
@property (strong, nonatomic)  UILabel *creditLable;


//// 上边线
//@property (assign, nonatomic)   CGFloat  leftSpace;
//// 下边线
//@property (assign, nonatomic)   CGFloat  leftSpaceBottom;
//  name宽度,取最大宽度
@property ( assign, nonatomic)   CGFloat NameWidth;



@end
@implementation LMZXCommonSearchCell
//{
//    CGFloat _length;
//}
 


+(instancetype)initCommonCellWith:(UITableView *)tableView{
    
    
    LMZXCommonSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LMZXCommonSearchCell"];
    
    if (cell == nil) {
        cell = [[LMZXCommonSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LMZXCommonSearchCell"];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {//这里加载NIB或者直接自行创建代码Cell

        _NameWidth =80;
        [self configCell];
        
        self.textField.clearsOnBeginEditing =NO;
        
    }
    return self;
}

- (void)configCell {
    CGFloat width = LM_SCREEN_WIDTH;
    CGFloat height = self.frame.size.height;
    CGFloat wide = width*(566/2.0)/(750/2.0);
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _Name = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, _NameWidth, height)];
    _Name.textAlignment = 0;
    _Name.font =LM_Font(15);
    _Name.textColor = [UIColor blackColor];
    [self.contentView addSubview:_Name];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_Name.frame),0, width-CGRectGetMaxX(_Name.frame)-35, height)];
    _textField.textAlignment = 0;
    _textField.textColor = [UIColor blackColor];
    _textField.font = LM_Font(15.0);
    [self.contentView addSubview:_textField];
    
    _creditLable = [[UILabel alloc]initWithFrame:CGRectMake(wide+10, 0, width-wide, height)];
    _creditLable.textAlignment = 0;
    _creditLable.font =LM_Font(15);
    _creditLable.textColor = LM_RGB(102, 102, 102);
    _creditLable.hidden =YES;
    _creditLable.text = @"";

    [self.contentView addSubview:_creditLable];

    
    _seeBTn = [[UIButton alloc]initWithFrame:CGRectMake(width-45, 2, 40, 40)];
    [_seeBTn addTarget:self action:@selector(SeeText:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_seeBTn];
    
    
    _iconBtn = [[UIButton alloc]initWithFrame:CGRectMake(width-45, 2, 40, 40)];
    [self.contentView addSubview:_iconBtn];
    
    
    _topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 0.5)];
    _topLine.backgroundColor =  LM_RGBGrayLine;
    [self.contentView addSubview:_topLine];
    
    
    _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0,  height, width, 0.5)];
    _bottomLine.backgroundColor = LM_RGBGrayLine;
    [self.contentView addSubview:_bottomLine];
    
    
    self.textField.tag = LM_TagCommonSearchCellTextfiled;
    _textField.delegate = self;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.seeBTn setImage:[UIImage imageFromBundle:@"lmzxResource" name:@"lmzx_eye_hide"] forState:(UIControlStateNormal)];
    
    [self.seeBTn setImage:[UIImage imageFromBundle:@"lmzxResource" name:@"lmzx_eye_display"] forState:(UIControlStateSelected)];
    
    [self.iconBtn setImage:[UIImage imageFromBundle:@"lmzxResource" name:@"lmzx_arrow_right"] forState:(UIControlStateNormal)];
 
    
}
-(void)drawRect:(CGRect)rect{
    
    //1上 2上下  3 下 4 下
    
    
    if (_model.location == 1) {//上  show hid
        _topLine.hidden = NO;
        _bottomLine.hidden = NO;
    } else if (_model.location == 2){//中   show show
        _topLine.hidden = YES;
        _bottomLine.hidden = NO;
    }else if (_model.location == 3){//下 hid show
        _topLine.hidden = YES;
        _bottomLine.hidden = NO;
    }
    
    _Name.font = [UIFont systemFontOfSize:15];
    _Name.textAlignment = 0;
 
    
    _topLine.hidden = NO;
    _bottomLine.hidden = NO;
    if (_searchItemType == LMZXSearchItemTypeCreditCardBill && _model.location == 1) {
        _creditLable.hidden =NO;
    }
}

-(void)layoutSubviews{
    
    
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    _Name.frame = CGRectMake(15, 0, _NameWidth, height);
    _textField.frame = CGRectMake(15+CGRectGetMaxX(_Name.frame), 0, width-CGRectGetMaxX(_Name.frame)-48, height);
    
    _topLine.frame = CGRectMake(0, 0, width, 0.5);
    _bottomLine.frame = CGRectMake(0, height, width, 0.5);
    
    //1上 2上下  3 下 4 下
    if (_model.location == 1) {//上  show hid
        _topLine.frame = CGRectMake(0, 0, width, 0.5);
        _bottomLine.frame = CGRectMake(15, height, width, 0.5);
    } else if (_model.location == 2){//中   show show
        _topLine.frame = CGRectMake(15, 0, width, 0.5);
        _bottomLine.frame = CGRectMake(15, height, width, 0.5);
    } else if (_model.location == 3){//下 hid show
        _topLine.frame = CGRectMake(15, 0, width, 0.5);
        _bottomLine.frame = CGRectMake(0, height, width, 0.5);
    }
    
    _topLine.hidden = NO;
    _bottomLine.hidden = NO;
    
    CGFloat wide = width*((566-40)/2.0)/(750/2.0);
    // 重新布局
    if (_searchItemType == LMZXSearchItemTypeCreditCardBill && _model.location == 1) {
        _creditLable.hidden = NO;
        _textField.frame = CGRectMake(15+CGRectGetMaxX(_Name.frame),0, wide-CGRectGetMaxX(_Name.frame), height);
        _creditLable.frame = CGRectMake(wide+10, 0, width-wide, height);
    }
    
}

#pragma mark -  model 设置
-(void)setSearchItemType:(LMZXSearchItemType)searchItemType{
    _searchItemType = searchItemType;
}

-(void)setModel:(LMZXSearchCellModel *)model{
     _model = model;
    _searchItemType = model.searchItemType;
    _type = model.type;
    
    
    
    if (model.Text) {
        _textField.text = model.Text;
    }else{
        _textField.text = @"";
    }
    
    _Name.text = model.Name;
    _textField.placeholder = model.placeholdText;
    if (model.maxLength) {
        _NameWidth = model.maxLength;
    }
    
//    _topLine.hidden = YES;
//    _bottomLine.hidden = YES;
    
//    if (model.location == 1) {//上
//        _topLine.hidden = NO;
//        _bottomLine.hidden = NO;
//    } else if (model.location == 2){//中
//        _topLine.hidden = YES;
//        _bottomLine.hidden = NO;
//    }else if (model.location == 3){//下
//        _topLine.hidden = YES;
//        _bottomLine.hidden = NO;
//    }
    _iconBtn.hidden = YES;
    _iconBtn.enabled = NO;
    _textField.enabled = YES;
    _seeBTn.hidden = YES;
    _textField.secureTextEntry = NO;
    switch (model.type) {
        case 1:{//箭头
            _iconBtn.hidden = NO;
            _iconBtn.enabled = YES;
            _textField.enabled = NO;
            [_textField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
        }
            break;
        case 2:{//眼睛
            _seeBTn.hidden = NO;
            _seeBTn.selected = NO;
            _textField.secureTextEntry = YES;
            
//            // 根据眼睛历史状态,重设.....BUG 修复
//            if (_seeBTn.selected==NO) {
//                _seeBTn.selected = NO;
//            }else{
//                _seeBTn.selected = YES;
//            }
            
        }
            break;
        case 3:{//无
        }
            break;
        default:
            break;
    }
    
    // 重新布局
    if (model.searchItemType == LMZXSearchItemTypeCreditCardBill && _model.location == 1) {
        _creditLable.hidden =NO;
    }else{
        _creditLable.hidden =YES;
    }
    
    [self setNeedsDisplay];
    [self setNeedsLayout];
}
-(void)setCreditMail:(NSString *)creditMail{
    _creditMail = creditMail;
    // 重新布局
    if (_model.searchItemType == LMZXSearchItemTypeCreditCardBill && _model.location == 1) {
        _creditLable.text = _creditMail;
        _creditLable.hidden =NO;
        [self layoutSubviews];
    }else{
        _creditLable.hidden =YES;
    }
}
-(void)setCity:(NSString *)city{
    if (_iconBtn.enabled) {
        _textField.placeholder = city;
    }
    
}

#pragma mark -  textfiled 处理
- (BOOL)textFieldShouldClear:(UITextField *)textField{
//    [NSNotificationCenter defaultCenter] postNotificationName:<#(nonnull NSNotificationName)#> object:<#(nullable id)#>
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    // 特殊情况下的显示问题
    if (_seeBTn.selected== YES) {
        _textField.secureTextEntry = NO;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    if ([self.delegate respondsToSelector:@selector(overClickedTextfiled:)]) {
//        [self.delegate overClickedTextfiled:(textField.text)];
//    }
//    _model.Text = textField.text;
    [textField resignFirstResponder];
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if ([self.delegate respondsToSelector:@selector(overClickedTextfiled:)]) {
//        [self.delegate overClickedTextfiled:(textField.text)];
//    }
    _model.Text = textField.text;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //退格
    if (!string.length) {
        return YES;
    }
    
    if (textField.text.length>49) {
        
        return NO;
    }
    if (self.searchItemType == LMZXSearchItemTypeOperators) {
        if (textField.text.length>20) {
            return NO;
        }
        
    }
    
    
    if (_model.searchItemType == LMZXSearchItemTypeOperators) {
        
        //粘贴，有空格
        NSRange rang = [string rangeOfString:@" "];
        if (rang.length >= 1 &&string.length>11) {
            string = [string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            _model.Text = string;
            
            if ([self.delegate respondsToSelector:@selector(commonSearchCell:didCheckMobileFromCity:)]) {
                [self.delegate commonSearchCell:self didCheckMobileFromCity:string];

            }
//            if (self.clickedSelectCity) {
//                self.clickedSelectCity(string);
////                [self endEditing:YES];
//            }
            return NO;
        }
        
        //粘 贴
        if (string.length == 11) {
            
            if ([self.delegate respondsToSelector:@selector(commonSearchCell:didCheckMobileFromCity:)]) {
                [self performSelector:@selector(SSS:) withObject:string afterDelay:0.5];
            }
            
//            if (self.clickedSelectCity) {
//                [self performSelector:@selector(SSS:) withObject:string afterDelay:0.5];
////            [self endEditing:YES];
////            [self resignFirstResponder];
//            }
            return YES;
        }
        
        //完整输入11位
        if (textField.text.length>9 && _model.location == 1 &&string.length) {
            if (textField.text.length==10) {
                textField.text = [textField.text stringByAppendingString:string];
                
            }else{
                
            }
            
            if ([self.delegate respondsToSelector:@selector(commonSearchCell:didCheckMobileFromCity:)]) {
                [self.delegate commonSearchCell:self didCheckMobileFromCity:textField.text];
            }
            
//            if (self.clickedSelectCity) {
//                self.clickedSelectCity(textField.text);
//            }
            return YES;
        }
        
        
        
    }
    else{
        
        if (range.location > 0 && range.length == 1 && string.length == 0)
        {
            // Stores cursor position
            UITextPosition *beginning = textField.beginningOfDocument;
            UITextPosition *start = [textField positionFromPosition:beginning offset:range.location];
            NSInteger cursorOffset = [textField offsetFromPosition:beginning toPosition:start] + string.length;
            NSString *text = textField.text;
            
            [textField deleteBackward];
            
        
            if (textField.text.length != text.length - 1){
                textField.text = [text stringByReplacingCharactersInRange:range withString:string];
                
                UITextPosition *newCursorPosition = [textField positionFromPosition:textField.beginningOfDocument offset:cursorOffset];
                UITextRange *newSelectedRange = [textField textRangeFromPosition:newCursorPosition toPosition:newCursorPosition];
                [textField setSelectedTextRange:newSelectedRange];
            }
            return NO;
        }
        
    }
   
    return YES;
}
-(void)SSS:(NSString*)str{
    if ([self.delegate respondsToSelector:@selector(commonSearchCell:didCheckMobileFromCity:)]) {
        [self.delegate commonSearchCell:self didCheckMobileFromCity:str];
    }
    
//    if (self.clickedSelectCity) {
//        self.clickedSelectCity(str);
//       
//    }
}


#pragma mark - 点击眼睛
- (void)SeeText:(UIButton *)sender {
    [self.textField setFont:nil];
    [self.textField setFont:LM_Font(15)];
    _seeBTn.selected = !_seeBTn.selected;
    _textField.secureTextEntry = !_textField.secureTextEntry;
    
    
}

#pragma mark -  其他设置

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];  //取消高亮状态
    
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{ 
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 选其一即可
    [super touchesBegan:touches withEvent:event];
//        [[self nextResponder] touchesBegan:touches withEvent:event];
}

@end
