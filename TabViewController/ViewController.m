//
//  ViewController.m
//  TabViewController
//
//  Created by 焦灿 on 17/6/13.
//  Copyright © 2017年 焦灿. All rights reserved.
//

#import "ViewController.h"
#import "DelegateViewController.h"
#import "MyGoodsViewController.h"
#import "CirculateDetailsViewController.h"
#import "CustomTabView.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView  *contentScrollView;

@property (nonatomic,strong) CustomTabView *customTabView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewContollers];
    [self addScrollView];
    [self.view addSubview:self.customTabView];

    [self showControllerInIndex:0];
}

#pragma mark -- ShowViewController
- (void)showControllerInIndex:(NSInteger)index
{
    [self.contentScrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * index, 0) animated:YES];
    UIViewController * contr = self.childViewControllers[index];
    if (contr.isViewLoaded) return;
    contr.view.frame = CGRectMake(index * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height - 40);
    [self.contentScrollView addSubview:contr.view];
}

- (void)addChildViewContollers
{
    MyGoodsViewController *goods = [MyGoodsViewController new];
    DelegateViewController *delegate = [DelegateViewController new];
    CirculateDetailsViewController *circulate = [CirculateDetailsViewController new];
    NSArray *viewControllersArray = @[goods,delegate,circulate];
    for(id controller in viewControllersArray)
    {
        [self addChildViewController:controller];
    }
}


- (void) addScrollView
{
    {
        self.contentScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 375, [UIScreen mainScreen].bounds.size.height-40)];
        self.contentScrollView.showsHorizontalScrollIndicator = NO;
        self.contentScrollView.pagingEnabled = YES;
        self.contentScrollView.bounces = NO;
        self.contentScrollView.delegate=self;
        
        
        
         self.contentScrollView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width * self.childViewControllers.count, 60);
        [self.view addSubview:self.contentScrollView];
    }
}

/**
 *  减速停止执行
 *
 *  @param scrollView <#scrollView description#>
 */
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UITableView class]]) {
        CGFloat maxX=scrollView.contentOffset.x;
        NSInteger  currentIndex=maxX/[UIScreen mainScreen].bounds.size.width;
        UIButton *clickedBtn = [self.customTabView viewWithTag:100 + currentIndex];
        [self.customTabView performSelector:@selector(btnClick:) withObject:clickedBtn];
    }
}

#pragma mark --
- (void)didClickBtnIndex:(NSInteger)index
{
    [self showControllerInIndex:index];
}


- (CustomTabView *) customTabView
{
    if (_customTabView==nil) {
        _customTabView=[[CustomTabView alloc] init];
        _customTabView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        _customTabView.dataSource=self;
        _customTabView.delegate=self;
        _customTabView.starAnimation=YES;
        [_customTabView setUpChildTitleViews];
    }
    return _customTabView;
}

- (NSArray *) titlesForCustomTabView:(CustomTabView *)customTabView
{
    return [NSArray arrayWithObjects:@"啊啊啊",@"是的发",@"是的发送到",nil];
}



- (void) customTabView:(CustomTabView *)customTabView didSelectForIndex:(NSInteger)index
{
     [self didClickBtnIndex:index];
}
@end
