//
//  OneView.m
//  LuciferKit
//
//  Created by Lucifer on 2018/8/27.
//  Copyright © 2018年 Lucifer. All rights reserved.
//

#import "OneView.h"

@implementation OneView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    return [super hitTest:point
                withEvent:event];
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    return [super pointInside:point
                    withEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

-(UIResponder *)nextResponder {
    
    return [super nextResponder];
}

@end
