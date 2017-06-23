//
//  CustomTabView.m
//  TabViewController
//
//  Created by 焦灿 on 17/6/13.
//  Copyright © 2017年 焦灿. All rights reserved.
//

#import "CustomTabView.h"

#define kBottomLineColor [UIColor colorWithRed:41/255.0 green:191/255.0 blue:221/255.0 alpha:1]
#define kSelectedTitleColor [UIColor colorWithRed:48/255.0 green:52/255.0 blue:53/255.0 alpha:1]
#define kNormalTitleColor [UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:1]

@interface CustomTabView()
/** 记录上一次被选中的按钮 */
@property (nonatomic ,strong) UIButton *tempBtn;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,assign) NSInteger section;
@end
@implementation CustomTabView

- (NSArray *)titles
{
    if (_titles==nil) {
        _titles=[[NSArray alloc] init];
    }
    return _titles;
}


- (UIColor *) tilteColor
{
    if ([self.delegate respondsToSelector:@selector(titleColorForCustomTabView:)]) {
        return [self.delegate titleColorForCustomTabView:self];
    }
    return [UIColor blackColor];
}

- (CGFloat) lineViewHeight
{
    if ([self.delegate respondsToSelector:@selector(customTabView:lineHeightForLineViewInSection:)]) {
        return [self.delegate customTabView:self lineHeightForLineViewInSection:self.section];
    }
    return 2;
}

- (void)layoutSubviews
{
    if (self.starAnimation) {
        
        if (!self.lineView.frame.size.width) {
            self.lineView.frame = CGRectMake(0, 38 - 2, 38, 2);
        }
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint center = CGPointMake(0, 0);
            center.y = self.lineView.center.y;
            center.x = self.tempBtn.center.x;
            self.lineView.center = center;
            
        }];
    }
    else
    {
        self.lineView.frame = CGRectMake(0, 38 - 2, 38, 2);
        CGPoint tempCenter = CGPointMake(0, 0);
        tempCenter.y =  self.lineView.center.y;
        tempCenter.x = self.tempBtn.center.x;
        self.lineView.center = tempCenter;
    }
}

- (void) rollLineViewAnimation:(CGPoint) currentPoint
{
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center = CGPointMake(0, 0);
        center.y = self.lineView.center.y;
        NSLog(@"%.2f",currentPoint.x);
        center.x = self.tempBtn.center.x +currentPoint.x;
        self.lineView.center = center;
    }];
}

- (void) setUpChildTitleViews
{
    [self setUpLineView];
    [self setUpTitleButtons];
}

- (void)setUpLineView
{
    self.lineView=[[UIView alloc] init];
    self.lineView.backgroundColor = kBottomLineColor;
    [self addSubview:self.lineView];
}

- (void)setUpTitleButtons
{
    self.titles=[self.dataSource titlesForCustomTabView:self];
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width / self.titles.count;
    for (NSInteger i = 0; i< self.titles.count; i++)
    {
        {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * btnW, 0, btnW, 40)];
            [btn setTitle:self.titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:kNormalTitleColor forState:UIControlStateNormal];
            [btn setTitleColor:kSelectedTitleColor forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.tag = i + 100;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) [self btnClick:btn];
            [self addSubview:btn];
        }
    }
}

#pragma mark -- 按钮点击方法
- (void)btnClick:(UIButton *)sender{
    
    self.tempBtn.selected = NO;
    sender.selected = YES;
    if ([self.delegate respondsToSelector:@selector(customTabView:didSelectForIndex:)]) {
        [self.delegate customTabView:self didSelectForIndex:sender.tag-100];
    }
    self.tempBtn = sender;
    [self setNeedsLayout];
}


@end
