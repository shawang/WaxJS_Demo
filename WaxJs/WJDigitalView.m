//
//  WJDigitalView.m
//  WaxJs
//
//  Created by anyswang on 2017/8/7.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import "WJDigitalView.h"

@interface WJDigitalView ()

@property (nonatomic, retain) UIImageView *noneImageView;

@end

@implementation WJDigitalView

@synthesize digitalImageView = _digitalImageView;
@synthesize dotImageView = _dotImageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _noneImageView = [[JSImageView alloc] init];
        [self addSubview:_noneImageView];
        _noneImageView.image = [UIImage imageNamed:@"pic_bg.png"];
        _noneImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _digitalImageView = [[JSImageView alloc] init];
        [self addSubview:_digitalImageView];
        _digitalImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _dotImageView = [[JSImageView alloc] init];
        [self addSubview:_dotImageView];
        _dotImageView.image = [UIImage imageNamed:@"point.png"];
        _dotImageView.contentMode = UIViewContentModeScaleAspectFit;
        _dotImageView.hidden = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat DOT_WIDTH = self.frame.size.width / 8;
    CGFloat DOT_HEIGHT = DOT_WIDTH * 12/10;
    
    _noneImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _digitalImageView.frame = _noneImageView.frame;
    _dotImageView.frame = CGRectMake(self.frame.size.width-DOT_WIDTH, self.frame.size.height-DOT_HEIGHT, DOT_WIDTH, DOT_HEIGHT);
}

@end
