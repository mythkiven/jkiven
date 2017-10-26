
#import <UIKit/UIKit.h>

@interface LMZXColorImageView : UIImageView


@property (copy, nonatomic) void(^currentColorBlock)(UIColor *color);

@property (copy, nonatomic) void(^currentColorBlock1)(NSDictionary *RGB);



@end
