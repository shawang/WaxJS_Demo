//
//  JSColor.h
//  WaxJs
//
//  Created by anyswang on 2017/8/3.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSColorExport <JSExport>

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end

@interface JSColor : UIColor <JSColorExport>

@end
