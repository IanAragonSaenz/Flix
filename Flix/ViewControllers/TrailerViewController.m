//
//  TrailerViewController.m
//  Flix
//
//  Created by Ian Andre Aragon Saenz on 26/06/20.
//  Copyright © 2020 IanAragon. All rights reserved.
//

#import "TrailerViewController.h"
#import "WebKit/WebKit.h"

@interface TrailerViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *trailerWebView;
@property (weak, nonatomic) NSArray *video;

@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US", self.movie[@"id"]];
    NSURL *url = [NSURL URLWithString:urlString];

    NSURLRequest *request = [NSURLRequest requestWithURL:url
        cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error != nil){
            
        }else{
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *video = dictionary[@"results"];
            
            NSURL *urlVideo = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@", video[0][@"key"]]];
            
            NSURLRequest *requestVideo = [NSURLRequest requestWithURL:urlVideo cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
            
            // Load Request into WebView.
            [self.trailerWebView loadRequest:requestVideo];
            
        }
    }];
    [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
