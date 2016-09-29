//
//  HYGXibView.m
//  cvcv
//
//  Created by 侯英格 on 2016/9/29.
//  Copyright © 2016年 侯英格. All rights reserved.
//

#import "HYGXibView.h"

@interface HYGXibView()

@property(nonatomic,strong)NSMutableDictionary*subViewFrameCache;

@end

@implementation HYGXibView

-(void)awakeFromNib{
    [super awakeFromNib];
    for (UIView*subView in self.subviews) {
        [subView addObserver:self forKeyPath:@"layer.position" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context{
    UIView*view=(UIView*)object;
    [self.subViewFrameCache setValue:[NSValue valueWithCGRect:view.frame] forKey:[NSString stringWithFormat:@"%lu",[object hash]]];
    if ([self.subViewFrameCache allKeys].count==self.subviews.count) {
        [self setNewFrame];
    }
}

-(void)setNewFrame{
    CGFloat maxWidth=0;
    CGFloat maxHight=0;
    CGRect bounds=CGRectZero;
    for (NSValue*value in self.subViewFrameCache.allValues) {
        CGRect frame = [value CGRectValue];
        if (maxWidth<frame.origin.x+frame.size.width) {
            maxWidth=frame.origin.x+frame.size.width;
        }
        if (maxHight<frame.origin.y+frame.size.height) {
            maxHight=frame.origin.y+frame.size.height;
        }
    }
    bounds=CGRectMake(0, 0, maxWidth, maxHight);
    self.frame=bounds;
}

-(NSMutableDictionary *)subViewFrameCache{
    if (!_subViewFrameCache) {
        _subViewFrameCache=[NSMutableDictionary dictionary];
    }
    return _subViewFrameCache;
}

-(void)dealloc{
    for (UIView*subView in self.subviews) {
        [subView removeObserver:self forKeyPath:@"layer.position" context:nil];
    }
}

@end
