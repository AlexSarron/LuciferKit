//
//  LuciferTimer.h
//  LuciferKit
//
//  Created by Lucifer on 2018/8/23.
//  Copyright © 2018年 Lucifer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LuciferTimer : NSObject

@property (nonatomic, assign, readonly) NSTimeInterval timeIntervalMs;
@property (nonatomic, assign, readonly) NSTimeInterval leewayMs;
@property (nonatomic, assign, readonly) dispatch_queue_t queue;
@property (nonatomic, assign, readonly) BOOL isPolling;
@property (nonatomic, assign) NSInteger tag;

- (instancetype)initWithTimeInterval:(NSTimeInterval)timeIntervalMs
                          leeway:(NSTimeInterval)leewayMs
                           queue:(dispatch_queue_t)queue
                         handleBlock:(void (^)(LuciferTimer *timer))handleBlock;

- (void)startPollingWithDelay:(NSTimeInterval)delay;

- (void)stopPolling;

- (void)refreshWithTimeInterval:(NSTimeInterval)timeIntervalMs
                         leeway:(NSTimeInterval)leewayMs
                    handleBlock:(void (^)(LuciferTimer *timer))handleBlock;

@end
