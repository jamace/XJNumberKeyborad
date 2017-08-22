//
//  XJKeyBoradView.m
//  XJNumberKeyborad
//
//  Created by 肖吉 on 2017/8/18.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import "XJKeyBoradView.h"
#import "XJKeyboradButton.h"

@interface XJKeyBoradView()<XJKeyboradButtonDelegate>
@property (nonatomic, strong) UITextField *responder;
@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, copy)   NSString *formatText;
@end
@implementation XJKeyBoradView

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.formatText = @"";
        [self initViews];
    }
    return self;
}

-(void)initViews
{
    UIView *hiddenView = [[UIView alloc] init];
    hiddenView.backgroundColor = [UIColor whiteColor];
    hiddenView.tag = 100;
    [self addSubview:hiddenView];
    
    UIButton *hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hiddenBtn.tag = 101;
    [hiddenBtn setImage:[UIImage imageNamed:@"hidden"] forState:UIControlStateNormal];
    [hiddenBtn addTarget:self action:@selector(hiddenKeyborad) forControlEvents:UIControlEventTouchUpInside];
    [hiddenView addSubview:hiddenBtn];
    
    XJKeyboradButton *button1 = [[XJKeyboradButton alloc] initWithTitle:@"1" tag:1 delegate:self];
    [self addSubview:button1];
    
    XJKeyboradButton *button2 = [[XJKeyboradButton alloc] initWithTitle:@"2" tag:2 delegate:self];
    [self addSubview:button2];
    
    XJKeyboradButton *button3 = [[XJKeyboradButton alloc] initWithTitle:@"3" tag:3 delegate:self];
    [self addSubview:button3];
    
    XJKeyboradButton *button4 = [[XJKeyboradButton alloc] initWithTitle:@"4" tag:4 delegate:self];
    [self addSubview:button4];
    
    XJKeyboradButton *button5 = [[XJKeyboradButton alloc] initWithTitle:@"5" tag:5 delegate:self];
    [self addSubview:button5];
    
    XJKeyboradButton *button6 = [[XJKeyboradButton alloc] initWithTitle:@"6" tag:6 delegate:self];
    [self addSubview:button6];
    
    XJKeyboradButton *button7 = [[XJKeyboradButton alloc] initWithTitle:@"7" tag:7 delegate:self];
    [self addSubview:button7];
    
    XJKeyboradButton *button8 = [[XJKeyboradButton alloc] initWithTitle:@"8" tag:8 delegate:self];
    [self addSubview:button8];
    
    XJKeyboradButton *button9 = [[XJKeyboradButton alloc] initWithTitle:@"9" tag:9 delegate:self];
    [self addSubview:button9];
    
    XJKeyboradButton *button10 = [[XJKeyboradButton alloc] initWithTitle:@"." tag:10 delegate:self];
    [self addSubview:button10];
    
    XJKeyboradButton *button11 = [[XJKeyboradButton alloc] initWithTitle:@"0" tag:11 delegate:self];
    [self addSubview:button11];
    
    XJKeyboradButton *button12 = [[XJKeyboradButton alloc] initWithTitle:@"" tag:12 delegate:self];
    [self addSubview:button12];
    
    [self.buttonsArray addObject:button1];
    [self.buttonsArray addObject:button2];
    [self.buttonsArray addObject:button3];
    [self.buttonsArray addObject:button4];
    [self.buttonsArray addObject:button5];
    [self.buttonsArray addObject:button6];
    [self.buttonsArray addObject:button7];
    [self.buttonsArray addObject:button8];
    [self.buttonsArray addObject:button9];
    [self.buttonsArray addObject:button10];
    [self.buttonsArray addObject:button11];
    [self.buttonsArray addObject:button12];
    
    //布局
    [self setBtnFrame];
}

-(void)setBtnFrame
{
    self.frame = CGRectMake(0, 0, XJKScreen_Width, XJKeyborad_Height);
    //hidden键盘
    UIView *hiddenView = [self viewWithTag:100];
    hiddenView.frame = CGRectMake(0, 1, XJKScreen_Width, XJKeyborad_Top-1);
    UIButton *hiddenBtn = [self viewWithTag:101];
    hiddenBtn.frame = hiddenView.bounds;
    
    //九宫格布局
    NSUInteger row = 4;         //行
    NSUInteger column = 3;      //列
    CGFloat btnWidth = (XJKScreen_Width - column) / column;
    CGFloat btnHeight = (XJKeyborad_Height - row-XJKeyborad_Top) / row;
    for (int i = 0; i < self.buttonsArray.count; i++) {
        XJKeyboradButton *keyborardBtn = self.buttonsArray[i];
        keyborardBtn.frame = CGRectMake((btnWidth+1)*(i%column), (XJKeyborad_Top+1)+(btnHeight+1)*(i/column), btnWidth, btnHeight);
        if (i == self.buttonsArray.count - 1) {
            //删除
            [keyborardBtn setBackgroundImage:[UIImage imageNamed:@"whiteselect"] forState:UIControlStateNormal];
            [keyborardBtn setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateHighlighted];
            [keyborardBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        }else if ( i == self.buttonsArray.count - 3){
            //小数点
            [keyborardBtn setBackgroundImage:[UIImage imageNamed:@"whiteselect"] forState:UIControlStateNormal];
            [keyborardBtn setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateHighlighted];
        }
    }

}
//键盘隐藏
-(void)hiddenKeyborad
{
    [self.responder resignFirstResponder];
}

//选中了某个数字或者操作
-(void)didClickKeyboradButton:(UIButton *)button
{
    if (button.tag == self.buttonsArray.count) {
        //删除按键
        if (self.formatText.length == 2 && [self.formatText containsString:@"."]) {
            //特殊情况(0.开头的,删除两位)
            self.formatText = [self.formatText substringToIndex:self.formatText.length - 2];
        }else{
            //正常情况（删除一位）
            self.formatText = self.formatText.length?[self.formatText substringToIndex:self.formatText.length - 1]:@"";
        }
    }else{
        //当前选中的数字
        NSString *inputNum = button.titleLabel.text;
        //金额判断
        if ([self.formatText isEqualToString:@""] && [inputNum isEqualToString:@"."]) {
            //第一次点击了小数点
            self.formatText = @"0.";
        }else{
            //首次点击不是.
            self.formatText = [NSString stringWithFormat:@"%@%@",self.formatText,inputNum];
            //连续输入多个0
            if (self.formatText.length&& [[self.formatText substringToIndex:1] isEqualToString:@"0"]) {
                //首位是0
                if (self.formatText.length == 2 && ![[self.formatText substringFromIndex:1] isEqualToString:@"."]) {
                    self.formatText = inputNum;
                }
            }
            //点击了多个小数点情况
            NSArray *pointArray = [self.formatText componentsSeparatedByString:@"."];
            if (pointArray.count>2) {
                self.formatText = [self.formatText substringToIndex:self.formatText.length - 1];
            }
            //小数点后面位数判断（保留两位）
            NSRange range = [self.formatText rangeOfString:@"."];
            if (range.location != NSNotFound) {
                if (self.formatText.length > range.location+3) {
                    self.formatText = [self.formatText substringWithRange:NSMakeRange(0, range.location+3)];
                }
            }
        }
    }
    self.responder.text = self.formatText;
}

- (UITextField *)responder{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    //获取当前window的第一响应者
    UIView *firstResponder = [keyWindow valueForKey:@"firstResponder"];
    _responder = (UITextField *)firstResponder;
    return _responder;
}
-(NSMutableArray *)buttonsArray
{
    if (!_buttonsArray) {
        _buttonsArray = [[NSMutableArray alloc] init];
    }
    return _buttonsArray;
}

@end
