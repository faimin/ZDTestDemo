//
//  SearchConditionView.m
//  Test
//
//  Created by 符现超 on 2016/12/12.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import "SearchConditionView.h"
#import "ConditionCell.h"
#import <Masonry.h>

static NSString *const reuseIndentifier = @"ConditionCell";


@interface SearchConditionView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *selectedTags;
@end


@implementation SearchConditionView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupView];
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.tableview = ({
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableview.dataSource = self;
        tableview.delegate = self;
        tableview.rowHeight = 50;

        [tableview registerClass:[ConditionCell class] forCellReuseIdentifier:reuseIndentifier];
        tableview.tableFooterView = [[UIView alloc] init];

        tableview.scrollEnabled = NO;
        tableview.showsHorizontalScrollIndicator = NO;
        tableview.showsVerticalScrollIndicator = NO;

        [self addSubview:tableview];
        tableview;
    });
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
    }];

    self.selectedTags = @[].mutableCopy;
}

#pragma mark - Public Method
- (void)setAllTags:(NSArray *)allTags
{
    NSArray *firstObjc = allTags.firstObject;
    if (![firstObjc isKindOfClass:[NSArray class]]) {
        NSLog(@"这不是二维数组");
        NSAssert(NO, @"需要一个二维数组");
    }
    _allTags = allTags.copy;

    // 把每行第一个元素放入selectedTags数组中（默认选中的第一个元素）
    [self.selectedTags removeAllObjects];
    for (NSUInteger i = 0; i < allTags.count; i++) {
        [self.selectedTags addObject:[allTags[i] firstObject]];
    }

    [self.tableview reloadData];
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConditionCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];

    NSArray<NSString *> *tags = self.allTags[indexPath.row];
    [cell addTags:tags];

    cell.tapTag = ^(NSString *tagText, NSUInteger index) {
        NSString *originString = self.selectedTags[indexPath.row];
        if (![tagText isEqualToString:originString]) {
            self.selectedTags[indexPath.row] = tagText ?: @"";
            if (self.selectedTagChange) {
                self.selectedTagChange(self.selectedTags, indexPath.row);
            }
        }
    };
    return cell;
}


@end
