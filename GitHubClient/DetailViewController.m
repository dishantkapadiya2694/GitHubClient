//
//  DetailViewController.m
//  GitHubClient
//
//  Created by Dishant Kapadiya on 9/21/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "DetailViewController.h"
#import "CFNEtworkController.h"

@interface DetailViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation DetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
    NSURL *repoURL = [NSURL URLWithString:[self.repo valueForKey:@"html_url"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:repoURL];
    [self.webView loadRequest:request];
}



-(void)setWebView:(UIWebView *)webView
{
    _webView = webView;
    [self.activityIndicator stopAnimating];
}

- (void) webViewDidStartLoad: (UIWebView * ) webView {
    [self.activityIndicator startAnimating];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%@",webView.request.URL.absoluteString);
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.activityIndicator stopAnimating];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setRepo:(NSMutableDictionary *)newRepo {
    if (_repo != newRepo) {
        _repo = newRepo;
        [self configureView];
    }
}


@end
