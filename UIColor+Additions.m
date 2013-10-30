//
//  UIColor+Additions.m
//  Created by Joan Martin.
//  Take a look to my repos at http://github.com/vilanovi
//
// Copyright (c) 2013 Joan Martin, vilanovi@gmail.com.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is furnished to do
// so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (UIColor*)colorWithRGBHex:(unsigned int)rgbValue
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF))/255.0
                           alpha:1.0];
}

+ (UIColor*)colorWithRGBAHex:(unsigned long)rgbaValue
{
    return [UIColor colorWithRed:((float)((rgbaValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbaValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbaValue & 0xFF))/255.0
                           alpha:((float)((rgbaValue & 0xFF000000) >> 24))/255.0];
}

+ (UIColor*)colorWithRGBHexString:(NSString*)rgbStrValue
{
    unsigned int rgbHexValue;
    
    NSScanner* scanner = [NSScanner scannerWithString:rgbStrValue];
    BOOL successful = [scanner scanHexInt:&rgbHexValue];
    
    if (!successful)
        return nil;
    
    return [self colorWithRGBHex:rgbHexValue];
}

+ (UIColor*)colorWithRGBAHexString:(NSString*)rgbaStrValue
{
    unsigned long long rgbHexValue;
    
    NSScanner* scanner = [NSScanner scannerWithString:rgbaStrValue];
    BOOL successful = [scanner scanHexLongLong:&rgbHexValue];
    
    if (!successful)
        return nil;
    
    return [self colorWithRGBAHex:rgbHexValue];
}

+ (UIColor*)colorWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue alpha255:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
}

- (BOOL)getRGBHex:(unsigned int*)rgbHex
{
    CGFloat rFloat, gFloat, bFloat, aFloat;
    BOOL compatible = [self getRed:&rFloat green:&gFloat blue:&bFloat alpha:&aFloat];
    
    if (!compatible)
        return NO;
    
    int r = (int)roundf(rFloat*255.0f);
    int g = (int)roundf(gFloat*255.0f);
    int b = (int)roundf(bFloat*255.0f);

    *rgbHex = (b) + (g << 8) + (r << 16);
    
    return YES;
}

- (BOOL)getRGBAHex:(unsigned long*)rgbaHex;
{
    CGFloat rFloat, gFloat, bFloat, aFloat;
    BOOL compatible = [self getRed:&rFloat green:&gFloat blue:&bFloat alpha:&aFloat];
    
    if (!compatible)
        return NO;
    
    unsigned long r = (unsigned long)roundf(rFloat*255.0f);
    unsigned long g = (unsigned long)roundf(gFloat*255.0f);
    unsigned long b = (unsigned long)roundf(bFloat*255.0f);
    unsigned long a = (unsigned long)roundf(aFloat*255.0f);
    
    *rgbaHex = (b) + (g << 8) + (r << 16) + (a << 24);
    
    return YES;
}

- (NSString*)RGBHexString
{
    unsigned int value = 0;
    BOOL compatible = [self getRGBHex:&value];
    
    if (!compatible)
        return nil;
    
    return [NSString stringWithFormat:@"%x", value];
}

- (NSString*)RGBAHexString
{
    unsigned long value = 0;
    BOOL compatible = [self getRGBAHex:&value];
    
    if (!compatible)
        return nil;
    
    return [NSString stringWithFormat:@"%lx", value];
}

- (UIColor*)colorWithSaturation:(CGFloat)newSaturation
{
    CGFloat hue,saturation,brightness,alpha;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    return [UIColor colorWithHue:hue saturation:newSaturation brightness:brightness alpha:alpha];
}

- (UIColor*)colorWithBrightness:(CGFloat)newBrightness
{
    CGFloat hue,saturation,brightness,alpha;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:newBrightness alpha:alpha];
}


- (UIColor *)lightenColorWithValue:(CGFloat)value
{
    int totalComponents = CGColorGetNumberOfComponents(self.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat *oldComponents = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat newComponents[4];
    
    if(isGreyscale) {
        newComponents[0] = oldComponents[0] + value > 1.0 ? 1.0 : oldComponents[0] + value;
        newComponents[1] = oldComponents[0] + value > 1.0 ? 1.0 : oldComponents[0] + value;
        newComponents[2] = oldComponents[0] + value > 1.0 ? 1.0 : oldComponents[0] + value;
        newComponents[3] = oldComponents[1];
    }
    else {
        newComponents[0] = oldComponents[0] + value > 1.0 ? 1.0 : oldComponents[0] + value;
        newComponents[1] = oldComponents[1] + value > 1.0 ? 1.0 : oldComponents[1] + value;
        newComponents[2] = oldComponents[2] + value > 1.0 ? 1.0 : oldComponents[2] + value;
        newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
    return retColor;
}

- (UIColor *)darkenColorWithValue:(CGFloat)value
{
    int totalComponents = CGColorGetNumberOfComponents(self.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat *oldComponents = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat newComponents[4];
    
    if(isGreyscale) {
        newComponents[0] = oldComponents[0] - value < 0.0 ? 0.0 : oldComponents[0] - value;
        newComponents[1] = oldComponents[0] - value < 0.0 ? 0.0 : oldComponents[0] - value;
        newComponents[2] = oldComponents[0] - value < 0.0 ? 0.0 : oldComponents[0] - value;
        newComponents[3] = oldComponents[1];
    }
    else {
        newComponents[0] = oldComponents[0] - value < 0.0 ? 0.0 : oldComponents[0] - value;
        newComponents[1] = oldComponents[1] - value < 0.0 ? 0.0 : oldComponents[1] - value;
        newComponents[2] = oldComponents[2] - value < 0.0 ? 0.0 : oldComponents[2] - value;
        newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
    return retColor;
}

- (BOOL)isLightColor
{
    int totalComponents = CGColorGetNumberOfComponents(self.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat *components = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat sum;
    
    if(isGreyscale) {
        sum = components[0];
    }
    else {
        sum = (components[0] + components[1] + components[2]) / 3.0f;
    }
    
    return (sum > 0.8f);
}

@end
