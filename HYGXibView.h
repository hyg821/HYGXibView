//
//  HYGXibView.h
//  cvcv
//
//  Created by 侯英格 on 2016/9/29.
//  Copyright © 2016年 侯英格. All rights reserved.
//

#import <UIKit/UIKit.h>

//继承这个view 默认会开启 父view 完全包含子view的模式

/*
    1.需要在某个view的Custom Class 里边设置成 HYGXibView
    2.UIView*view=[[[NSBundle mainBundle] loadNibNamed:@"MyView" owner:self options:nil] firstObject];
      [self.view addSubview:view];
    3.设置view的postion
 
*/

@interface HYGXibView : UIView

@end
