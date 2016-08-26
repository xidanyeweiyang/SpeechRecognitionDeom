//
//  ViewController.h
//  kedaxunfei
//
//  Created by 刘明 on 16/8/9.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeechView.h"
#import "iflyMSC/iflyMSC.h"
#import "ISRDataHelper.h"

//注意要添加语音合成代理
@interface ViewController : UIViewController<IFlyRecognizerViewDelegate,IFlySpeechRecognizerDelegate,SpeechViewDelegate>
//声明语音合成的对象

@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//科大讯飞界面

@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;//不带界面的识别对象


@property (nonatomic, strong) NSMutableString *result;

@property (nonatomic, strong) NSString *resultString;


@property (weak, nonatomic) IBOutlet UITextView *content;

- (IBAction)Start:(id)sender;

@property (nonatomic, strong) NSString *pcmFilePath;//音频文件路径

@property (nonatomic, strong) SpeechView *speechView;//自定义界面

@property (nonatomic, assign) BOOL isCanceled;

@property (nonatomic, copy) NSString *UIString;  //区分是自定义界面 还是科大讯飞界面

@property (nonatomic, copy) NSString *previousContentText;
@end

