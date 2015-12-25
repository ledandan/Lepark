//
//  UIImage_extra.h
//  SmartBattery
//  MissionSky-iOS
//
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface UIImage (extra)
/**
 @brief 根据图片名对图片进行偏移
 @param name 图片名.如：back_button#0_18_0_1#.png，将按0,18,0,1四个方向对这张图片进行偏移
 @result UIImage 按指定偏移修改后的图片
 */
+ (UIImage *)imageScaleNamed:(NSString *)name;

/**
 @brief 等比率缩放
 @param scaleSize 缩放比例(float),0~1为缩小，1以上为放大
 @result UIImage 按指定比率缩放修改后的图片
 */
- (UIImage *)scaleImageToScale:(float)scaleSize;

/**
 @brief 自定图片长宽
 @param reSize 自定图片长宽的CGSize
 @result UIImage 按指定长宽修改后的图片
 */
- (UIImage *)reSizeImageToSize:(CGSize)reSize;

/**
 @brief 获取经过模糊处理的图片
 @param blur 模糊半径，取值范围0.05~2.0
 @result UIImage 经过模糊处理后的图片，blur小于0.05时，返回原图，大于2.0时，返回blur=2.0的图片
 */
- (UIImage *)blurWithLevel:(CGFloat)blur;

@end
