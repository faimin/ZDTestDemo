//
//  SearchConditionController.h
//  Test
//
//  Created by 符现超 on 2016/12/14.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import "CombineViewController.h"

@interface SearchConditionController : CombineViewController

/// topView的子视图
@property (nonatomic, strong) UIView *titleView;

/// nullable,默认为50
@property (nonatomic, assign) CGFloat titleViewHeight;

/// 禁用折叠topView的功能
@property (nonatomic, assign) BOOL forbidFold;

@end
