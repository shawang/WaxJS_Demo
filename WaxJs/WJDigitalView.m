//
//  WJDigitalView.m
//  WaxJs
//
//  Created by anyswang on 2017/8/7.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import "WJDigitalView.h"

@interface WJDigitalView ()

@property (nonatomic, strong) UIImageView *noneImageView;

@end

@implementation WJDigitalView

@synthesize digitalImageView = _digitalImageView;
@synthesize dotImageView = _dotImageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.noneImageView = [[JSImageView alloc] init];
        [self addSubview:self.noneImageView];
        self.noneImageView.image = [UIImage imageNamed:@"pic_bg.png"];
        self.noneImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.digitalImageView = [[JSImageView alloc] init];
        [self addSubview:self.digitalImageView];
        self.digitalImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.dotImageView = [[JSImageView alloc] init];
        [self addSubview:self.dotImageView];
        self.dotImageView.image = [UIImage imageNamed:@"point.png"];
        self.dotImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.dotImageView.hidden = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat DOT_WIDTH = self.frame.size.width / 8;
    CGFloat DOT_HEIGHT = DOT_WIDTH * 12/10;
    
    self.noneImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.digitalImageView.frame = self.noneImageView.frame;
    self.dotImageView.frame = CGRectMake(self.frame.size.width-DOT_WIDTH, self.frame.size.height-DOT_HEIGHT, DOT_WIDTH, DOT_HEIGHT);
}

@end
