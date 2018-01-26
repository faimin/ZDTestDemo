//
//  ZDTestViewController.m
//  Test
//
//  Created by 符现超 on 2016/12/12.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import "ZDTestViewController.h"
#import "SearchConditionView.h"

static NSString *const reuseIdentifier = @"reuseIdentifier";
static NSTimeInterval const durationInterval = 0.3;
static CGFloat const titleHieght = 50;


@interface ZDTestViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SearchConditionView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topviewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeightConstraint;
@end


@implementation ZDTestViewController
{
    CGFloat _contentOffsetY;
    CGFloat _topviewHeight;

    BOOL _fold; ///< 收起状态，默认是NO（展开状态）
}

- (void)dealloc
{
    NSLog(@"释放了");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableview.tableFooterView = [[UIView alloc] init];

    NSArray *testData = @[ @"AutoLayout", @"dynamically", @"calculates", @"the", @"size", @"and", @"position", @"of", @"all", @"the", @"views", @"in", @"your", @"view", @"hierarchy", @"based", @"on", @"constraints", @"placed", @"on", @"those", @"views" ];
    NSArray *mutArr = @[ testData, testData, testData, testData ];
    self.topView.allTags = mutArr;

    [self.topView bringSubviewToFront:self.titleView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _topviewHeight = self.topviewHeightConstraint.constant;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableviewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [self randomColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row + 1];
    return cell;
}

#pragma mark - UITableviewDelegate


#pragma mark - UIScrollviewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (contentOffsetY >= _contentOffsetY) {
        NSLog(@"上滑");
    } else {
        NSLog(@"下滑");
    }
    _contentOffsetY = contentOffsetY;

    if (contentOffsetY <= 0 && _fold) {
        _fold = NO;
        [self.topView setNeedsLayout];
        [UIView animateWithDuration:durationInterval animations:^{ // 展开
            self.titleHeightConstraint.constant = 0;
            self.topviewHeightConstraint.constant = _topviewHeight;
            [self.topView layoutIfNeeded];
        }];
    } else if (contentOffsetY >= 400 && !_fold) {
        _fold = YES;
        [self.topView setNeedsLayout];
        [UIView animateWithDuration:durationInterval animations:^{ // 收起
            self.topviewHeightConstraint.constant = titleHieght;
            self.titleHeightConstraint.constant = titleHieght;
            [self.topView layoutIfNeeded];
        }];
    }
}

#pragma mark - Private Method
- (UIColor *)randomColor
{
    CGFloat hue = (arc4random() % 256 / 256.0);              //  0.0 to 1.0
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5; //  0.5 to 1.0, away from white
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5; //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
