//
//  JETextFiled.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/19.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "JETextFiled.h"

@implementation JETextFiled

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))
        return NO;
    if (action == @selector(select:))
        return NO;
    if (action == @selector(selectAll:)) 
        return NO;
    return [super canPerformAction:action withSender:sender];
}

@end
