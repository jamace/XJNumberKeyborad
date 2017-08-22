//
//  XJKeyboradButton.m
//  XJNumberKeyborad
//
//  Created by 肖吉 on 2017/8/18.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import "XJKeyboradButton.h"

@implementation XJKeyboradButton

-(instancetype)initWithTitle:(NSString *)title tag:(NSUInteger)tag delegate:(id<XJKeyboradButtonDelegate>)delegate
{
    XJKeyboradButton *button = [XJKeyboradButton buttonWithType:UIButtonTypeCustom];
    button.delegate = delegate;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"whitebg"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"whiteselect"] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:30.0f];
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.tag = tag;
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

-(void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(didClickKeyboradButton:)]) {
        [self.delegate didClickKeyboradButton:btn];
    }
}
@end
