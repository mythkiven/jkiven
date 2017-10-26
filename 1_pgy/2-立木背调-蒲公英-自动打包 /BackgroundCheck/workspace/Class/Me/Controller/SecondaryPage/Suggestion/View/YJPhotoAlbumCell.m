//
//  YJPhotoAlbumCell.m
//  CreditPlatform
//
//  Created by yj on 16/9/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJPhotoAlbumCell.h"
#import "YJPhotoItemModel.h"
#import "YJPhotoView.h"




@interface YJPhotoAlbumCell ()

@property (strong, nonatomic) YJPhotoView *PhotoView;

@property (strong, nonatomic) UIButton *selectedPhoto;




@end
@implementation YJPhotoAlbumCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.PhotoView = [[YJPhotoView alloc] init];
        

        [self addSubview:_PhotoView];
    }
    return self;
}

- (void)setItemModel:(YJPhotoItemModel *)itemModel {
    _itemModel = itemModel;
//    self.PhotoView.image = itemModel.photo;

    
//    self.PhotoView.image = [UIImage imageWithCGImage:itemModel.asset.defaultRepresentation.fullScreenImage];
//    self.PhotoView.image = [UIImage imageWithCGImage:itemModel.asset.defaultRepresentation.fullResolutionImage];
    
    self.PhotoView.image = [UIImage imageWithCGImage:itemModel.asset.aspectRatioThumbnail];


    self.PhotoView.selected = itemModel.isSelected;

}






- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.PhotoView.frame = self.bounds;
    
}

@end


