//
//  RainbowStacks.h
//  RainbowStacks
//
//  Created by B.H.Liu on 14-1-11.
//  Copyright (c) 2014年 Katze. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BAR_HEIGHT 15

@class RainbowStacks;

@protocol RainbowStacksDataSource <NSObject>

@required
- (NSInteger)numberOfStacks;
- (UIView*)rainbowStacks:(RainbowStacks*)rainbowStacks viewForStack:(NSInteger)stack;

@end

@interface RainbowStacks : UIView <UIScrollViewDelegate>

@property (nonatomic,weak) id<RainbowStacksDataSource>datasource;

- (void)initialize;

@end
