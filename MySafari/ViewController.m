//
//  ViewController.m
//  MySafari
//
//  Created by Lydia Moraga on 4/3/15.
//  Copyright (c) 2015 Lydia Moraga. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fullURL =@"http://www.apple.com.sg";
    NSURL *url = [NSURL URLWithString: fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest: requestObj];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)urlTextField {
    
    //NSString *fullURL = urlTextField.text;
    NSString *fullURL =[NSString stringWithFormat: @"http://www.%@", urlTextField.text];
    NSURL *url = [NSURL URLWithString: fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest: requestObj];
   
    
    return YES;
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    //self.backButton.enabled = YES;
    //forwardButton.enabled = NO;
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    self.backButton.enabled = (self.webView.canGoBack);
    self.forwardButton.enabled = (self.webView.canGoForward);
}

- (IBAction)onBackButtonPressed:(UIButton *)sender {
    [self.webView goBack];
}

- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    [self.webView goForward];
}

- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {
    [self.webView stopLoading];
}

- (IBAction)onReloadButtonPressed:(UIButton *)sender {
    [self.webView reload];
}

@end
