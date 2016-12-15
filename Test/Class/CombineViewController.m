//
//  CombineViewController.m
//  Test
//
//  Created by 符现超 on 2016/12/14.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import "CombineViewController.h"
#import <Masonry.h>

static NSString * const reuseIdentifier = @"reuseIdentifier";
static NSTimeInterval const duration = 0.4;


@interface CombineViewController ()
@property (nonatomic, strong) UIView *bottomView;
@end


@implementation CombineViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setup {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupViewController];
    [self setupView];
}

- (void)setupViewController {
    if (!self.bottomController) return;

    //添加子控制器
    UIViewController *subController = self.bottomController;
    [self addChildViewController:subController];
    [subController didMoveToParentViewController:self];
    //子控制器view添加到self.view
    [self.view addSubview:subController.view];
    self.bottomView = subController.view;
}

- (void)setupView {
    [self.view addSubview:self.topView];
    
    //给top、bottomView添加约束
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
    }];
}

#pragma mark - Public Method

#pragma mark - Private Method

#pragma mark - System Method

#pragma mark - Property
// Setter
- (void)setTopViewHeight:(CGFloat)topViewHeight {
    if (_topViewHeight != topViewHeight) {
        _topViewHeight = topViewHeight;
        
        [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.mas_equalTo(_topViewHeight);
        }];
        
        [self.view setNeedsLayout];
        [UIView animateWithDuration:(self.durationInteral ?: duration) animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}



@end










