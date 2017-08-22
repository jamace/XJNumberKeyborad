//
//  XJKeyboradButton.h
//  XJNumberKeyborad
//
//  Created by 肖吉 on 2017/8/18.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XJKeyboradButtonDelegate <NSObject>

-(void)didClickKeyboradButton:(UIButton *)button;

@end
@interface XJKeyboradButton : UIButton
-(instancetype)initWithTitle:(NSString *)title tag:(NSUInteger)tag delegate:(id<XJKeyboradButtonDelegate>)delegate;
@property (nonatomic, assign) id<XJKeyboradButtonDelegate> delegate;
@end
