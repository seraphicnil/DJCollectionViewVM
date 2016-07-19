//
//  DJCollectionViewImageCell.m
//  DJCollectionViewVM
//
//  Created by Dokay on 16/2/25.
//  Copyright © 2016年 dj226. All rights reserved.
//

#import "DJCollectionViewImageCell.h"

@implementation DJCollectionViewImageRow

@end

@interface DJCollectionViewImageCell()

@property (nonatomic, strong) UIImageView *contentImageView;

@end

@implementation DJCollectionViewImageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setupUI];
}

- (void)setupUI
{
    [self.contentView addSubview:self.contentImageView];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentImageView(50)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentImageView)]];
     [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentImageView(50)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentImageView)]];
}

- (UIImageView *)contentImageView
{
    if (_contentImageView == nil) {
        _contentImageView = [UIImageView new];
        _contentImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentImageView.image = [UIImage imageNamed:@"test_head"];
    }
    return _contentImageView;
}

@end
