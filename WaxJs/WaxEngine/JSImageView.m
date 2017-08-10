//
//  JSImageView.m
//  WaxJs
//
//  Created by anyswang on 2017/8/8.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import "JSImageView.h"

@implementation JSImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setImageName:(NSString *)imageName
{
    self.image = [UIImage imageNamed:imageName];
}

@end
