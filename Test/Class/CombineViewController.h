//
//  CombineViewController.h
//  Test
//
//  Created by 符现超 on 2016/12/14.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface CombineViewController : UIViewController

/// 上面的头视图，需要外面传进来
@property (nonatomic, strong) UIView *topView;

/// topView下面的子控制器，需要外面传进来
@property (nonatomic, strong) UIViewController *bottomController;

/// 高度不设置的话，默认会根据topView上的约束自动撑起来
@property (nonatomic, assign) CGFloat topViewHeight;

@property (nonatomic, assign) CGFloat realTopViewHeight;

/// 动画执行时间，默认值为0.4秒
@property (nonatomic, assign) NSTimeInterval durationInteral;

@end
NS_ASSUME_NONNULL_END




