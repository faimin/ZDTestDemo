//
//  SearchConditionController.h
//  Test
//
//  Created by 符现超 on 2016/12/14.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CombineViewController.h"

@interface SearchConditionController : CombineViewController

@property (nonatomic, strong) UIView *titleView;

/// nullable,默认为50
@property (nonatomic, assign) CGFloat titleViewHeight;

@end
