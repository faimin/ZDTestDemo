//
//  UIViewController+SearchConditionPlus.m
//  Test
//
//  Created by 符现超 on 2016/12/15.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import "UIViewController+SearchConditionPlus.h"
#import <objc/runtime.h>
#import <Masonry.h>

static CGFloat const defaultTitleViewHeight = 50.0f;
static NSString *const scrollViewKeyPath = @"contentOffset";


@interface UIViewController (Private)
@property (nonatomic, assign) CGFloat contentOffsetY;
@property (nonatomic, assign) BOOL fold; ///< 收起状态，默认是NO（展开状态）
@property (nonatomic, assign) CGFloat realTopViewHeight;
@end


@implementation UIViewController (SearchConditionPlus)

#pragma mark - Public

- (void)configSubView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    //监听contentoffsetY
    UIScrollView *scrollView = [((id<SearchConditionProtocol>)self.bottomController)scrollView];
    scrollView.bounces = NO;
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
        } else {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewEvent)];
            [self.titleView addGestureRecognizer:tap];
        }
    }

    //    [self ];
}

- (void)removeObserverForKVO
{
    UIScrollView *scrollView = [((id<SearchConditionProtocol>)self.bottomController)scrollView];
    [scrollView removeObserver:self forKeyPath:scrollViewKeyPath];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:scrollViewKeyPath]) {
        NSValue *value = change[NSKeyValueChangeNewKey];
        [self kvo:value.CGPointValue];
    }
}

- (void)kvo:(CGPoint)contentOffset
{
    CGFloat contentOffsetY = contentOffset.y;
    if (contentOffsetY >= self.contentOffsetY) {
        NSLog(@"上滑");
    } else {
        NSLog(@"下滑");
    }
    self.contentOffsetY = contentOffsetY;

    if (contentOffsetY <= 0 && self.fold) { // 展开
        [self unfoldView:YES];
    } else if (contentOffsetY > 10 && self.fold) { //收起
        [self unfoldView:NO];
    }
}

#pragma mark - Private Method

- (void)titleViewEvent
{
    [self unfoldView:YES];
}

- (void)unfoldView:(BOOL)unfold
{
    dispatch_barrier_async(dispatch_get_main_queue(), ^{

        self.topViewHeight = unfold ? self.realTopViewHeight : defaultTitleViewHeight;
        if (self.titleView) {
            if (unfold) {
                [self.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.bottom.equalTo(self.topView);
                    make.height.mas_equalTo(0);
                }];
            } else {
                [self.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.bottom.equalTo(self.topView);
                    make.height.mas_equalTo((self.titleViewHeight ?: defaultTitleViewHeight));
                }];
            }
        }
        // 改变状态
        self.fold = !unfold;
    });
}

- (void)firstRealTopViewHeight
{
    if (!self.realTopViewHeight) {
        self.realTopViewHeight = CGRectGetHeight(self.topView.bounds);
        NSLog(@"真实高度 = %f", self.realTopViewHeight);
    }
}

#pragma mark - Property

- (void)setCustomTopView:(UIView *)customTopView
{
    self.topView = customTopView;
}

- (UIView *)customTopView
{
    return self.topView;
}

- (void)setScrollViewController:(UIViewController<SearchConditionProtocol> *)scrollViewController
{
    self.bottomController = scrollViewController;
}

- (UIViewController<SearchConditionProtocol> *)scrollViewController
{
    return self.scrollViewController;
}

- (void)setTitleView:(UIView *)titleView
{
    objc_setAssociatedObject(self, @selector(titleView), titleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)titleView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTitleViewHeight:(CGFloat)titleViewHeight
{
    objc_setAssociatedObject(self, @selector(titleViewHeight), @(titleViewHeight), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)titleViewHeight
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY
{
    objc_setAssociatedObject(self, @selector(contentOffsetY), @(contentOffsetY), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)contentOffsetY
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setFold:(BOOL)fold
{
    objc_setAssociatedObject(self, @selector(fold), @(fold), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)fold
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setRealTopViewHeight:(CGFloat)realTopViewHeight
{
    objc_setAssociatedObject(self, @selector(realTopViewHeight), @(realTopViewHeight), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)realTopViewHeight
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

@end
