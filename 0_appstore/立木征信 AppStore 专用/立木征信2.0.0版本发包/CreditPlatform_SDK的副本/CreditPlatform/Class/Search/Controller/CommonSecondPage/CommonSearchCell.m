//
//  CommonSearchCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/8/17.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "CommonSearchCell.h"
#import "CommonSearchCellModel.h"
#import "JmailTextField.h"


@interface CommonSearchCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *Name;

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpace;
@property (weak, nonatomic) IBOutlet UIButton *seeBTn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpaceBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *NameWidth;



@end
@implementation CommonSearchCell
{
    CGFloat _length;
}


+(instancetype)initCommonCellWith:(UITableView *)tableView{
    CommonSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonSearchCell"];
    
    if (cell == nil) {
         cell= [[[NSBundle mainBundle] loadNibNamed:@"CommonSearchCell" owner:nil options:nil] firstObject];
    }
    return cell;
}
-(id)init{
    if (self =[super init]) {
        self.textField.clearsOnBeginEditing =NO;
        
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.textField.tag = TagCommonSearchCellTextfiled;
//    self.textField.clearButtonMode = UITextFieldViewModeNever;
    _textField.delegate = self;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
}
-(void)drawRect:(CGRect)rect{
    //1上 2上下  3 下 4 下
   
    
    if (_model.location == 1) {//上  show hid
        _topLine.hidden = NO;
        _bottomLine.hidden = NO;
        _leftSpace.constant = 0;
        _leftSpaceBottom.constant = 15;
    } else if (_model.location == 2){//中   show show
        _topLine.hidden = YES;
        _bottomLine.hidden = NO;
        _leftSpace.constant = 15;
        _leftSpaceBottom.constant = 15;
    }else if (_model.location == 3){//下 hid show
        _topLine.hidden = YES;
        _bottomLine.hidden = NO;
        _leftSpace.constant = 15;
        _leftSpaceBottom.constant = 0;
    }
    
    _Name.font = [UIFont systemFontOfSize:15];
    _Name.textAlignment = 0;
    if (_length<=60) {
        _NameWidth.constant =(int)_length +20;
    }else{
        _NameWidth.constant =(int)_length +20;
    }
    
    
    
}

-(void)setFundSocialModel:(JFundSocialSearchCellModel *)fundSocialModel{
    
    
}


// 用tableviewCell选择
- (IBAction)didClickedCtiy:(UIButton *)sender {
//    if (self.clickedSelectCity) {
//        self.clickedSelectCity();
//    }
}

- (IBAction)SeeText:(UIButton *)sender {
    [self.textField setFont:nil];
    [self.textField setFont:Font15];
    
    _textField.secureTextEntry = !_textField.secureTextEntry;
    _seeBTn.selected = !_seeBTn.selected;
    
}


-(void)setModel:(CommonSearchCellModel *)model{
    _model = model;
    self.type = model.type;
    if (model.Text) {
        _textField.text = model.Text;
    }
    _Name.text = model.Name;
    _textField.placeholder = model.placeholdText;
    if (model.maxLength) {
        _length = model.maxLength;
    }
    
    _topLine.hidden = YES;
    _bottomLine.hidden = YES;
    
    if (model.location == 1) {//上
        _topLine.hidden = NO;
        _bottomLine.hidden = NO;
        _leftSpace.constant = 0;
        _leftSpaceBottom.constant = 15;
    } else if (model.location == 2){//中
        _topLine.hidden = YES;
        _bottomLine.hidden = NO;
        _leftSpace.constant = 15;
        _leftSpaceBottom.constant = 15;
    }else if (model.location == 3){//下
        _topLine.hidden = YES;
        _bottomLine.hidden = NO;
        _leftSpace.constant = 15;
        _leftSpaceBottom.constant = 0;
    }
    _iconBtn.hidden = YES;
    _iconBtn.enabled =NO;
    _textField.enabled = YES;
    _seeBTn.hidden = YES;
    _textField.secureTextEntry = NO;
    switch (model.type) {
        case 1:{//箭头
            _iconBtn.hidden = NO;
            _iconBtn.enabled = YES;
            _textField.enabled = NO;
            self.iconWidth.constant = 35;
        }
            break;
        case 2:{//眼睛
            _seeBTn.hidden =NO;
            _textField.secureTextEntry = YES;
            self.iconWidth.constant = 35;
        }
            break;
        case 3:{//无
            self.iconWidth.constant = 1;
        }
            break;
        default:
            break;
    }
    
}

-(void)setCity:(NSString *)city{
    if (_iconBtn.enabled) {
        _textField.placeholder = city;
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
    if (textField.text.length>49) {
        return NO;
    }
    //退格
    if (!string.length) {
        return YES;
    }
    
    if (_model.searchItemType == SearchItemTypeOperators) {
        
        //粘贴，有空格
        NSRange rang = [string rangeOfString:@" "];
        if (rang.length >= 1 &&string.length>11) {
            string = [string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            _model.Text = string;
            if (self.clickedSelectCity) {
                self.clickedSelectCity(string);
//                [self endEditing:YES];
            }
            return NO;
        }
        
        //粘 贴
        if (string.length == 11) {
            if (self.clickedSelectCity) {
                [self performSelector:@selector(SSS:) withObject:string afterDelay:0.5];
//            [self endEditing:YES];
//            [self resignFirstResponder];
            }
            return YES;
        }
        
        //完整输入11位
        if (textField.text.length>9 && _model.location == 1 &&string.length) {
            if (textField.text.length==10) {
                textField.text = [textField.text stringByAppendingString:string];
                
            }else{
                
            }
            
            if (self.clickedSelectCity) {
                self.clickedSelectCity(textField.text);
            }
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
    if (self.clickedSelectCity) {
        self.clickedSelectCity(str);
       
    }
}



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
    //    [[self nextResponder] touchesBegan:touches withEvent:event];
}

@end
