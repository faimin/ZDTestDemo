//
//  BlueViewController.m
//  Test
//
//  Created by 符现超 on 2016/12/14.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import "BlueViewController.h"
#import "CombineViewController.h"

static NSString * const reuseIdentifier = @"reuseIdentifier";

@interface BlueViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation BlueViewController
{
    CGFloat _contentOffsetY;
    BOOL _fold;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.scrollView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row+1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击的第%zd行", indexPath.row);
}

#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    CGFloat contentOffsetY = scrollView.contentOffset.y;
//    if (contentOffsetY >= _contentOffsetY) {
//        NSLog(@"上滑");
//    } else {
//        NSLog(@"下滑");
//    }
//    _contentOffsetY = contentOffsetY;
//
//    if (contentOffsetY <= 0 && _fold) {            // 展开
//        _fold = NO;
//        ((CombineViewController *)self.parentViewController).topViewHeight = 300;
//    } else if (contentOffsetY > 10 && !_fold) {   //收起
//        _fold = YES;
//        ((CombineViewController *)self.parentViewController).topViewHeight = 50;
//    }
//}




@end
