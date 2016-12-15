//
//  ConditionCell.h
//  Test
//
//  Created by 符现超 on 2016/12/12.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConditionCell : UITableViewCell

@property (nonatomic, copy) void(^tapTag)(NSString *tagText, NSUInteger index);

- (void)addTags:(NSArray *)tags;


@end
