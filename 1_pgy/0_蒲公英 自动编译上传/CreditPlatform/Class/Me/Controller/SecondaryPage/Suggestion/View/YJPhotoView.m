//
//  YJPhotoView.m
//  CreditPlatform
//
//  Created by yj on 16/10/11.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJPhotoView.h"
@interface YJPhotoView  ()
{
    UIButton *_selectedIcon;
}


@end

@implementation YJPhotoView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.highlighted = NO;
        
        _selectedIcon  = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _selectedIcon.userInteractionEnabled = NO;
        [_selectedIcon setImage:[UIImage imageNamed:@"icon_photo_normal"] forState:(UIControlStateNormal)];
        [_selectedIcon setImage:[UIImage imageNamed:@"icon_photo_selected"] forState:(UIControlStateSelected)];
        [self addSubview:_selectedIcon];

        

        
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    _selectedIcon.selected = selected;

}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _selectedIcon.frame = CGRectMake(self.bounds.size.width - 23-2, 2, 23, 23);
    
//    _selectedIcon.sd_layout.
//    rightSpaceToView(self,2).
//    topSpaceToView(self,2)
//    .heightIs(23)
//    .widthIs(23);
    
}
@end
