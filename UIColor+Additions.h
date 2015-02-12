//
//  UIColor+Additions.h
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

#import <UIKit/UIKit.h>

/**
 * The color type (unsigned int).
 **/
typedef unsigned int ColorType;

/**
 * Category on `UIColor` that add convenience methods to manipulate colors.
 **/
@interface UIColor (Additions)

/** *************************************************** **
 * @name Hexadecimal support
 ** *************************************************** **/

/**
 * Creates a color from a RGB hexadecimal integer value.
 * @param rgbValue The RGB color represented in an hexadecimal integer.
 * @return The `UIColor` instance.
 **/
+ (UIColor*)colorWithRGBHexValue:(ColorType)rgbHexValue;

/**
 * Creates a color from a RGBA hexadecimal integer value.
 * @param rgbValue The RGBA color represented in an hexadecimal integer.
 * @return The `UIColor` instance.
 **/
+ (UIColor*)colorWithRGBAHexValue:(ColorType)rgbaHexValue;

/**
 * Creates a color from a RGB hexadecimal string value.
 * @param rgbValue The RGB color represented in an hexadecimal string.
 * @return The `UIColor` instance.
 **/
+ (UIColor*)colorWithRGBHexString:(NSString*)rgbHexString;

/**
 * Creates a color from a RGBA hexadecimal string value.
 * @param rgbValue The RGBA color represented in an hexadecimal string.
 * @return The `UIColor` instance.
 **/
+ (UIColor*)colorWithRGBAHexString:(NSString*)rgbaHexString;

/**
 * Retrieves the RGB hexadecimal integer value.
 * @param rgbHexValue A pointer to an integer where the value will be written.
 * @return YES if the color description could have been retrevied, otherwise NO.
 **/
- (BOOL)getRGBHexValue:(ColorType*)rgbHexValue;

/**
 * Retrieves the RGBA hexadecimal integer value.
 * @param rgbaHexValue A pointer to an integer where the value will be written.
 * @return YES if the color description could have been retrevied, otherwise NO.
 **/
- (BOOL)getRGBAHexValue:(ColorType*)rgbaHexValue;

/**
 * Retrieves the RGB hexadecimal string value.
 * @return The RGB hexadecimal string representation or nil.
 **/
- (NSString*)RGBHexString;

/**
 * Retrieves the RGBA hexadecimal string value.
 * @return The RGBA hexadecimal string representation or nil.
 **/
- (NSString*)RGBAHexString;

/** *************************************************** **
 * @name RGB support
 ** *************************************************** **/

/**
 * Creates a color from RGB (0-255 range) values.
 * @param red The red value in 0-255 range.
 * @param green The green value in 0-255 range.
 * @param blue The blue value in 0-255 range.
 * @return The new color from the RGB values.
 **/
+ (UIColor*)colorWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue;

/**
 * Creates a color from RGBA (0-255 range) values.
 * @param red The red value in 0-255 range.
 * @param green The green value in 0-255 range.
 * @param blue The blue value in 0-255 range.
 * @param alpha The alpha value in 0-255 range.
 * @return The new color from the RGB values.
 **/
+ (UIColor*)colorWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue alpha255:(CGFloat)alpha;

/** *************************************************** **
 * @name Luminiscence
 ** *************************************************** **/

/**
 * Converts the current color into grayscale.
 * @return The new grayscale color.
 * @discussion This method uses the formula of luminiscence of L=R*0.2989+G*0.5870+B*0.1140.
 **/
- (UIColor*)grayColor;

/**
 * A convenience method that indicates if a color is considered "light".
 * @return YES if the color is considered "light", NO otherwise.
 **/
- (BOOL)isLightColor;

/**
 * A convenience method that indicates if a color is considered "dark".
 * @return YES if the color is considered "dark", NO otherwise.
 **/
- (BOOL)isDarkColor;

/** *************************************************** **
 * @name Modifying colors
 ** *************************************************** **/

/**
 * Creates a new color from the current one by changing the saturation.
 * @param newSaturation 
 * @return A new color.
 **/
- (UIColor*)colorWithSaturation:(CGFloat)newSaturation;

/**
 * Creates a new color from the current one by changing the brightness.
 * @param newBrightness
 * @return A new color.
 **/
- (UIColor*)colorWithBrightness:(CGFloat)newBrightness;

/**
 * Creates a new lighter color.
 * @param value Float value from 0 to 1 where 0 means no change and 1 means the lightest possible color.
 * @return A new color.
 **/
- (UIColor*)lighterColorWithValue:(CGFloat)value;

/**
 * Creates a new darker color.
 * @param value Float value from 0 to 1 where 0 means no change and 1 means the darkest possible color.
 * @return A new color.
 **/
- (UIColor*)darkerColorWithValue:(CGFloat)value;

@end
