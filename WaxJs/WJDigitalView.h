//
//  WJDigitalView.h
//  WaxJs
//
//  Created by anyswang on 2017/8/7.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSView.h"
#import "JSImageView.h"

@protocol WJDigitalViewExport <JSExport>

@property (nonatomic, strong) JSImageView *digitalImageView;
@property (nonatomic, strong) JSImageView *dotImageView;

@end

@interface WJDigitalView : JSView <WJDigitalViewExport>

@end
