//
//  FISViewController.m
//  theFinalCountdown
//
//  Created by Joe Burgess on 7/9/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController ()
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *pause;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) NSInteger timeCountdownSetting;

@property (nonatomic) BOOL isPaused;
@property (nonatomic) NSInteger pausedTime;
@property (nonatomic) BOOL hasStarted;

@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.time.hidden = YES;
    self.datePicker.hidden = NO;
    self.pause.enabled = NO;
    
    
    self.time.text = @"0:00";
    self.timeCountdownSetting = self.datePicker.countDownDuration;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startTapped:(id)sender {
    self.timeCountdownSetting = self.datePicker.countDownDuration;
    if (!self.hasStarted) {
    self.time.hidden = NO;
    self.datePicker.hidden = YES;
    self.pause.enabled = YES;
    [self.startButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.isPaused = NO;
    self.hasStarted = YES;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownIncrement:) userInfo:Nil repeats:YES];
    }else{
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        self.time.hidden = YES;
        self.datePicker.hidden = NO;
        self.pause.enabled = NO;
        self.isPaused = NO;
        self.hasStarted = NO;
        [self.timer invalidate];
        self.time.text = @"0:00";
        
    }
    
}

-(void)countDownIncrement:(NSTimer *)timer{

    self.timeCountdownSetting = self.timeCountdownSetting -1;
    
    NSInteger mintutes = self.timeCountdownSetting / 60;
    NSInteger seconds = self.timeCountdownSetting % 60;
    
    self.time.text = [NSString stringWithFormat:@"%li:%li",mintutes,seconds];
    
    
    
    if (self.timeCountdownSetting <= 0) { [self.timer invalidate];}
}



- (IBAction)pause:(id)sender {
    
    if (!self.isPaused) {
        self.pausedTime = self.timeCountdownSetting;
        self.timeCountdownSetting = 1;
        [self.timer invalidate];
        self.isPaused = YES;
        
        NSInteger mintutes = self.pausedTime / 60;
        NSInteger seconds = self.pausedTime % 60;
        
        self.time.text = [NSString stringWithFormat:@"%li:%li",mintutes,seconds];
        

        
    }else{
        
        self.timeCountdownSetting = self.pausedTime;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownIncrement:) userInfo:Nil repeats:YES];
        self.isPaused = NO;
    }
    
    
}


@end
