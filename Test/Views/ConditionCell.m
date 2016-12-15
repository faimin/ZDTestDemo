//
//  ConditionCell.m
//  Test
//
//  Created by 符现超 on 2016/12/12.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import "ConditionCell.h"
#import <Masonry.h>
#import <TTGTextTagCollectionView.h>

@interface ConditionCell ()<TTGTextTagCollectionViewDelegate>
@property (nonatomic, strong) TTGTextTagCollectionView *onelineTagView;
@property (nonatomic, strong) NSArray *tags;

@end

@implementation ConditionCell
{
    NSInteger _selectedIndex;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupView];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.onelineTagView];
    [self.onelineTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    for (UIView *subView in self.onelineTagView.subviews) {
        if ([subView isKindOfClass:[TTGTagCollectionView class]]) {
            //KVC
            UICollectionView *collectionView = [subView valueForKey:@"collectionView"];
            collectionView.showsHorizontalScrollIndicator = NO;
            break;
        }
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [_onelineTagView removeAllTags];
}

#pragma mark - Public Method

- (void)addTags:(NSArray *)tags {
    if (!tags || tags.count == 0) return;
    self.tags = tags;
    [self.onelineTagView removeAllTags];
    [self.onelineTagView addTags:tags];
    [self.onelineTagView setTagAtIndex:0 selected:YES];
}

#pragma mark - Delegate

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView didTapTag:(NSString *)tagText atIndex:(NSUInteger)index selected:(BOOL)selected {
    //NSLog(@"点击的文字内容： %@", tagText);
    if (index != _selectedIndex) {
        [self.onelineTagView setTagAtIndex:_selectedIndex selected:NO];
    } else {
        [self.onelineTagView setTagAtIndex:index selected:YES];
    }
    _selectedIndex = index;
    
    if (self.tapTag) {
        self.tapTag(tagText, index);
    }
}

//- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView updateContentSize:(CGSize)contentSize {
//    NSLog(@"%@", NSStringFromCGSize(contentSize));
//}

#pragma mark - Private Method

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {
    
    [_onelineTagView layoutIfNeeded];
    [_onelineTagView invalidateIntrinsicContentSize];
    
    return [super systemLayoutSizeFittingSize:targetSize withHorizontalFittingPriority:horizontalFittingPriority verticalFittingPriority:verticalFittingPriority];
}

#pragma mark - Property

- (TTGTextTagCollectionView *)onelineTagView {
    if (!_onelineTagView) {
        _onelineTagView = [[TTGTextTagCollectionView alloc] init];
        _onelineTagView.scrollDirection = TTGTagCollectionScrollDirectionHorizontal;
        _onelineTagView.numberOfLinesForHorizontalScrollDirection = 1;
        _onelineTagView.tagTextFont = [UIFont systemFontOfSize:14.f];
        _onelineTagView.tagCornerRadius = 13.5f;
        _onelineTagView.horizontalSpacing = 5.0;
        _onelineTagView.tagSelectedBackgroundColor = [UIColor whiteColor];
        _onelineTagView.delegate = self;
        //TODO: need congif
        
        UIColor *highColor = [UIColor brownColor];
        _onelineTagView.tagTextColor = [UIColor blackColor];
        _onelineTagView.tagSelectedTextColor = highColor;
        
        _onelineTagView.tagBorderColor = [UIColor clearColor];
        _onelineTagView.tagSelectedBorderColor = highColor;
        
        _onelineTagView.extraSpace = (CGSize){25, 10};
    }
    return _onelineTagView;
}

#pragma mark - Unused

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
