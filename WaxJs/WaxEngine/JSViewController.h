//
//  JSViewController.h
//  WaxJs
//
//  Created by anyswang on 2017/8/7.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSViewControllerExport <JSExport>

@property(null_resettable, nonatomic,strong) UIView *view;

@end

@interface JSViewController : UIViewController <JSViewControllerExport>

@end
