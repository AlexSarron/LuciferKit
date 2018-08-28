//
//  LuciferTimer.m
//  LuciferKit
//
//  Created by Lucifer on 2018/8/23.
//  Copyright © 2018年 Lucifer. All rights reserved.
//

#import "LuciferTimer.h"

typedef void(^LuciferTimerBlock)(LuciferTimer *timer);

@interface LuciferTimer()

@property (nonatomic, assign, readwrite) NSTimeInterval timeIntervalMs;
@property (nonatomic, assign, readwrite) NSTimeInterval leewayMs;
@property (nonatomic, assign, readwrite) dispatch_queue_t queue;
@property (nonatomic, assign, readwrite) BOOL isPolling;
@property (nonatomic, copy) LuciferTimerBlock timerBlock;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) NSLock *lock;

@end

@implementation LuciferTimer

- (instancetype)initWithTimeInterval:(NSTimeInterval)timeIntervalMs
                              leeway:(NSTimeInterval)leewayMs
                               queue:(dispatch_queue_t)queue
                         handleBlock:(void (^)(LuciferTimer *timer))handleBlock {
    
    self = [super init];
    if (self) {
        
        _lock = [[NSLock alloc] init];
        _timeIntervalMs = timeIntervalMs;
        _leewayMs = leewayMs;
        _queue = queue;
        _timerBlock = [handleBlock copy];
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
    }
    
    return self;
}

- (void)startPollingWithDelay:(NSTimeInterval)delay {
    
//    [self.lock lock];
    
    if (self.isPolling) {
        
//        [self.lock unlock];
        return;
    }
    
    dispatch_source_set_timer(self.timer, dispatch_walltime(DISPATCH_TIME_NOW, delay? self.timeIntervalMs * NSEC_PER_MSEC:0), self.timeIntervalMs * NSEC_PER_MSEC, self.leewayMs * NSEC_PER_MSEC);
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(self.timer, ^{
        
        if (weakSelf) {
            
            weakSelf.timerBlock(weakSelf);
        }
    });
    dispatch_resume(self.timer);
    self.isPolling = true;
    
//    [self.lock unlock];
}

- (void)stopPolling {
    
    [self.lock lock];
    
    if (self.isPolling) {
        
        dispatch_suspend(self.timer);
        self.isPolling = false;
    }
    
    [self.lock unlock];
}

- (void)refreshWithTimeInterval:(NSTimeInterval)timeIntervalMs
                         leeway:(NSTimeInterval)leewayMs
                    handleBlock:(void (^)(LuciferTimer *))handleBlock {
    
    [self.lock lock];
    
    BOOL wasPolling = false;
    
    if (self.isPolling) {
        
        dispatch_suspend(_timer);
        wasPolling = true;
        self.isPolling = false;
    }
    
    _timeIntervalMs = timeIntervalMs;
    _leewayMs = leewayMs;
    _timerBlock = [handleBlock copy];
    
    if (wasPolling) {
        
        [self startPollingWithDelay:0];
    }
    
    [self.lock unlock];
}

- (void)dealloc {
    
    dispatch_cancel(self.timer);
    if (!self.isPolling) {
        
        dispatch_resume(self.timer);
    }
}

@end
