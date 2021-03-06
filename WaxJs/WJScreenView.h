//
//  WJScreenView.h
//  WaxJs
//
//  Created by anyswang on 2017/8/7.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSView.h"
#import "WJDigitalView.h"
#import "JSImageView.h"

@protocol WJScreenViewExport <JSExport>

@property (nonatomic, strong, readonly) NSArray *digitalViews;
@property (nonatomic, strong, readonly) JSImageView *errorImageView;

@end

@interface WJScreenView : JSView <WJScreenViewExport>


@end
