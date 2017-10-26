//
//  YJALbumItemModel.h
//  CreditPlatform
//
//  Created by yj on 16/10/11.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface YJPhotoItemModel : NSObject
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) UIImage *photo;

@property (nonatomic, strong) ALAsset *asset;

@property (nonatomic, copy) NSString *base64ImageStr;

@end
