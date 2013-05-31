//
//  UIColor+Additions.h
//  Created by Joan Martin.
//  Take a look to my repos at http://github.com/vilanovi
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+ (UIColor*)colorWithRGBHex:(int)rgbValue;
+ (UIColor*)colorWithRGBAHex:(int)rgbaValue;
+ (UIColor*)colorWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue alpha255:(CGFloat)alpha;

- (UIColor*)colorWithSaturation:(CGFloat)newSaturation;
- (UIColor*)colorWithBrightness:(CGFloat)newBrightness;

- (UIColor *)lightenColorWithValue:(CGFloat)value;
- (UIColor *)darkenColorWithValue:(CGFloat)value;
- (BOOL)isLightColor;

@end
