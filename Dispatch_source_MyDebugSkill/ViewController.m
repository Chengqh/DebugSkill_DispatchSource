
//  当在任意位置添加断点的时候，系统会发送一种信号，而调试中的代码会接受到这信号并创建成source,所以会执行 dispatch_source_set_event_handler(source, ^{ 中的代码 });

// 这样的话,这个应用就有了调试感应的功能,这样就可以使用LLDB 查看当前controller中的所有实力变量。使用这个方法，你可以更新 UI、查询类的属性，甚至是执行方法——所有这一切都不需要重启应用并到达某个特定的工作状态。相当优美吧！

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
