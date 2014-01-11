//
//  RainbowStacks.m
//  RainbowStacks
//
//  Created by B.H.Liu on 14-1-11.
//  Copyright (c) 2014年 Katze. All rights reserved.
//

#import "RainbowStacks.h"

@interface RainbowStacks()

@property (nonatomic,strong) UIScrollView *container;
@property (nonatomic,strong) NSMutableArray *stackViews;
@property (nonatomic,readwrite) CGFloat lastContentOffset;
@property (nonatomic,readwrite) NSInteger numberOfStacks;
@property (nonatomic,readwrite) NSInteger currentStack;

@end

typedef enum ScrollDirection {
    ScrollDirectionUp,
    ScrollDirectionDown,
} ScrollDirection;

@implementation RainbowStacks

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.stackViews = [NSMutableArray array];
        self.currentStack = 0;
        
        self.container = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  0, self.frame.size.width, self.frame.size.height)];
        self.container.delegate = self;
        [self addSubview:self.container];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)initialize
{
    self.numberOfStacks = [self.datasource numberOfStacks];
    NSAssert(self.numberOfStacks <= 4, @"Are you sure you want to use more than 4 views?");
    @autoreleasepool {
        for (int i = 0; i< self.numberOfStacks; i++)
        {
            UIView* view = [self.datasource rainbowStacks:self viewForStack:i];
            [self.stackViews addObject:view];
            
            // add the first stack
            if (i == 0)
            {
                self.container.contentSize = CGSizeMake(self.frame.size.width, view.frame.size.height + (self.numberOfStacks - 1)*BAR_HEIGHT);
                view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
                [self.container addSubview:view];
            }
            // add other stacks to the bottom
            else
            {
                view.frame = CGRectMake(0, self.frame.size.height - BAR_HEIGHT*(self.numberOfStacks - i), view.frame.size.width, view.frame.size.height);
                [self addSubview:view];
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // get scroll direction
    ScrollDirection scrollDirection;
    if (self.lastContentOffset >= scrollView.contentOffset.y)
        scrollDirection = ScrollDirectionDown;
    else scrollDirection = ScrollDirectionUp;
    self.lastContentOffset = scrollView.contentOffset.y;
    
    // a view to add or remove from scrollView
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentYoffset = scrollView.contentOffset.y;
    
    UIView *currentView = self.stackViews[self.currentStack];
    
    // scroll up. add another view to scrollView;
    if(scrollDirection == ScrollDirectionUp && scrollView.contentSize.height - contentYoffset < height && self.currentStack < self.numberOfStacks - 1)
    {
        UIView *nextView = self.stackViews[++self.currentStack];
        
        self.container.contentSize = CGSizeMake(self.container.frame.size.width, self.container.contentSize.height + nextView.frame.size.height - BAR_HEIGHT);
        [nextView removeFromSuperview];
        nextView.frame = CGRectMake(0, currentView.frame.origin.y + currentView.frame.size.height, self.container.frame.size.width, nextView.frame.size.height);
        [self.container addSubview:nextView];
    }
    // scroll down. remove view from scrollView and add it back to self.bottom
    else if (scrollDirection == ScrollDirectionDown && scrollView.contentSize.height - contentYoffset > height - BAR_HEIGHT + currentView.frame.size.height &&  self.currentStack > 0) {
        self.container.contentSize = CGSizeMake(self.container.frame.size.width, self.container.contentSize.height - currentView.frame.size.height + BAR_HEIGHT);
        [currentView removeFromSuperview];
        currentView.frame = CGRectMake(0, self.frame.size.height - BAR_HEIGHT*(self.numberOfStacks - self.currentStack), self.frame.size.width, currentView.frame.size.height);
        
        [self insertSubview:currentView atIndex:1];
        self.currentStack --;
    }
}

@end
