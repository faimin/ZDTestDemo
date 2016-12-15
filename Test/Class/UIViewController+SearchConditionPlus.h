//
//  UIViewController+SearchConditionPlus.h
//  Test
//
//  Created by 符现超 on 2016/12/15.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SearchCondition.h"
#import "ConditionProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (SearchConditionPlus)

/// 给controller赋完属性后再调用
- (void)configSubView;

@property (nonatomic, strong) UIView *customTopView; ///< topView

@property (nonatomic, strong) UIViewController<SearchConditionProtocol> *scrollViewController;

/// topView子视图
@property (nonatomic, strong) UIView *titleView;

/// nullable,默认为50
@property (nonatomic, assign) CGFloat titleViewHeight;

/// 在dealloc中调用(必调函数)
- (void)removeObserverForKVO;
/// 获取topView真实高度的方法（需要在viewdidlayousubview中调用）
- (void)firstRealTopViewHeight;

@end
NS_ASSUME_NONNULL_END
