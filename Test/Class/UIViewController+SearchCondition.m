//
//  UIViewController+SearchCondition.m
//  Test
//
//  Created by 符现超 on 2016/12/15.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import "UIViewController+SearchCondition.h"
#import <objc/runtime.h>
#import <Masonry.h>

static NSTimeInterval const duration = 0.4;


@implementation UIViewController (SearchCondition)

#pragma mark - Public Method

#pragma mark - Private Method

- (void)addBottomViewConstraint {
    /*
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    */
    
    [self.bottomController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
    }];
}

#pragma mark - Property
// TopView
- (void)setTopView:(UIView *)topView {
    objc_setAssociatedObject(self, @selector(topView), topView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (!topView) return;
    
    [self.view addSubview:topView];
    //给topView添加约束
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    
    if (self.bottomController.view) {
        [self addBottomViewConstraint];
    }
}

- (UIView *)topView {
    return objc_getAssociatedObject(self, _cmd);
}

// BottomController
- (void)setBottomController:(UIViewController *)bottomController {
    objc_setAssociatedObject(self, @selector(bottomController), bottomController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (!bottomController) return;
    
    //添加子控制器
    UIViewController *subController = self.bottomController;
    [self addChildViewController:subController];
    [subController didMoveToParentViewController:self];
    //子控制器view添加到self.view
    [self.view addSubview:subController.view];
    
    if (self.topView) {
        [self addBottomViewConstraint];
    }
}

- (UIViewController *)bottomController {
    return objc_getAssociatedObject(self, _cmd);
}

// TopViewHeight
- (void)setTopViewHeight:(CGFloat)topViewHeight {
    if ([self topViewHeight] != topViewHeight) {
        objc_setAssociatedObject(self, @selector(topViewHeight), @(topViewHeight), OBJC_ASSOCIATION_ASSIGN);
        
        [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.mas_equalTo(self.topViewHeight);
        }];
        
        [self.view setNeedsLayout];
        [UIView animateWithDuration:(self.durationInteral ?: duration) animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (CGFloat)topViewHeight {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

// DurationInteral
- (void)setDurationInteral:(NSTimeInterval)durationInteral {
    objc_setAssociatedObject(self, @selector(durationInteral), @(durationInteral), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)durationInteral {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

@end
