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

#define ADD_RED_MASK        0xFF0000
#define ADD_GREEN_MASK      0xFF00
#define ADD_BLUE_MASK       0xFF
#define ADD_ALPHA_MASK      0xFF000000

#define ADD_RED_SHIFT       16
#define ADD_GREEN_SHIFT     8
#define ADD_BLUE_SHIFT      0
#define ADD_ALPHA_SHIFT     24

#define ADD_COLOR_SIZE      255.0

#define ADD_LUM_RED         0.2989
#define ADD_LUM_GREEN       0.5870
#define ADD_LUM_BLUE        0.1140

@implementation UIColor (Additions)

+ (UIColor*)add_colorWithRGBHexValue:(ADDColorType)rgbValue
{
    return [UIColor colorWithRed:((CGFloat)((rgbValue & ADD_RED_MASK) >> ADD_RED_SHIFT))/ADD_COLOR_SIZE
                           green:((CGFloat)((rgbValue & ADD_GREEN_MASK) >> ADD_GREEN_SHIFT))/ADD_COLOR_SIZE
                            blue:((CGFloat)((rgbValue & ADD_BLUE_MASK) >> ADD_BLUE_SHIFT))/ADD_COLOR_SIZE
                           alpha:1.0];
}

+ (UIColor*)add_colorWithRGBAHexValue:(ADDColorType)rgbaValue
{
    return [UIColor colorWithRed:((CGFloat)((rgbaValue & ADD_RED_MASK) >> ADD_RED_SHIFT))/ADD_COLOR_SIZE
                           green:((CGFloat)((rgbaValue & ADD_GREEN_MASK) >> ADD_GREEN_SHIFT))/ADD_COLOR_SIZE
                            blue:((CGFloat)((rgbaValue & ADD_BLUE_MASK) >> ADD_BLUE_SHIFT))/ADD_COLOR_SIZE
                           alpha:((CGFloat)((rgbaValue & ADD_ALPHA_MASK) >> ADD_ALPHA_SHIFT))/ADD_COLOR_SIZE];
}

+ (UIColor*)add_colorWithRGBHexString:(NSString*)rgbStrValue
{
    ADDColorType rgbHexValue;
    
    NSScanner* scanner = [NSScanner scannerWithString:rgbStrValue];
    BOOL successful = [scanner scanHexInt:&rgbHexValue];
    
    if (!successful)
        return nil;
    
    return [self add_colorWithRGBHexValue:rgbHexValue];
}

+ (UIColor*)add_colorWithRGBAHexString:(NSString*)rgbaStrValue
{
    ADDColorType rgbHexValue;
    
    NSScanner *scanner = [NSScanner scannerWithString:rgbaStrValue];
    BOOL successful = [scanner scanHexInt:&rgbHexValue];
    
    if (!successful)
        return nil;
    
    return [self add_colorWithRGBAHexValue:rgbHexValue];
}

- (BOOL)add_getRGBHexValue:(ADDColorType*)rgbHex
{
    size_t numComponents = CGColorGetNumberOfComponents(self.CGColor);
    CGFloat const * components = CGColorGetComponents(self.CGColor);
    
    if (numComponents == 4)
    {
        CGFloat rFloat = components[0]; // red
        CGFloat gFloat = components[1]; // green
        CGFloat bFloat = components[2]; // blue
        
        ADDColorType r = (ADDColorType)roundf(rFloat*ADD_COLOR_SIZE);
        ADDColorType g = (ADDColorType)roundf(gFloat*ADD_COLOR_SIZE);
        ADDColorType b = (ADDColorType)roundf(bFloat*ADD_COLOR_SIZE);
        
        *rgbHex = (r << ADD_RED_SHIFT) + (g << ADD_GREEN_SHIFT) + (b << ADD_BLUE_SHIFT);
        
        return YES;
    }
    else if (numComponents == 2)
    {
        CGFloat gFloat = components[0]; // gray
        
        ADDColorType g = (ADDColorType)roundf(gFloat*ADD_COLOR_SIZE);
        
        *rgbHex = (g << ADD_RED_SHIFT) + (g << ADD_GREEN_SHIFT) + (g << ADD_BLUE_SHIFT);
        
        return YES;
    }
    
    return NO;
}

- (BOOL)add_getRGBAHexValue:(ADDColorType*)rgbaHex;
{
    size_t numComponents = CGColorGetNumberOfComponents(self.CGColor);
    CGFloat const * components = CGColorGetComponents(self.CGColor);
    
    if (numComponents == 4)
    {
        CGFloat rFloat = components[0]; // red
        CGFloat gFloat = components[1]; // green
        CGFloat bFloat = components[2]; // blue
        CGFloat aFloat = components[3]; // alpha
        
        ADDColorType r = (ADDColorType)roundf(rFloat*ADD_COLOR_SIZE);
        ADDColorType g = (ADDColorType)roundf(gFloat*ADD_COLOR_SIZE);
        ADDColorType b = (ADDColorType)roundf(bFloat*ADD_COLOR_SIZE);
        ADDColorType a = (ADDColorType)roundf(aFloat*ADD_COLOR_SIZE);
        
        *rgbaHex = (r << ADD_RED_SHIFT) + (g << ADD_GREEN_SHIFT) + (b << ADD_BLUE_SHIFT) + (a << ADD_ALPHA_SHIFT);
        
        return YES;
    }
    else if (numComponents == 2)
    {
        CGFloat gFloat = components[0]; // gray
        CGFloat aFloat = components[1]; // alpha
        
        ADDColorType g = (ADDColorType)roundf(gFloat*ADD_COLOR_SIZE);
        ADDColorType a = (ADDColorType)roundf(aFloat *ADD_COLOR_SIZE);
        
        *rgbaHex = (g << ADD_RED_SHIFT) + (g << ADD_GREEN_SHIFT) + (g << ADD_BLUE_SHIFT) + (a << ADD_ALPHA_SHIFT);
        
        return YES;
    }
    
    return NO;
}

- (ADDColorType)add_RGBHexValue
{
    return 0;
}

- (ADDColorType)add_RGBAHexValue
{
    return 0;
}

- (NSString*)add_RGBHexString
{
    ADDColorType value = 0;
    BOOL compatible = [self add_getRGBHexValue:&value];
    
    if (!compatible)
        return nil;
    
    return [NSString stringWithFormat:@"%x", value];
}

- (NSString*)add_RGBAHexString
{
    ADDColorType value = 0;
    BOOL compatible = [self add_getRGBAHexValue:&value];
    
    if (!compatible)
        return nil;
    
    return [NSString stringWithFormat:@"%x", value];
}


+ (UIColor*)add_colorWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue
{
    return [self add_colorWithRed255:red green255:green blue255:blue alpha255:ADD_COLOR_SIZE];
}

+ (UIColor*)add_colorWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue alpha255:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/ADD_COLOR_SIZE green:green/ADD_COLOR_SIZE blue:blue/ADD_COLOR_SIZE alpha:alpha/ADD_COLOR_SIZE];
}

- (UIColor*)add_grayColor
{
    size_t totalComponents = CGColorGetNumberOfComponents(self.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat const * components = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat luminiscence = 0.0;
    CGFloat alpha = 1.0;
    
    if (isGreyscale)
    {
        luminiscence = components[0];
        alpha = components[1];
    }
    else
    {
        luminiscence = components[0]*ADD_LUM_RED + components[1]*ADD_LUM_GREEN + components[2]*ADD_LUM_BLUE;
        alpha = components[3];
    }
    
    return [UIColor colorWithWhite:luminiscence alpha:alpha];
}

- (UIColor*)add_colorWithSaturation:(CGFloat)newSaturation
{
    CGFloat hue,saturation,brightness,alpha;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    return [UIColor colorWithHue:hue saturation:newSaturation brightness:brightness alpha:alpha];
}

- (UIColor*)add_colorWithBrightness:(CGFloat)newBrightness
{
    CGFloat hue,saturation,brightness,alpha;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:newBrightness alpha:alpha];
}


- (UIColor*)add_lighterColorWithValue:(CGFloat)value
{
    size_t totalComponents = CGColorGetNumberOfComponents(self.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat const * oldComponents = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat newComponents[4];
    
    CGFloat (^actionBlock)(CGFloat component) = ^CGFloat(CGFloat component) {
        
        CGFloat offset = 1.0 - component;
        CGFloat newComponent = component + offset*value;
        
        // CGFloat newComponent = component + value > 1.0 ? 1.0 : component + value;
        
        return newComponent;
    };
    
    if (isGreyscale)
    {
        newComponents[0] = actionBlock(oldComponents[0]);
        newComponents[1] = actionBlock(oldComponents[0]);
        newComponents[2] = actionBlock(oldComponents[0]);
        newComponents[3] = oldComponents[1];
    }
    else
    {
        newComponents[0] = actionBlock(oldComponents[0]);
        newComponents[1] = actionBlock(oldComponents[1]);
        newComponents[2] = actionBlock(oldComponents[2]);
        newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
    return retColor;
}

- (UIColor*)add_darkerColorWithValue:(CGFloat)value
{
    size_t totalComponents = CGColorGetNumberOfComponents(self.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat const * oldComponents = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat newComponents[4];
    
    CGFloat (^actionBlock)(CGFloat component) = ^CGFloat(CGFloat component) {
        
        CGFloat newComponent = component * (1.0 - value);
        
        // CGFloat newComponent = component - value < 0.0 ? 0.0 : component - value;
        
        return newComponent;
    };
    
    if (isGreyscale)
    {
        newComponents[0] = actionBlock(oldComponents[0]);
        newComponents[1] = actionBlock(oldComponents[0]);
        newComponents[2] = actionBlock(oldComponents[0]);
		newComponents[3] = oldComponents[1];
    }
    else
    {
        newComponents[0] = actionBlock(oldComponents[0]);
        newComponents[1] = actionBlock(oldComponents[1]);
        newComponents[2] = actionBlock(oldComponents[2]);
		newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
    return retColor;
}

- (BOOL)add_isLightColor
{
    size_t totalComponents = CGColorGetNumberOfComponents(self.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat const * components = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat sum;
    
    if (isGreyscale)
        sum = components[0];
    else
        sum = components[0]*ADD_LUM_RED + components[1]*ADD_LUM_GREEN + components[2]*ADD_LUM_BLUE;
    
    return (sum > 0.8f);
}

- (BOOL)add_isDarkColor
{
    return ![self add_isLightColor];
}

@end
