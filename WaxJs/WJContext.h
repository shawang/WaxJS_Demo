//
//  WJContext.h
//  WaxJs
//
//  Created by anyswang on 2017/8/7.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>

@interface WJContext : JSContext

- (void)importClass:(Class)importClass;

@end
