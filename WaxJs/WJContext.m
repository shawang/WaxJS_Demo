//
//  WJContext.m
//  WaxJs
//
//  Created by anyswang on 2017/8/7.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import "WJContext.h"
#import "JSColor.h"
#import "JSView.h"

@implementation WJContext

- (instancetype)init
{
    if (self == [super init]) {
        [self initCommon];
    }
    return self;
}

- (instancetype)initWithVirtualMachine:(JSVirtualMachine *)virtualMachine
{
    if (self == [super initWithVirtualMachine:virtualMachine]) {
        [self initCommon];
    }
    return self;
}

- (void)initCommon
{
    self.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"exception : %@", exception);
        context.exception = exception;
    };
    
    self[@"log"] = ^(NSString *log) {
        NSLog(@"%@", log);
    };
    
    NSString*  bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"JavaScript"];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.%@", bundlePath, @"common", @"js"];
    NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    [self evaluateScript:script];
    
    self[@"UIColor"] = JSColor.class;
    self[@"UIView"] = JSView.class;
}

- (void)importClass:(Class)importClass
{
    self[NSStringFromClass(importClass)] = importClass;
}

@end
