//
//  CirculateDetailsViewController.m
//  TestMutiRequest
//
//  Created by company on 12/6/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import "CirculateDetailsViewController.h"

@interface CirculateDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *contentTableView;
@end

@implementation CirculateDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.contentTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- TableViewDelegate && TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text = [NSString stringWithFormat:@"cellContent%zd",indexPath.row];
    }
    return cell;
}

#pragma mark -- 重写tableView方法
- (UITableView *)contentTableView
{
    if(!_contentTableView)
    {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 400) style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
    }
    return _contentTableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
