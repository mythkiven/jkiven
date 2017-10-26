//
//  JInputTextView.m
//  JInputTextView 
//  Created by gyjrong on 2017/9/19.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//
#import "JInputTextView.h"

#define DEFAULT_CONTENT_SIZE_WITH_UNIT_COUNT(c) CGSizeMake(44 * c, 44)

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
NSNotificationName const JInputTextViewDidBecomeFirstResponderNotification = @"JInputTextViewDidBecomeFirstResponderNotification";
NSNotificationName const JInputTextViewDidResignFirstResponderNotification = @"JInputTextViewDidResignFirstResponderNotification";
#else
NSString *const JInputTextViewDidBecomeFirstResponderNotification = @"JInputTextViewDidBecomeFirstResponderNotification";
NSString *const JInputTextViewDidResignFirstResponderNotification = @"JInputTextViewDidResignFirstResponderNotification";
#endif

@interface JInputTextView () <UIKeyInput>

@property (nonatomic, strong) NSMutableArray *string;
@property (nonatomic, strong) CALayer *cursorLayer;

@end

@implementation JInputTextView
{
    UIColor *_backgroundColor;
    CGContextRef _ctx;
}

@synthesize secureTextEntry = _secureTextEntry;
@synthesize enablesReturnKeyAutomatically = _enablesReturnKeyAutomatically;
@synthesize keyboardType = _keyboardType;
@synthesize returnKeyType = _returnKeyType;

#pragma mark - Life

- (instancetype)initWithInputUnitCount:(NSUInteger)count {
    if (self = [super initWithFrame:CGRectZero]) {
        NSCAssert(count > 0, @"JInputTextView must have one or more input units.");
        NSCAssert(count <= 9, @"JInputTextView can not have more than 9 input units.");
        
        _inputUnitCount = count;
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _inputUnitCount = 4;
        [self initialize];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _inputUnitCount = 4;
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
      
    [super setBackgroundColor:[UIColor clearColor]];
    // 默认设置
    _string = [NSMutableArray array];
    _secureTextEntry = NO;
    _inputUnitCount = 4;
    _unitSpace = 15;
    _borderRadius = 0;
    _borderWidth = 1;
    _textFont = [UIFont systemFontOfSize:23];
    _defaultKeyboardType = JQKeyboardTypeNumberPad;
    _defaultReturnKeyType = UIReturnKeyDone;
    _enablesReturnKeyAutomatically = YES;
    _autoResignFirstResponderWhenInputFinished = NO;
    _textColor = [UIColor blackColor];
    _tintColor = [UIColor colorWithHexString:@"#999999"];
    _trackTintColor = [UIColor colorWithHexString:@"#3071f2"];
    _cursorColor = [UIColor colorWithHexString:@"#3071f2"];
    _backgroundColor = [UIColor whiteColor];
    
    
    
    self.cursorLayer.backgroundColor = _cursorColor.CGColor;
    
    
    [self.layer addSublayer:self.cursorLayer];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self setNeedsDisplay];
    }];
    [self becomeFirstResponder];
}

#pragma mark - Property

- (NSString *)text {
    if (_string.count == 0) return nil;
    return [_string componentsJoinedByString:@""];
}

- (CALayer *)cursorLayer {
    if (!_cursorLayer) {
        _cursorLayer = [CALayer layer];
        _cursorLayer.hidden = YES;
        _cursorLayer.opacity = 1;
        
        CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animate.fromValue = @(0);
        animate.toValue = @(1.5);
        animate.duration = 0.5;
        animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animate.autoreverses = YES;
        animate.removedOnCompletion = NO;
        animate.fillMode = kCAFillModeForwards;
        animate.repeatCount = HUGE_VALF;
        
        [_cursorLayer addAnimation:animate forKey:nil];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self layoutIfNeeded];
            _cursorLayer.position = CGPointMake(CGRectGetWidth(self.bounds) / _inputUnitCount / 2, CGRectGetHeight(self.bounds) / 2);
        }];
    }
    return _cursorLayer;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    _secureTextEntry = secureTextEntry;
    [self setNeedsDisplay];
    [self _showOrHideCursorIfNeeded];
}

#if TARGET_INTERFACE_BUILDER
- (void)setInputUnitCount:(NSUInteger)inputUnitCount {
    if (inputUnitCount < 1 || inputUnitCount > 9) return;
    _inputUnitCount = inputUnitCount;
    [self setNeedsDisplay];
    [self _showOrHideCursorIfNeeded];
}
#endif

- (void)setUnitSpace:(CGFloat)unitSpace {
    if (unitSpace < 0) return;
    if (unitSpace < 2) unitSpace = 0;
    _unitSpace = unitSpace;
    [self setNeedsDisplay];
    [self _showOrHideCursorIfNeeded];
}

- (void)setTextFont:(UIFont *)textFont {
    if (textFont == nil) {
        _textFont = [UIFont systemFontOfSize:23];
    } else {
        _textFont = textFont;
    }
    [self setNeedsDisplay];
    [self _showOrHideCursorIfNeeded];
}

- (void)setTextColor:(UIColor *)textColor {
    if (textColor == nil) {
        _textColor = [UIColor blackColor];
    } else {
        _textColor = textColor;
    }
    [self setNeedsDisplay];
    [self _showOrHideCursorIfNeeded];
}

- (void)setBorderRadius:(CGFloat)borderRadius {
    if (borderRadius < 0) return;
    _borderRadius = borderRadius;
    [self setNeedsDisplay];
    [self _showOrHideCursorIfNeeded];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth < 0) return;
    _borderWidth = borderWidth;
    [self setNeedsDisplay];
    [self _showOrHideCursorIfNeeded];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    if (backgroundColor == nil) {
        _backgroundColor = [UIColor blackColor];
    } else {
        _backgroundColor = backgroundColor;
    }
    [self setNeedsDisplay];
    [self _showOrHideCursorIfNeeded];
}

- (void)setTintColor:(UIColor *)tintColor {
    if (tintColor == nil) {
        _tintColor = [[UIView appearance] tintColor];
    } else {
        _tintColor = tintColor;
    }
    [self setNeedsDisplay];
    [self _showOrHideCursorIfNeeded];
}

- (void)setTrackTintColor:(UIColor *)trackTintColor {
    _trackTintColor = trackTintColor;
    [self setNeedsDisplay];
    [self _showOrHideCursorIfNeeded];
}

- (void)setCursorColor:(UIColor *)cursorColor {
    _cursorColor = cursorColor;
    _cursorLayer.backgroundColor = _cursorColor.CGColor;
    [self _showOrHideCursorIfNeeded];
}

-(void)setFirstEvent:(NSInteger)index{
    if(index == 10){
        BOOL result = [super becomeFirstResponder];
        [self _showOrHideCursorIfNeeded];
        if (result ==  YES) {
            [self sendActionsForControlEvents:UIControlEventEditingDidBegin];
            [[NSNotificationCenter defaultCenter] postNotificationName:JInputTextViewDidBecomeFirstResponderNotification object:nil];
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self becomeFirstResponder];
        }];
    }else if(index == 11){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self setNeedsDisplay];
            [self layoutIfNeeded];
            [self layoutSubviews];
            [self updateLayout];
        }];
    }
}
#pragma mark- Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self becomeFirstResponder];
}

#pragma mark - Override
- (CGSize)intrinsicContentSize {
    [self layoutIfNeeded];
    CGSize size = self.bounds.size;
    if (size.width < DEFAULT_CONTENT_SIZE_WITH_UNIT_COUNT(_inputUnitCount).width) {
        size.width = DEFAULT_CONTENT_SIZE_WITH_UNIT_COUNT(_inputUnitCount).width;
    }
    CGFloat unitWidth = (size.width + _unitSpace) / _inputUnitCount - _unitSpace;
    size.height = unitWidth;
    return size;
}
- (CGSize)sizeThatFits:(CGSize)size {
    return [self intrinsicContentSize];
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (BOOL)becomeFirstResponder {
    BOOL result = [super becomeFirstResponder];
    [self _showOrHideCursorIfNeeded];
    if (result ==  YES) {
        [self sendActionsForControlEvents:UIControlEventEditingDidBegin];
        [[NSNotificationCenter defaultCenter] postNotificationName:JInputTextViewDidBecomeFirstResponderNotification object:nil];
    }
    return result;
}
- (BOOL)canResignFirstResponder {
    return YES;
}
- (BOOL)resignFirstResponder {
    BOOL result = [super resignFirstResponder];
    [self _showOrHideCursorIfNeeded];
    if (result) {
        [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
        [[NSNotificationCenter defaultCenter] postNotificationName:JInputTextViewDidResignFirstResponderNotification object:nil];
    }
    return result;
}
#pragma mark -
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGSize unitSize = CGSizeMake((rect.size.width + _unitSpace) / _inputUnitCount - _unitSpace, rect.size.height);
    _ctx = UIGraphicsGetCurrentContext();
    [self _fillRect:rect clip:YES];
    [self _drawBorder:rect unitSize:unitSize];
    [self _drawText:rect unitSize:unitSize];
    [self _drawTrackBorder:rect unitSize:unitSize];
    [self _resize];
}

#pragma mark- Private

- (void)_resize {
    [self invalidateIntrinsicContentSize];
}

- (void)
_fillRect:(CGRect)rect clip:(BOOL)clip {
    [_backgroundColor setFill];
    if (clip) {
        CGContextAddPath(_ctx, [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:_borderRadius].CGPath);
        CGContextClip(_ctx);
    }
    CGContextAddPath(_ctx, [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, _borderWidth * 0.75, _borderWidth * 0.75) cornerRadius:_borderRadius].CGPath);
    CGContextFillPath(_ctx);
}
- (void)_drawBorder:(CGRect)rect unitSize:(CGSize)unitSize {
    
    [self.tintColor setStroke];
    CGContextSetLineWidth(_ctx, _borderWidth);
    CGContextSetLineCap(_ctx, kCGLineCapRound);
    CGRect bounds = CGRectInset(rect, _borderWidth * 0.5, _borderWidth * 0.5);
    if (_unitSpace < 2) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:_borderRadius];
        CGContextAddPath(_ctx, bezierPath.CGPath);
        
        for (int i = 1; i < _inputUnitCount; ++i) {
            CGContextMoveToPoint(_ctx, (i * unitSize.width), 0);
            CGContextAddLineToPoint(_ctx, (i * unitSize.width), (unitSize.height));
        }
    } else {
        for (int i = (int)_string.count; i < _inputUnitCount; i++) {
            CGRect unitRect = CGRectMake(i * (unitSize.width + _unitSpace),
                                         0,
                                         unitSize.width,
                                         unitSize.height);
            unitRect = CGRectInset(unitRect, _borderWidth * 0.5, _borderWidth * 0.5);
            UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:unitRect cornerRadius:_borderRadius];
            CGContextAddPath(_ctx, bezierPath.CGPath);
        }
    }
    CGContextDrawPath(_ctx, kCGPathStroke);
}
- (void)_drawText:(CGRect)rect unitSize:(CGSize)unitSize {
    if ([self hasText] == NO) return;
    NSDictionary *attr = @{NSForegroundColorAttributeName: _textColor,
                           NSFontAttributeName: _textFont};
    for (int i = 0; i < _string.count; i++) {
        CGRect unitRect = CGRectMake(i * (unitSize.width + _unitSpace),
                                     0,
                                     unitSize.width,
                                     unitSize.height);
        if (_secureTextEntry == NO) {
            NSString *subString = [_string objectAtIndex:i];
            
            CGSize oneTextSize = [subString sizeWithAttributes:attr];
            CGRect drawRect = CGRectInset(unitRect,
                                          (unitRect.size.width - oneTextSize.width) / 2,
                                          (unitRect.size.height - oneTextSize.height) / 2);
            [subString drawInRect:drawRect withAttributes:attr];
        } else {
            CGRect drawRect = CGRectInset(unitRect,
                                          (unitRect.size.width - _textFont.pointSize / 2) / 2,
                                          (unitRect.size.height - _textFont.pointSize / 2) / 2);
            [_textColor setFill];
            CGContextAddEllipseInRect(_ctx, drawRect);
            CGContextFillPath(_ctx);
        }
    }
    
}
- (void)_drawTrackBorder:(CGRect)rect unitSize:(CGSize)unitSize {
    if (_trackTintColor == nil) return;
    if (_unitSpace < 2) return;
    
    [_tintColor setStroke];
    for (int i = 0; i < _string.count; i++) {
        CGRect unitRect = CGRectMake(i * (unitSize.width + _unitSpace),
                                     0,
                                     unitSize.width,
                                     unitSize.height);
        unitRect = CGRectInset(unitRect, _borderWidth * 0.5, _borderWidth * 0.5);
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:unitRect cornerRadius:_borderRadius];
        CGContextAddPath(_ctx, bezierPath.CGPath);
    }
    CGContextDrawPath(_ctx, kCGPathStroke);
    
    [_trackTintColor setStroke];
    CGContextSetLineWidth(_ctx, _borderWidth);
    CGContextSetLineCap(_ctx, kCGLineCapRound);
    NSInteger count =  _string.count;
    if(count == (NSInteger)_inputUnitCount)  --count;
    if(count>=0) {
        CGRect unitRect = CGRectMake(count * (unitSize.width + _unitSpace),
                                     0,
                                     unitSize.width,
                                     unitSize.height);
        unitRect = CGRectInset(unitRect, _borderWidth * 0.5, _borderWidth * 0.5);
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:unitRect cornerRadius:_borderRadius];
        CGContextAddPath(_ctx, bezierPath.CGPath);
    }
    CGContextDrawPath(_ctx, kCGPathStroke);
    
}

- (void)_showOrHideCursorIfNeeded {
    _cursorLayer.hidden = !self.isFirstResponder || _cursorColor == nil || _inputUnitCount == _string.count;
    if (_cursorLayer.hidden) return;
    CGSize unitSize = CGSizeMake((self.bounds.size.width + _unitSpace) / _inputUnitCount - _unitSpace, self.bounds.size.height);
    CGRect unitRect = CGRectMake(_string.count * (unitSize.width + _unitSpace),
                                 0,
                                 unitSize.width,
                                 unitSize.height);
    unitRect = CGRectInset(unitRect,
                           unitRect.size.width / 2 - 1,
                           (unitRect.size.height - _textFont.pointSize) / 2);
    _cursorLayer.frame = unitRect;
}

#pragma mark - Input
- (BOOL)hasText {
    return _string != nil && _string.count > 0;
}

- (void)insertText:(NSString *)text {
    if (_string.count >= _inputUnitCount) {
        if (_autoResignFirstResponderWhenInputFinished == YES) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self resignFirstResponder];
            }];
        }
        return;
    }
    if ([text isEqualToString:@" "]) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(unitField:shouldChangeCharactersInRange:replacementString:)]) {
        if ([self.delegate unitField:self shouldChangeCharactersInRange:NSMakeRange(_string.count - 1, 1) replacementString:text] == NO) {
            return;
        }
    }
    NSRange range;
    for (int i = 0; i < text.length; i += range.length) {
        range = [text rangeOfComposedCharacterSequenceAtIndex:i];
        [_string addObject:[text substringWithRange:range]];
    }
    if (_string.count >= _inputUnitCount) {
        [_string removeObjectsInRange:NSMakeRange(_inputUnitCount, _string.count - _inputUnitCount)];
        [self sendActionsForControlEvents:UIControlEventEditingChanged];
        
        if (_autoResignFirstResponderWhenInputFinished == YES) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self resignFirstResponder];
            }];
        }
    } else {
        [self sendActionsForControlEvents:UIControlEventEditingChanged];
    }
    [self setNeedsDisplay];
    [self _showOrHideCursorIfNeeded];
}

- (void)deleteBackward {
    if ([self hasText] == NO)
        return;
    if ([self.delegate respondsToSelector:@selector(unitField:shouldChangeCharactersInRange:replacementString:)]) {
        if ([self.delegate unitField:self shouldChangeCharactersInRange:NSMakeRange(_string.count - 1, 0) replacementString:@""] == NO) {
            return;
        }
    }
    [_string removeLastObject];
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
    [self setNeedsDisplay];
    [self _showOrHideCursorIfNeeded];
}

- (UIKeyboardType)keyboardType {
    if (_defaultKeyboardType == JQKeyboardTypeASCIICapable) {
        return UIKeyboardTypeASCIICapable;
    }
    return UIKeyboardTypeNumberPad;
}

- (UIReturnKeyType)returnKeyType {
    return _defaultReturnKeyType;
}

@end
