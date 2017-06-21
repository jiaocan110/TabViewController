//
//  CustomTabView.h
//  TabViewController
//
//  Created by 焦灿 on 17/6/13.
//  Copyright © 2017年 焦灿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabViewDataSource;
@protocol TabViewDeleagate;

typedef void(^ToolViewBlcok)(NSInteger index);

@interface CustomTabView : UIView

#pragma mark 对象属性
/**
 *  横线宽度
 */
@property (nonatomic,assign) CGFloat lineViewHeight;
/**
 *  是否开启动画
 */
@property (nonatomic,assign) BOOL starAnimation;


@property (nonatomic,strong) UIColor *tilteColor;
@property (nonatomic,weak)id<TabViewDeleagate> delegate;
@property (nonatomic,weak)id<TabViewDataSource> dataSource;

#pragma mark medthod


- (void) setUpChildTitleViews;
- (void) reloadData;
- (void)btnClick:(UIButton *)sender;
@end

#pragma mark TabViewDataSource
@protocol TabViewDataSource <NSObject>
@required
/**
 *  title数组
 */
- (NSArray *)titlesForCustomTabView:(CustomTabView *) customTabView;
@end


#pragma mark TabViewDeleagate
@protocol TabViewDeleagate <NSObject>
@optional
/*对title  颜色以及宽度的设置 */
- (UIColor *) titleColorForCustomTabView:(CustomTabView *) customTabView;
- (CGFloat) customTabView:(CustomTabView *)customTabView lineHeightForLineViewInSection:(NSInteger) section;


/**
 *  选中title
 */
- (void)customTabView:(CustomTabView *)customTabView didSelectForIndex:(NSInteger) index;
@end
