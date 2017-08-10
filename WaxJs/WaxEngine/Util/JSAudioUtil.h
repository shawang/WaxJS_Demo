//
//  JSAudioUtil.h
//  WaxJs
//
//  Created by anyswang on 2017/8/8.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSAudioUtilExport <JSExport>

+ (void)playSystemSound:(UInt32)soundID;

@end

@interface JSAudioUtil : NSObject <JSAudioUtilExport>

@end
