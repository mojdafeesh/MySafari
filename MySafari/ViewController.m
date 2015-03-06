//
//  ViewController.m
//  MySafari
//
//  Created by Lydia Moraga on 4/3/15.
//  Copyright (c) 2015 Lydia Moraga. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *alertButton;
@property (weak, nonatomic) IBOutlet UILabel *currentPageTitle;

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
    NSString *fullURL =[NSString stringWithFormat: @"http://%@", urlTextField.text];
    NSURL *url = [NSURL URLWithString: fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest: requestObj];
    
    //adds a delete button on the address bar
    self.urlTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    return YES;
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  

    //self.backButton.enabled = YES;
    //self.forwardButton.enabled = NO;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    self.backButton.enabled = (self.webView.canGoBack);
    
    self.forwardButton.enabled = (self.webView.canGoForward);
    
    NSString *currentPageTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.currentPageTitle.text = currentPageTitle;
    
    [self.webView.scrollView setDelegate:self];
    
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

- (IBAction)myAlertPressed:(UIButton *)sender {
//    + (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle;
//    
//    - (void)addAction:(UIAlertAction *)action;
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"All New Stuff"
                                  message:@"Coming Soon!"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
 
}

-(void)updateAddress:(NSURLRequest *)request
{
    NSURL* url= [request mainDocumentURL];
    NSString* absoluteString = [url absoluteString];
    self.urlTextField.text = absoluteString;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [self updateAddress:request];
    return YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}


@end
