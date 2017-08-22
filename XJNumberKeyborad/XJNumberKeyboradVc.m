//
//  XJNumberKeyboradVc.m
//  XJNumberKeyborad
//
//  Created by 肖吉 on 2017/8/18.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import "XJNumberKeyboradVc.h"
#import "XJKeyBoradView.h"


@interface XJNumberKeyboradVc ()
@property (weak, nonatomic) IBOutlet UITextField *numTextF;
@property (weak, nonatomic) IBOutlet UITextField *numTextF1;

@end

@implementation XJNumberKeyboradVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numTextF.inputView = [[XJKeyBoradView alloc] init];
    self.numTextF1.inputView = [[XJKeyBoradView alloc] init];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    NSLog(@"%@--------%@",self.numTextF.text,self.numTextF1.text);
}

@end
