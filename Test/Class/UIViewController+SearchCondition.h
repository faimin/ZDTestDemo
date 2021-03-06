//
//  UIViewController+SearchCondition.h
//  Test
//
//  Created by 符现超 on 2016/12/15.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIViewController (SearchCondition)

/// 上面的头视图，需要外面传进来
@property (nonatomic, strong, nonnull) UIView *topView;

/// topView下面的子控制器，需要外面传进来
@property (nonatomic, strong, nonnull) UIViewController *bottomController;

/// nullable，默认会根据topView上的约束自动撑起来
@property (nonatomic, assign) CGFloat topViewHeight;

/// 动画执行时间，默认值为0.4秒
@property (nonatomic, assign) NSTimeInterval durationInteral;

@end
NS_ASSUME_NONNULL_END
