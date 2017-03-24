//
//  UIColorAdditionsTests.m
//  UIColorAdditionsTests
//
//  Created by Joan Martin on 10/01/15.
//  Copyright (c) 2015 Mobile Jazz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UIColor+Additions.h"

@interface UIColorAdditionsTests : XCTestCase

@end

@implementation UIColorAdditionsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIsLightColor {
    XCTAssertEqual(YES, [[UIColor whiteColor] add_isLightColor]);
    XCTAssertEqual(YES, [[UIColor add_colorWithRGBHexString:@"dddddd"] add_isLightColor]);
    XCTAssertEqual(NO, [[UIColor blackColor] add_isLightColor]);
    XCTAssertEqual(NO, [[UIColor add_colorWithRGBHexString:@"cccccc"] add_isLightColor]);
}

- (void)testIsDarkColor {
    XCTAssertEqual(NO, [[UIColor whiteColor] add_isDarkColor]);
    XCTAssertEqual(NO, [[UIColor add_colorWithRGBHexString:@"dddddd"] add_isDarkColor]);
    XCTAssertEqual(YES, [[UIColor blackColor] add_isDarkColor]);
    XCTAssertEqual(YES, [[UIColor add_colorWithRGBHexString:@"cccccc"] add_isDarkColor]);
}

@end
