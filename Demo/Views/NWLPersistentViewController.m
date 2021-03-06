//
//  NWLPersistentViewController.m
//  NWLogging
//
//  Copyright (c) 2012 noodlewerk. All rights reserved.
//

#import "NWLPersistentViewController.h"
#import "NWLLogViewController.h"
#import "NWLMultiLogger.h"
#import "NWLFilePrinter.h"


@implementation NWLPersistentViewController {
    UIButton *_fileButton;
    UIButton *_tickButton;
    NSTimer *_timer;
    NWLFilePrinter *_printer;
}

NWLFilePrinter *NWLPersistentPrinter;
NSTimer *NWLPersistentTimer;

+ (NWLFilePrinter *)printer
{
    return NWLPersistentPrinter;
}


#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"File Printer";

    UITextView *about = [[UITextView alloc] init];
    about.textAlignment = UITextAlignmentLeft;
    about.font = [UIFont systemFontOfSize:10];
    about.scrollEnabled = NO;
    about.editable = NO;
    about.text = @"NWLFilePrinter provides persistent logging. Turn on file logging and return to the previous demos. Then open the log view, which will be prepopulated with the log file content.\n\nTurn on 'Ticking' to schedule a log call every second. Again, the result of this can be viewed in the 'Log View' demo, accessible from the menu.";
    CGFloat height = [about.text sizeWithFont:about.font constrainedToSize:CGSizeMake(self.view.bounds.size.width - 20, 1000) lineBreakMode:UILineBreakModeWordWrap].height + 10;
    about.frame = CGRectMake(10, 10, self.view.bounds.size.width - 20, height);
    [self.view addSubview:about];

    _fileButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _fileButton.frame = CGRectMake(10, height + 20, self.view.bounds.size.width - 20, 40);
    [_fileButton addTarget:self action:@selector(toggleFileLogger) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_fileButton];

    _tickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _tickButton.frame = CGRectMake(10, height + 70, self.view.bounds.size.width - 20, 40);
    [_tickButton addTarget:self action:@selector(toggleTick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_tickButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _printer = NWLPersistentPrinter; NWLPersistentPrinter = nil;
    _timer = NWLPersistentTimer; NWLPersistentTimer = nil;
    [self updateUI];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NWLPersistentPrinter = _printer; _printer = nil;
    NWLPersistentTimer = _timer; _timer = nil;
}


#pragma mark - Actions

- (void)toggleFileLogger
{
    if (_printer) {
        [NWLMultiLogger.shared removePrinter:_printer]; _printer = nil;
    } else {
        _printer = [[NWLFilePrinter alloc] initAndOpenName:@"demo"];
        [NWLMultiLogger.shared addPrinter:_printer];
    }
    [self updateUI];
}

- (void)toggleTick
{
    if (_timer) {
        [_timer invalidate]; _timer = nil;
    } else {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(log) userInfo:nil repeats:YES];
    }
    [self updateUI];
}

- (void)log
{
    NWLog(@"NWLog(@\"tick\");");
    NWLogInfo(@"NWLogInfo(@\"tick\");");
    NWLogDbug(@"NWLogDbug(@\"tick\");");
}

- (void)updateUI
{
    if (_printer) {
        [_fileButton setTitle:@"Stop recording" forState:UIControlStateNormal];
    } else {
        [_fileButton setTitle:@"Record all logging to file" forState:UIControlStateNormal];
    }
    if (_timer) {
        [_tickButton setTitle:@"Stop tick" forState:UIControlStateNormal];
    } else {
        [_tickButton setTitle:@"Tick every second" forState:UIControlStateNormal];
    }
}

@end
