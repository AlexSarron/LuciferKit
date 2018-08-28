//
//  ViewController.m
//  LuciferKit
//
//  Created by Lucifer on 2018/8/22.
//  Copyright © 2018年 Lucifer. All rights reserved.
//

#import "ViewController.h"
#import "LuciferTimer.h"
#import "Test1.h"
#import "Test2.h"
#import "HitTestView.h"

typedef void (^block)(NSObject *object);

@interface ViewController ()

@property (nonatomic, strong) LuciferTimer *timer;
@property (nonatomic, strong) NSTimer *strongTimer;

@end

@implementation ViewController


//@synthesize object = test;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    Test1 *object1 = [[Test1 alloc] init];
    Test2 *object2 = [[Test2 alloc] init];
    object2.testInt = 11;
    
    Test1 *object3 = (Test1 *)object2;
    __block NSString *str = lucifer;
    
    block block1;
    
    block1 = ^(NSObject *object){
        
        str = @"123";
    };
    
    block blockId = [block1 copy];
    
    blockId = ^(NSObject *object){
        
        str = @"123567";
    };

    self.timer = [[LuciferTimer alloc] initWithTimeInterval:500 leeway:1 queue:dispatch_get_global_queue(0, NULL) handleBlock:^(LuciferTimer *timer) {
       
        NSLog(@"%@", [NSDate date]);
        NSLog(@"%@", [NSThread currentThread]);
    }];
    
    self.strongTimer = [NSTimer timerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
       
        NSLog(@"%@", [NSDate date]);
        NSLog(@"%@", [NSThread currentThread]);
    }];
    
    HitTestView *view = [HitTestView new];
    view.frame = CGRectMake(100, 100, 100, 100);
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
//    [self.timer startPollingWithDelay:false];
}

- (IBAction)Push:(UIButton *)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewController *vc = [sb instantiateInitialViewController];
    
//    ViewController *vc = [ViewController new];
    vc.view.backgroundColor = UIColor.lightGrayColor;
    [self presentViewController:vc animated:true completion:nil];
}

- (IBAction)Pop:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)Start:(UIButton *)sender {
    
//    [self.timer startPollingWithDelay:500];
    dispatch_queue_t queue1 = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue3 = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue4 = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue5 = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue6 = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue1, ^{
        
        [self.timer startPollingWithDelay:500];
    });
    dispatch_async(queue2, ^{
        
        [self.timer startPollingWithDelay:500];
    });
    dispatch_async(queue3, ^{
        
        [self.timer startPollingWithDelay:500];
    });
    dispatch_async(queue4, ^{
        
        [self.timer startPollingWithDelay:500];
    });
    dispatch_async(queue5, ^{
        
        [self.timer startPollingWithDelay:500];
    });
    dispatch_async(queue6, ^{
        
        [self.timer startPollingWithDelay:500];
    });
    
}
- (IBAction)strongTimer:(id)sender {
    
    [[NSRunLoop mainRunLoop] addTimer:self.strongTimer forMode:NSDefaultRunLoopMode];
//    [self.strongTimer fire];
}

- (void)timerAction{
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (UIResponder *)nextResponder {
    
    return [super nextResponder];
}

- (void)dealloc {
    
    NSLog(@"vc dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
