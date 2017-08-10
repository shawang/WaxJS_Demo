//
//  JSAudioUtil.m
//  WaxJs
//
//  Created by anyswang on 2017/8/8.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import "JSAudioUtil.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation JSAudioUtil

+ (void)playSystemSound:(UInt32)soundID
{
    AudioServicesPlaySystemSound(soundID);
}

@end
