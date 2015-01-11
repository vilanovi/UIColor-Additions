 [![Version](https://cocoapod-badges.herokuapp.com/v/UIColor+Additions/badge.png)](http://cocoadocs.org/docsets/UIColor+Additions) 
[![Platform](https://cocoapod-badges.herokuapp.com/p/UIColor+Additions/badge.png)](http://cocoadocs.org/docsets/UIColor+Additions) 

![UIColor+Additions](https://raw.githubusercontent.com/vilanovi/UIColor-Additions/master/UIColorAdditionsLogo.jpg)

UIColor+Additions
=================

UIColor+Additions is a category on **UIColor** that helps the developer making color manipulation more flexible and accessible.

### Hexadecimal Color Representation

Use the convenience methdos to create colors from hexadecimal integer or string values:

    + (UIColor*)add_colorWithRGBHexValue:(ADDColorType)rgbHexValue;
    + (UIColor*)add_colorWithRGBAHexValue:(ADDColorType)rgbaHexValue;
    + (UIColor*)add_colorWithRGBHexString:(NSString*)rgbHexString;
    + (UIColor*)add_colorWithRGBAHexString:(NSString*)rgbaHexString;

It is also possible to retrieve the hex reprsentation of a color:

    - (BOOL)add_getRGBHexValue:(ADDColorType*)rgbHexValue;
    - (BOOL)add_getRGBAHexValue:(ADDColorType*)rgbaHexValue;
    - (NSString*)add_RGBHexString;
    - (NSString*)add_RGBAHexString;

### RGB suport

RGB colors are usually represented in a range of 0-255. UIColor+Additions add convenience methods to create colors:

    + (UIColor*)add_colorWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue;
    + (UIColor*)add_colorWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue alpha255:(CGFloat)alpha;

### Luminiscence

Easily, retrieve the gray version of a given color by computing the luminiscense value of it. Also, you can check if your color is considered "light" or "dark":

    - (UIColor*)add_grayColor;
    - (BOOL)add_isLightColor;
    - (BOOL)add_isDarkColor;

### Modifying Colors

Finally, UIColor+Additions add simple methods to create new lighter, darker, saturated and brightner colors from existing ones:

    - (UIColor*)add_colorWithSaturation:(CGFloat)newSaturation;
    - (UIColor*)add_colorWithBrightness:(CGFloat)newBrightness;
    - (UIColor*)add_lighterColorWithValue:(CGFloat)value;
    - (UIColor*)add_darkerColorWithValue:(CGFloat)value;

---
## Licence ##

Copyright (c) 2013 Joan Martin, vilanovi@gmail.com.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE
