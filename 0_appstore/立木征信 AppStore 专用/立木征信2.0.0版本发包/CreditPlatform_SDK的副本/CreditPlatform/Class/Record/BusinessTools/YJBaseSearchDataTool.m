//
//  YJBaseSearchDataTool.m
//  CreditPlatform
//
//  Created by yj on 16/8/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJBaseSearchDataTool.h"

@implementation YJBaseSearchDataTool
{
    BOOL _istimeOut;
    float circleTime;
    
}

- (void)addTimer {
    //没事设置就使用默认的时间。
    
    float firstTime=3;
    circleTime=3;
    _timeOut = 60;
    
    if (!_timer) {
        switch (_searchType) {
            case SearchItemTypeHousingFund:{//公积金
                firstTime = 7;
                circleTime = 3;
                _timeOut = 600;
                break;
                
            }case SearchItemTypeSocialSecurity:{//社保
                firstTime = 7;
                circleTime = 3;
                _timeOut = 600;
                break;
                
            }case SearchItemTypeOperators:{//运营商
                firstTime = 15;
                circleTime = 5;
                _timeOut = 600;
                break;
                
            }case SearchItemTypeCentralBank:{//央行
                firstTime = 6;
                circleTime = 2;
                _timeOut = 300;
                break;
                
            }case SearchItemTypeE_Commerce:{//电商
                firstTime = 13;
                circleTime = 2;
                _timeOut = 600;
                break;
                
            }case SearchItemTypeEducation:{//学历
                firstTime = 0;
                circleTime = 2;
                _timeOut = 300;
                break;
                
            }case SearchItemTypeTaoBao:{//淘宝
                firstTime = 10;
                circleTime = 5;
                _timeOut = 600;
                break;
                
            }case SearchItemTypeMaimai:{//脉脉
                firstTime = 0;
                circleTime = 2;
                _timeOut = 300;
                break;
                
            }case SearchItemTypeLinkedin:{//领英
                firstTime = 0;
                circleTime = 2;
                _timeOut = 300;
                break;
                
            }case SearchItemTypeCreditCardBill:{//信用卡 
                firstTime = 7;
                circleTime = 3;
                _timeOut = 300;

                break;
                
            }case SearchItemTypeLostCredit:{//失信
                firstTime = 7;
                circleTime = 3;
                _timeOut = 100;
                break;
                
            }case SearchItemTypeCarSafe:{//车险
                firstTime = 7;
                circleTime = 3;
                _timeOut = 300;
                break;
                
            }
            case SearchItemTypeNetBankBill:{//网银
                firstTime = 7;
                circleTime = 3;
                _timeOut = 300;

                break;
                
            }
            
            
            
            default:
                break;
        }
        
        [self requestData];
        [self performSelector:@selector(circleMethon:) withObject:[NSString stringWithFormat:@"%lf",circleTime] afterDelay:firstTime];
        
        //超时处理
        [self performSelector:@selector(removeTimerNow) withObject:nil afterDelay:_timeOut];
        _istimeOut =YES;

       

    }
}

#pragma mark - 超时逻辑
-(void)circleMethon:(NSString *)time{

    MYLog(@"-----circleMethon");
    _timer = [NSTimer timerWithTimeInterval:[time floatValue] target:self selector:@selector(requestData) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)removeTimerNow {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        
        if (self.searchFailure) {
            NSError *error = [NSError errorWithDomain:@"查询超时，请稍后重试。" code:ErrorCodeDelay userInfo:nil];
            self.searchFailure(error);
            [self removeTimer];
        }
        MYLog(@"查询超时，请稍后重试。");
    }
    
}



- (void)removeTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        MYLog(@"-----定时器移除");
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(removeTimerNow) object:nil];
     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(circleMethon:) object:[NSString stringWithFormat:@"%lf",circleTime]];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

}
- (void)requestData {

    
    
}

- (void)dealloc
{
    MYLog(@"----%@销毁了",self);
}
@end
