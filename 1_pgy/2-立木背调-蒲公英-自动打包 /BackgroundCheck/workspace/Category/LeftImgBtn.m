//
//  LeftImgBtn.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LeftImgBtn.h"
#define ImageW  10
// 10*5
@implementation LeftImgBtn

-(instancetype)init{
    if (self = [super init]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.contentMode = UIViewContentModeCenter;
    }
    return self;
}
//-(void)setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets{
////    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, imageWith);
//}
//-(void)setImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets{
////        self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
//}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW = contentRect.size.width-ImageW;
    CGFloat titleH = contentRect.size.height;
    MYLog(@"---------%lf",titleW);
    
    
    
    
    return CGRectMake(titleW/2-ImageW/2, 0, titleW, titleH);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//    CGFloat imageW = ImageW;
    CGFloat imageH = contentRect.size.height  ;
    
   
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName];
    CGSize size = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    
//    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    
//    CGFloat Width =self.titleLabel.text.length*15/2;
    
    CGFloat imageX = contentRect.size.width/2+size.width/2+10;
    //self.imageView.contentMode = UIViewContentModeCenter;
//    return CGRectMake(imageX/2+30,0, imageW, imageH);
//    MYLog(@"++++++++++++++%@-%@",self.titleLabel.text,self.titleLabel.font);
    
    return CGRectMake(imageX,imageH/2-5/2, ImageW, 5);
}

-(void)setHighlighted:(BOOL)highlighted{
}
@end




