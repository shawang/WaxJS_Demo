//
//  ViewController.m
//  WaxJs
//
//  Created by anyswang on 2017/8/3.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import "ViewController.h"
#import "JSView.h"
#import "JSColor.h"
#import "WJContext.h"
#import <AudioToolbox/AudioToolbox.h>
#import "JSAudioUtil.h"

@interface ViewController ()

@property (nonatomic, retain) WJContext *jsContext;

@property (nonatomic, retain) NSArray *numberButtons;

@property (nonatomic, retain) UIButton *dotButton;

@property (nonatomic, retain) UIButton *addButton;
@property (nonatomic, retain) UIButton *minusButton;
@property (nonatomic, retain) UIButton *multiplyButton;
@property (nonatomic, retain) UIButton *divideButton;
@property (nonatomic, retain) UIButton *amountButton;
@property (nonatomic, retain) UIButton *addminusButton;
@property (nonatomic, retain) UIButton *acButton;

@property (nonatomic, retain) UIButton *mcButton;
@property (nonatomic, retain) UIButton *mAddButton;
@property (nonatomic, retain) UIButton *mMinusButton;
@property (nonatomic, retain) UIButton *mrButton;

@property (nonatomic, retain) UIImageView *topImageView;

@property (nonatomic, retain) NSMutableDictionary *soundIDs;

@end

@implementation ViewController

@synthesize screenView = _screenView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:228.f/255.f green:227.f/255.f blue:226.f/255.f alpha:1.f];
    
    _topImageView = [[UIImageView alloc] init];
    [self.view addSubview:_topImageView];
    _topImageView.image = [UIImage imageNamed:@"cal_text.png"];
    _topImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _dotButton = [self addButtonWidthNormal:@"dot.png" andHighlighted:@"dot_down.png" andTag:ButtonTag_dot];
    _addButton = [self addButtonWidthNormal:@"add.png" andHighlighted:@"add_down.png" andTag:ButtonTag_add];
    _minusButton = [self addButtonWidthNormal:@"minus.png" andHighlighted:@"minus_down.png" andTag:ButtonTag_minuns];
    _multiplyButton = [self addButtonWidthNormal:@"multiply.png" andHighlighted:@"multiply_down.png" andTag:ButtonTag_multiply];
    _divideButton = [self addButtonWidthNormal:@"div.png" andHighlighted:@"div_down.png" andTag:ButtonTag_divide];
    _amountButton = [self addButtonWidthNormal:@"amount.png" andHighlighted:@"amount_down.png" andTag:ButtonTag_amount];
    _addminusButton = [self addButtonWidthNormal:@"addminus.png" andHighlighted:@"addminus_down.png" andTag:ButtonTag_addminus];
    _acButton = [self addButtonWidthNormal:@"ac.png" andHighlighted:@"ac_down.png" andTag:ButtonTag_ac];
    
    _mcButton = [self addButtonWidthNormal:@"mc.png" andHighlighted:@"mc_down.png" andTag:ButtonTag_mc];
    _mAddButton = [self addButtonWidthNormal:@"madd.png" andHighlighted:@"madd_down.png" andTag:ButtonTag_mAdd];
    _mMinusButton = [self addButtonWidthNormal:@"mminus.png" andHighlighted:@"mminus_down.png" andTag:ButtonTag_mMinus];
    _mrButton = [self addButtonWidthNormal:@"mr.png" andHighlighted:@"mr_down.png" andTag:ButtonTag_mr];
    
    NSMutableArray *numberViews = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < 10; i++) {
        UIView *view = [self addButtonWidthNormal:[NSString stringWithFormat:@"d%d.png", i] andHighlighted:[NSString stringWithFormat:@"d%d_down.png", i] andTag:i];
        [numberViews addObject:view];
    }
    _numberButtons = numberViews;
    
    _screenView = [[WJScreenView alloc] init];
    [self.view addSubview:_screenView];
    
    [self layout];
    
    NSString*  bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"JavaScript"];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.%@", bundlePath, @"ViewController", @"js"];
    NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    //创建虚拟机
    JSVirtualMachine *vm = [[JSVirtualMachine alloc] init];
    
    //创建上下文
    _jsContext = [[WJContext alloc] initWithVirtualMachine:vm];
    
    _jsContext[@"self"] = self;
    [_jsContext importClass:JSAudioUtil.class];
    
    [_jsContext evaluateScript:script];
}

- (UIButton *)addButtonWidthNormal:(NSString *)normal andHighlighted:(NSString *)highlighted andTag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    button.tag = tag;
    [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)onButtonClick:(UIButton *)button
{
    JSValue *buttonEvent = _jsContext[@"onButtonClick"];
    [buttonEvent callWithArguments:@[@(button.tag)]];
}

- (void)layout
{
    _topImageView.frame = CGRectMake(0, 40, self.view.frame.size.width, 12);
    
    CGFloat screenWidth = self.view.frame.size.width-30;
    CGFloat screenHeight = screenWidth*30/102;
    _screenView.frame = CGRectMake((self.view.frame.size.width-screenWidth)/2, _topImageView.frame.origin.y + _topImageView.frame.size.height+20, screenWidth, screenHeight);
    
    int row = 6;
    int column = 4;
    
    CGFloat cellWidth = _screenView.frame.size.width/column;
    CGFloat cellHeight = cellWidth*225/261;
    
    CGFloat offsetY = _screenView.frame.origin.y + _screenView.frame.size.height + 40;
    CGFloat offseX = (self.view.frame.size.width - _screenView.frame.size.width)/2;
    
    for (int i = 0; i < row; i++) {
        
        for (int j = 0; j < column; j++) {
            UIView *view;
            if (i == 0) {
                if (j == 0) view = _mcButton;
                else if (j == 1) view = _mAddButton;
                else if (j == 2) view = _mMinusButton;
                else if (j == 3) view = _mrButton;
            }else if (i == 1) {
                if (j == 0) view = _acButton;
                else if (j == 1) view = _addminusButton;
                else if (j == 2) view = _divideButton;
                else if (j == 3) view = _multiplyButton;
            }else if ( i >= 2 && i <= 4 && j <= 2) {
                view = [_numberButtons objectAtIndex:(4-i)*3+j+1];
            }else if ( i == 2 && j == 3) {
                view = _minusButton;
            }else if ( i == 3 && j == 3) {
                view = _addButton;
            }else if ( i == 4 && j == 3) {
                view = _amountButton;
            }else if ( i == 5 && j == 0) {
                view = [_numberButtons objectAtIndex:0];
            }else if ( i == 5 && j == 2) {
                view = _dotButton;
            }
            
            if ( i == 4 && j == 3) {
                view.frame = CGRectMake(j*cellWidth+offseX, i*cellHeight+offsetY, cellWidth, cellHeight*2);
            }else if ( i == 5 && j == 0) {
                view.frame = CGRectMake(j*cellWidth+offseX, i*cellHeight+offsetY, cellWidth*2, cellHeight);
            }else{
                view.frame = CGRectMake(j*cellWidth+offseX, i*cellHeight+offsetY, cellWidth, cellHeight);
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
