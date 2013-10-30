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

#define RED_MASK 0xFF0000
#define GREEN_MASK 0xFF00
#define BLUE_MASK 0xFF
#define ALPHA_MASK 0xFF000000

#define RED_SHIFT 16
#define GREEN_SHIFT 8
#define BLUE_SHIFT 0
#define ALPHA_SHIFT 24

#define COLOR_SIZE 255.0f

@implementation UIColor (Additions)

+ (UIColor*)colorWithRGBHex:(unsigned int)rgbValue
{
    return [UIColor colorWithRed:((float)((rgbValue & RED_MASK) >> RED_SHIFT))/COLOR_SIZE
                           green:((float)((rgbValue & GREEN_MASK) >> GREEN_SHIFT))/COLOR_SIZE
                            blue:((float)((rgbValue & BLUE_MASK) >> BLUE_SHIFT))/COLOR_SIZE
                           alpha:1.0];
}

+ (UIColor*)colorWithRGBAHex:(unsigned int)rgbaValue
{
    return [UIColor colorWithRed:((float)((rgbaValue & RED_MASK) >> RED_SHIFT))/COLOR_SIZE
                           green:((float)((rgbaValue & GREEN_MASK) >> GREEN_SHIFT))/COLOR_SIZE
                            blue:((float)((rgbaValue & BLUE_MASK) >> BLUE_SHIFT))/COLOR_SIZE
                           alpha:((float)((rgbaValue & ALPHA_MASK) >> ALPHA_SHIFT))/COLOR_SIZE];
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
    unsigned int rgbHexValue;
    
    NSScanner* scanner = [NSScanner scannerWithString:rgbaStrValue];
    BOOL successful = [scanner scanHexInt:&rgbHexValue];
    
    if (!successful)
        return nil;
    
    return [self colorWithRGBAHex:rgbHexValue];
}

+ (UIColor*)colorWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue alpha255:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/COLOR_SIZE green:green/COLOR_SIZE blue:blue/COLOR_SIZE alpha:alpha/COLOR_SIZE];
}

- (BOOL)getRGBHex:(unsigned int*)rgbHex
{
    int numComponents = CGColorGetNumberOfComponents(self.CGColor);
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    if (numComponents == 4)
    {
        CGFloat rFloat = components[0]; // red
        CGFloat gFloat = components[1]; // green
        CGFloat bFloat = components[2]; // blue
        
        unsigned int r = (unsigned int)roundf(rFloat*COLOR_SIZE);
        unsigned int g = (unsigned int)roundf(gFloat*COLOR_SIZE);
        unsigned int b = (unsigned int)roundf(bFloat*COLOR_SIZE);
        
        *rgbHex = (r << RED_SHIFT) + (g << GREEN_SHIFT) + (b << BLUE_SHIFT);
        
        return YES;
    }
    else if (numComponents == 2)
    {
        CGFloat gFloat = components[0]; // gray
        
        unsigned int g = (unsigned int)roundf(gFloat*COLOR_SIZE);
        
        *rgbHex = (g << RED_SHIFT) + (g << GREEN_SHIFT) + (g << BLUE_SHIFT);
        
        return YES;
    }
    
    return NO;
}

- (BOOL)getRGBAHex:(unsigned int*)rgbaHex;
{
    int numComponents = CGColorGetNumberOfComponents(self.CGColor);
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    if (numComponents == 4)
    {
        CGFloat rFloat = components[0]; // red
        CGFloat gFloat = components[1]; // green
        CGFloat bFloat = components[2]; // blue
        CGFloat aFloat = components[3]; // alpha
        
        unsigned int r = (unsigned int)roundf(rFloat*COLOR_SIZE);
        unsigned int g = (unsigned int)roundf(gFloat*COLOR_SIZE);
        unsigned int b = (unsigned int)roundf(bFloat*COLOR_SIZE);
        unsigned int a = (unsigned int)roundf(aFloat*COLOR_SIZE);
        
        *rgbaHex = (r << RED_SHIFT) + (g << GREEN_SHIFT) + (b << BLUE_SHIFT) + (a << ALPHA_SHIFT);
        
        return YES;
    }
    else if (numComponents == 2)
    {
        CGFloat gFloat = components[0]; // gray
        CGFloat aFloat = components[1]; // alpha
        
        unsigned int g = (unsigned int)roundf(gFloat*COLOR_SIZE);
        unsigned int a = (unsigned int)roundf(aFloat *COLOR_SIZE);
        
        *rgbaHex = (g << RED_SHIFT) + (g << GREEN_SHIFT) + (g << BLUE_SHIFT) + (a << ALPHA_SHIFT);
        
        return YES;
    }
    
    return NO;
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
    unsigned int value = 0;
    BOOL compatible = [self getRGBAHex:&value];
    
    if (!compatible)
        return nil;
    
    return [NSString stringWithFormat:@"%x", value];
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


- (UIColor*)lightenColorWithValue:(CGFloat)value
{
    int totalComponents = CGColorGetNumberOfComponents(self.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat *oldComponents = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat newComponents[4];
    
    if(isGreyscale)
    {
        newComponents[0] = oldComponents[0] + value > 1.0 ? 1.0 : oldComponents[0] + value;
        newComponents[1] = oldComponents[0] + value > 1.0 ? 1.0 : oldComponents[0] + value;
        newComponents[2] = oldComponents[0] + value > 1.0 ? 1.0 : oldComponents[0] + value;
        newComponents[3] = oldComponents[1];
    }
    else
    {
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

- (UIColor*)darkenColorWithValue:(CGFloat)value
{
    int totalComponents = CGColorGetNumberOfComponents(self.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat *oldComponents = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat newComponents[4];
    
    if(isGreyscale)
    {
        newComponents[0] = oldComponents[0] - value < 0.0 ? 0.0 : oldComponents[0] - value;
        newComponents[1] = oldComponents[0] - value < 0.0 ? 0.0 : oldComponents[0] - value;
        newComponents[2] = oldComponents[0] - value < 0.0 ? 0.0 : oldComponents[0] - value;
        newComponents[3] = oldComponents[1];
    }
    else
    {
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
    
    if(isGreyscale)
        sum = components[0];
    else
        sum = (components[0] + components[1] + components[2]) / 3.0f;
    
    return (sum > 0.8f);
}

@end
