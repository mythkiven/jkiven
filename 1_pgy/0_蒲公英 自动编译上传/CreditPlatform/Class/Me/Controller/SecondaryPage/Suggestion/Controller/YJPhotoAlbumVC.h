//
//  YJPhotoAlbumVC.h
//  CreditPlatform
//
//  Created by yj on 16/9/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YJPhotosBlock)(NSMutableArray *photoBase64Arr);

@interface YJPhotoAlbumVC : UIViewController

@property (nonatomic, assign) int totalCount;

@property (nonatomic, copy) YJPhotosBlock photosBlock;

@end
