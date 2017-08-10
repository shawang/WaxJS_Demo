//
//  ViewController.h
//  WaxJs
//
//  Created by anyswang on 2017/8/3.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSViewController.h"
#import "WJScreenView.h"

typedef enum {
    ButtonTag_mr = -12,
    ButtonTag_mMinus = -11,
    ButtonTag_mAdd = -10,
    ButtonTag_mc = -9,
    ButtonTag_ac = -8,
    ButtonTag_addminus = -7,
    ButtonTag_amount = -6,
    ButtonTag_divide = -5,
    ButtonTag_multiply = -4,
    ButtonTag_minuns = -3,
    ButtonTag_add = -2,
    ButtonTag_dot = -1,
    ButtonTag_0 = 0,
    ButtonTag_1 = 1,
    ButtonTag_2 = 2,
    ButtonTag_3 = 3,
    ButtonTag_4 = 4,
    ButtonTag_5 = 5,
    ButtonTag_6 = 6,
    ButtonTag_7 = 7,
    ButtonTag_8 = 8,
    ButtonTag_9 = 9,
}ButtonTag;

@protocol ViewControllerExport <JSExport>

@property (nonatomic, retain) WJScreenView *screenView;

@end

@interface ViewController : JSViewController <ViewControllerExport>


@end

