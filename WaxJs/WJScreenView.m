//
//  WJScreenView.m
//  WaxJs
//
//  Created by anyswang on 2017/8/7.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import "WJScreenView.h"

#define H_PADDING 20

@interface WJScreenView ()

@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation WJScreenView

@synthesize digitalViews = _digitalViews;
@synthesize errorImageView = _errorImageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.bgImageView = [[UIImageView alloc] init];
        [self addSubview:self.bgImageView];
        self.bgImageView.image = [UIImage imageNamed:@"typebox.png"];
        self.bgImageView.contentMode = UIViewContentModeScaleToFill;
        
        _errorImageView = [[JSImageView alloc] init];
        [self addSubview:self.errorImageView];
        self.errorImageView.image = [UIImage imageNamed:@"pic_error.png"];
        self.errorImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.errorImageView.hidden = YES;
        
        NSMutableArray *views = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 11; i++) {
            WJDigitalView *digitalView = [[WJDigitalView alloc] init];
            [self addSubview:digitalView];
            
            [views addObject:digitalView];
        }
        
        _digitalViews = views;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgImageView.frame = self.bounds;
    
    CGFloat cellWidth = (self.frame.size.width-H_PADDING*2)/self.digitalViews.count;
    CGFloat cellHeight = cellWidth * 117/90;
    
    
    for (int i = 0; i < self.digitalViews.count; i++) {
        WJDigitalView *digitalView = [self.digitalViews objectAtIndex:self.digitalViews.count-i-1];
        digitalView.frame = CGRectMake(H_PADDING+cellWidth*i, (self.frame.size.height-cellHeight)/2, cellWidth, cellHeight);
    }
    
    WJDigitalView *digitalView4 = [self.digitalViews objectAtIndex:4];
    WJDigitalView *digitalView0 = [self.digitalViews objectAtIndex:0];
    
    self.errorImageView.frame = CGRectMake(digitalView4.frame.origin.x, digitalView4.frame.origin.y, digitalView0.frame.origin.x + digitalView0.frame.size.width - digitalView4.frame.origin.x, digitalView4.frame.size.height);
}

@end
