//
//  ViewController.m
//  kedaxunfei
//
//  Created by 刘明 on 16/8/9.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)didSpeechCacncelBtn{
    
    self.content.text = self.previousContentText;
    
    [self.iFlySpeechRecognizer cancel];

    [self.speechView removeFromSuperview];
}

- (void)didSpeechFinishedBtn{

    
    [self.speechView removeFromSuperview];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.content.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.content.layer.borderWidth = 1;
    self.UIString = @"kedaUI";

    
    self.iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    
    SpeechView *speechView = [[SpeechView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.speechView.delegate = self;
    
    self.speechView = speechView;
    
    //demo录音文件保存路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    _pcmFilePath = [[NSString alloc] initWithFormat:@"%@",[cachePath stringByAppendingPathComponent:@"asr.pcm"]];

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.view = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"%s",__func__);
    
    if ([self.UIString isEqualToString:@"kedaUI"]) {//无界面
        [_iFlySpeechRecognizer cancel]; //取消识别
        [_iFlySpeechRecognizer setDelegate:nil];
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    }
    else
    {
        [_iflyRecognizerView cancel]; //取消识别
        [_iflyRecognizerView setDelegate:nil];
        [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    }

    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s",__func__);
    

    
    [super viewWillAppear:animated];
    
    [self initRecognizer];//初始化识别对象
    

}

- (void)initRecognizer{
    
        if ([self.UIString isEqualToString:@"kedaUI"]) {
            
            //单例模式，UI的实例
            if (_iflyRecognizerView == nil) {
                //UI显示剧中
                _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
                
                [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
                
                //设置听写模式
                [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
                
            }
        
        self.iflyRecognizerView.delegate = self;
            
            [self.iflyRecognizerView setParameter:@"30000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            
            [self.iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
            
            [self.iflyRecognizerView setParameter:@"6000" forKey:[IFlySpeechConstant VAD_BOS]];
            
            [self.iflyRecognizerView setParameter:@"700" forKey:[IFlySpeechConstant VAD_EOS]];
            
            [self.iflyRecognizerView setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            [self.iflyRecognizerView setParameter:@"1" forKey:[IFlySpeechConstant ASR_PTT]];
            
            [self.iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
            
            [self.iflyRecognizerView setParameter:@"temp.asr" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
            
            [self.iflyRecognizerView setParameter:@"custom" forKey:[IFlySpeechConstant PARAMS]];
            

    }else{
        
        if (_iFlySpeechRecognizer == nil) {
            _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
            
            [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
            
            //设置听写模式
            [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        }
        
        self.iFlySpeechRecognizer.delegate = self;
        
        self.speechView.delegate = self;
        
        [self.iFlySpeechRecognizer setParameter:@"30000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        
        [self.iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
        [self.iFlySpeechRecognizer setParameter:@"6000" forKey:[IFlySpeechConstant VAD_BOS]];
        
        [self.iFlySpeechRecognizer setParameter:@"700" forKey:[IFlySpeechConstant VAD_EOS]];
        
        [self.iFlySpeechRecognizer setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        [self.iFlySpeechRecognizer setParameter:@"1" forKey:[IFlySpeechConstant ASR_PTT]];
        
        [self.iFlySpeechRecognizer setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        [self.iFlySpeechRecognizer setParameter:@"temp.asr" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        [self.iFlySpeechRecognizer setParameter:@"custom" forKey:[IFlySpeechConstant PARAMS]];
        

    }
}

- (IBAction)kedaUIbTN:(id)sender {
    
    self.UIString = @"kedaUI";

}
- (IBAction)selfUIBtn:(id)sender {
    
    self.UIString = @"selfUI";

}

- (IBAction)Start:(id)sender {
    
    self.previousContentText = self.content.text;
    
    if (![self.UIString isEqualToString:@"kedaUI"]) {//无界面
        
        [_content setText:@""];
        [_content resignFirstResponder];
        self.isCanceled = NO;
        
        if(_iFlySpeechRecognizer == nil)
        {
            [self initRecognizer];
        }
        
        [_iFlySpeechRecognizer cancel];
        
        //设置音频来源为麦克风
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //设置听写结果格式为json
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        [_iFlySpeechRecognizer setDelegate:self];

        
        BOOL ret = [_iFlySpeechRecognizer startListening];
        
        if (ret) {
        
            [self.view addSubview:_speechView];
//            
        }else{
            [_speechView showText: @"启动识别服务失败，请稍后重试"];//可能是上次请求未结束，暂不支持多路并发
        }
    }else {
        
        if(_iflyRecognizerView == nil)
        {
            [self initRecognizer ];
        }
        
        [_content setText:@""];
        [_content resignFirstResponder];
        
        //设置音频来源为麦克风
        [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //设置听写结果格式为json
        [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
        [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        [_iflyRecognizerView start];
    }

    
//    [self.content resignFirstResponder];

}

- (void) onVolumeChanged: (int)volume
{
    if (self.isCanceled) {
        [_speechView removeFromSuperview];
        return;
    }
    
    NSString * vol = [NSString stringWithFormat:@"音量：%d",volume];
    
    _speechView.volume = volume;
    [_speechView showText: vol];
}

/**
 听写结束回调（注：无论听写是否正确都会回调）
 error.errorCode =
 0     听写正确
 other 听写出错
 ****/
- (void) onError:(IFlySpeechError *) error
{
    NSLog(@"%s",__func__);
    
    if ([self.UIString isEqualToString:@"selfUI"]) {
        NSString *text ;
        
        if (self.isCanceled) {
            text = @"识别取消";
            
        } else if (error.errorCode == 0 ) {
            if (_result.length == 0) {
                text = @"无识别结果";
            }else {
                text = @"识别成功";
            }
        }else {
            text = [NSString stringWithFormat:@"发生错误：%d %@", error.errorCode,error.errorDesc];
            NSLog(@"%@",text);
        }
        
        [_speechView showText: text];
        
    }else {
        [_speechView showText:@"识别结束"];
        NSLog(@"errorCode:%d",[error errorCode]);
    }
    
}

/**
 无界面，听写结果回调
 results：听写结果
 isLast：表示最后一次
 ****/
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    _result =[NSString stringWithFormat:@"%@",resultString].mutableCopy;
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    self.resultString = resultFromJson;
    _content.text = [NSString stringWithFormat:@"%@%@", _content.text,resultFromJson];
    
    if (isLast){
        NSLog(@"听写结果(json)：%@测试",  self.result);
    }
    NSLog(@"_result=%@",_result);
    NSLog(@"resultFromJson=%@",resultFromJson);
    NSLog(@"isLast=%d,_textView.text=%@",isLast,_content.text);
}



/**
 有界面，听写结果回调
 resultArray：听写结果
 isLast：表示最后一次
 ****/
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    
    self.resultString = result.copy;
    _content.text = [NSString stringWithFormat:@"%@%@",_content.text,result];
}

/**
 开始识别回调
 ****/
- (void) onBeginOfSpeech
{
    NSLog(@"onBeginOfSpeech");
    [_speechView showText: @"正在录音"];
}

/**
 停止录音回调
 ****/
- (void) onEndOfSpeech
{
    NSLog(@"onEndOfSpeech");
    
    [_speechView showText: @"停止录音"];
}


@end
