//
//  SearchConditionController.m
//  Test
//
//  Created by 符现超 on 2016/12/14.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import "SearchConditionController.h"
#import "ConditionProtocol.h"
#import <Masonry.h>

static CGFloat const defaultTitleViewHeight = 50.0f;
static NSString * const scrollViewKeyPath = @"contentOffset";

@interface SearchConditionController ()
/// topView最初的高度（warning：这个值可能不准确）
@property (nonatomic, assign) CGFloat realTopViewHeight;
@end


@implementation SearchConditionController
{
    CGFloat _contentOffsetY;
    BOOL _fold; ///< 收起状态，默认是NO（展开状态）
}

#pragma mark - Life Cycle

- (void)dealloc {
    UIScrollView *scrollView = [((id<SearchConditionProtocol>)self.bottomController) scrollView];
    [scrollView removeObserver:self forKeyPath:scrollViewKeyPath];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configSubView {
    //监听contentoffsetY
    UIScrollView *scrollView = [((id<SearchConditionProtocol>)self.bottomController) scrollView];
    [scrollView addObserver:self forKeyPath:scrollViewKeyPath options:NSKeyValueObservingOptionNew context:nil];
    
    if (self.topView && self.titleView) {
        self.topView.clipsToBounds = YES;
        self.titleView.clipsToBounds = YES;
        [self.topView addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.topView);
            make.height.mas_equalTo(0);
        }];
        
        if ([self.titleView isKindOfClass:[UIControl class]]) {
            [((UIControl *)self.titleView) addTarget:self action:@selector(titleViewEvent) forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewEvent)];
            [self.titleView addGestureRecognizer:tap];
        }
    }
}

- (void)viewDidLayoutSubviews {
    if (!self.realTopViewHeight) {
        self.realTopViewHeight = CGRectGetHeight(self.topView.bounds);
        NSLog(@"真实高度 = %f", self.realTopViewHeight);
    }
    [super viewDidLayoutSubviews];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:scrollViewKeyPath]) {
        NSValue *value = change[NSKeyValueChangeNewKey];
        [self kvo:value.CGPointValue];
    }
}

- (void)kvo:(CGPoint)contentOffset {
    CGFloat contentOffsetY = contentOffset.y;
    
    if (contentOffsetY == _contentOffsetY) return;
    
    if (contentOffsetY >= _contentOffsetY) {
        NSLog(@"上滑");
    } else {
        NSLog(@"下滑");
    }
    _contentOffsetY = contentOffsetY;
    
    if (contentOffsetY <= 0 && _fold) {           // 展开
        [self unfoldView:YES];
    }
    else if (contentOffsetY > 10 && !_fold) {     //收起
        [self unfoldView:NO];
    }
}

#pragma mark - Private Method

- (void)titleViewEvent {
    //手动停止滑动
    UIScrollView *scrollView = [((id<SearchConditionProtocol>)self.bottomController) scrollView];
    [scrollView setContentOffset:CGPointMake(0, _contentOffsetY) animated:NO];
    // 展开头视图
    [self unfoldView:YES];
}

- (void)unfoldView:(BOOL)unfold {
    if (_forbidFold) {  //禁用折叠直接返回
        return;
    }
    
    dispatch_barrier_async(dispatch_get_main_queue(), ^{
        
        self.topViewHeight = unfold ? self.realTopViewHeight : defaultTitleViewHeight;
        if (self.titleView) {
            if (unfold) {
                [self.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.bottom.equalTo(self.topView);
                    make.height.mas_equalTo(0);
                }];
            }
            else {
                [self.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.bottom.equalTo(self.topView);
                    make.height.mas_equalTo((self.titleViewHeight ?: defaultTitleViewHeight));
                }];
            }
        }
        // 改变状态
        _fold = !unfold;
    });
}

#pragma mark - Property 

- (void)setForbidFold:(BOOL)forbidFold {
    if (forbidFold) {
        self.topViewHeight = 0.f;
        _fold = NO;
    }
    _forbidFold = forbidFold;
}

- (void)setTopViewHeight:(CGFloat)topViewHeight {
    if (topViewHeight == 0) {
        [self.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.topView);
            make.height.mas_equalTo(0);
        }];
    }
    
    [super setTopViewHeight:topViewHeight];
}

@end
















