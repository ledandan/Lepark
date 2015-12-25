//
//  UIImage_extra.m
//  SmartBattery
//  MissionSky-iOS
//

#import "UIImage_extra.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (extra)

/**
 @brief 根据图片名对图片进行偏移
 @param name 图片名.如：back_button#0_18_0_1#.png，将按0,18,0,1四个方向对这张图片进行偏移
 @result UIImage 按指定偏移修改后的图片
 */
+ (UIImage *)imageScaleNamed:(NSString *)name
{
    UIImage *img = [UIImage imageNamed:name];
    NSArray *arr1 = [name componentsSeparatedByString:@"#"];
    if (arr1 && [arr1 count]== 3) {
        NSString *tmpStr = [arr1 objectAtIndex:1];
        NSArray *arr2 = [tmpStr componentsSeparatedByString:@"_"];
        if ([arr2 count]== 4) {
            {
                UIEdgeInsets edgeInsets = UIEdgeInsetsMake([[arr2 objectAtIndex:0] doubleValue], [[arr2 objectAtIndex:1] doubleValue], [[arr2 objectAtIndex:2] doubleValue], [[arr2 objectAtIndex:3] doubleValue]);
                img = [img resizableImageWithCapInsets:edgeInsets];
            }
        }
    }
    return img;
}

/**
 @brief 等比率缩放
 @param scaleSize 缩放比例(float),0~1为缩小，1以上为放大
 @result UIImage 按指定比率缩放修改后的图片
 */
- (UIImage *)scaleImageToScale:(float)scaleSize
{
    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize);
    rect = CGRectIntegral(rect);
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:rect];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/**
 @brief 自定图片长宽
 @param reSize 自定图片长宽的CGSize
 @result UIImage 按指定长宽修改后的图片
 */
- (UIImage *)reSizeImageToSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

/**
 @brief 获取经过模糊处理的图片
 @param blur 模糊半径，取值范围0.05~2.0
 @result UIImage 经过模糊处理后的图片，blur小于0.05时，返回原图，大于2.0时，返回blur=2.0的图片
 */
- (UIImage *)blurWithLevel:(CGFloat)blur
{
    if (blur < 0.05f) {
        return self;
    }
    
    if (blur > 2.0f) {
        blur = 2.0f;
    }
    
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img)*10);
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend|kvImageNoAllocate);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(self.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
@end
