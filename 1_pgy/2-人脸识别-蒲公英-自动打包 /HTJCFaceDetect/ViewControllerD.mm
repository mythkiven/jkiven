//
//  ViewControllerD.m
//  HTJCFaceDetect
//
//  Created by 臣孙 on 16/9/23.
//  Copyright © 2016年 SJC. All rights reserved.
//

#import "ViewControllerD.h"

#import <HTJCFaceLiveDetectSdk/THIDMCHTJCViewManger.h>

@interface ViewControllerD ()

@end

@implementation ViewControllerD

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)HTJC:(UIViewController *)ctl {
    THIDMCHTJCViewManger *manager = [THIDMCHTJCViewManger sharedManager:ctl];
    [manager getLiveDetectCompletion:^(BOOL sueccess, NSData *imageData) {
        [manager dismissTakeCaptureSessionViewController];
    }
                              cancel:^(BOOL sueccess, NSString *error) {
                              }
                              failed:^(NSString *error) {
                                  
                              }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
