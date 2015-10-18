//
//  ViewController.m
//  UIColorAdditions
//
//  Created by Joan Martin on 10/01/15.
//  Copyright (c) 2015 Mobile Jazz. All rights reserved.
//

#import "ViewController.h"

#import "UIColor+Additions.h"

typedef NS_ENUM(NSInteger, Row)
{
    RowRandomSystemColor,
    RowRandomColor,
    RowRandomLightColor,
    RowRandomDarkColor,
};

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController
{
    UIColor *_color;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mjz_updateTextView
{
    NSMutableString *string = [[NSMutableString alloc] init];
    
    [string appendFormat:@"DARK: %@\n", [_color add_isDarkColor]?@"YES":@"NO"];
    [string appendFormat:@"LIGHT: %@\n", [_color add_isLightColor]?@"YES":@"NO"];
    
    _textView.text = [string copy];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    
    if (row == RowRandomSystemColor)
    {
        cell.textLabel.text = @"Random System Color";
    }
    else if (row == RowRandomColor)
    {
        cell.textLabel.text = @"Random Color";
    }
    else if (row == RowRandomLightColor)
    {
        cell.textLabel.text = @"Random Light Color";
    }
    else if (row == RowRandomDarkColor)
    {
        cell.textLabel.text = @"Random Dark Color";
    }
    
    return cell;
}

#pragma mark UItableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSInteger row = indexPath.row;

    UIColor *color = nil;
    
    if (row == RowRandomSystemColor)
    {
        color = [UIColor add_randomSystemColor];
    }
    else if (row == RowRandomColor)
    {
        color = [UIColor add_randomColor];
    }
    else if (row == RowRandomLightColor)
    {
        color = [UIColor add_randomLightColor];
    }
    else if (row == RowRandomDarkColor)
    {
        color = [UIColor add_randomDarkColor];
    }
    
    if (color)
    {
        _color = color;
        _colorView.backgroundColor = color;
        [self mjz_updateTextView];
    }
}


@end
