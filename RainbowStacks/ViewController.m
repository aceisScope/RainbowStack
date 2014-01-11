//
//  ViewController.m
//  RainbowStacks
//
//  Created by B.H.Liu on 14-1-10.
//  Copyright (c) 2014年 Katze. All rights reserved.
//

#import "ViewController.h"
#import "RainbowStacks.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController () <RainbowStacksDataSource>

@property (nonatomic,strong) UIView *view1;
@property (nonatomic,strong) UIView *view2;
@property (nonatomic,strong) UIView *view3;
@property (nonatomic,strong) UIView *view4;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGColorRef shadowColor = [UIColor colorWithWhite:0 alpha:.3].CGColor;
    CGSize shadowOffset = CGSizeMake(0, -5);
    
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 1.2)];
    self.view1.backgroundColor = [UIColor colorWithRed:51./255 green:51./255 blue:51./255 alpha:1];
    self.view1.layer.shadowColor = shadowColor;
    self.view1.layer.shadowOffset = shadowOffset;
    self.view1.layer.shadowOpacity = YES;

    self.view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.view2.backgroundColor = [UIColor colorWithRed:1./255 green:149./255 blue:91./255 alpha:1];
    self.view2.layer.shadowColor = shadowColor;
    self.view2.layer.shadowOffset = shadowOffset;
    self.view2.layer.shadowOpacity = YES;
    
    self.view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    self.view3.backgroundColor = [UIColor colorWithRed:1./255 green:143./255 blue:168./255 alpha:1];
    self.view3.layer.shadowColor = shadowColor;
    self.view3.layer.shadowOffset = shadowOffset;
    self.view3.layer.shadowOpacity = YES;
    
    self.view4 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height*.5)];
    self.view4.backgroundColor = [UIColor colorWithRed:154./255 green:117./255 blue:222./255 alpha:1];
    self.view4.layer.shadowColor = shadowColor;
    self.view4.layer.shadowOffset = shadowOffset;
    self.view4.layer.shadowOpacity = YES;
    
    RainbowStacks *rainbowStacks = [[RainbowStacks alloc] initWithFrame:self.view.frame];
    [self.view addSubview:rainbowStacks];
    rainbowStacks.datasource = self;
    [rainbowStacks initialize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - RainbowStackDataSource

- (NSInteger)numberOfStacks
{
    return 4;
}

- (UIView*)rainbowStacks:(RainbowStacks *)rainbowStacks viewForStack:(NSInteger)stack
{
    switch (stack) {
        case 0:
            return self.view1;
            break;
        case 1:
            return self.view2;
            break;
        case 2:
            return self.view3;
            break;
        case 3:
            return self.view4;
            break;
        default:
            return self.view1;
            break;
    }
}

@end
