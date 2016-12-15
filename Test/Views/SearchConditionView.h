//
//  SearchConditionView.h
//  Test
//
//  Created by 符现超 on 2016/12/12.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchConditionView : UIView

/// 如果是多行，就传一个二维数组，用来分行显示
@property (nonatomic, copy) NSArray *allTags;
/// 选择的tag发生变化时执行此block
@property (nonatomic, copy) void(^selectedTagChange)(NSArray *selectedTags, NSUInteger row);
/// 当前所选择的全部tag
@property (nonatomic, strong, readonly) NSMutableArray *selectedTags;



@end
