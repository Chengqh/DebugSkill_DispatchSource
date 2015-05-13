//
//  ViewController.m
//  Dispatch_source_MyDebugSkill
//
//  Created by cqh on 15/5/13.
//  Copyright (c) 2015年 Cnepay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1
#if DEBUG
    // 2
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 3
    static dispatch_source_t source = nil;
    
    // 4
    __typeof(self) __weak weakSelf = self;
    
    // 5
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 6
        source = dispatch_source_create(DISPATCH_SOURCE_TYPE_SIGNAL, SIGSTOP, 0, queue);
        
        // 7
        if (source)
        {
            // 8
            dispatch_source_set_event_handler(source, ^{
                // 9
                NSLog(@"Hi, I am: %@", weakSelf);
            });
            dispatch_resume(source); // 10
        }
    });
#endif
}

@end
