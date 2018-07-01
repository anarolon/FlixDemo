//
//  MovieTrailerViewController.m
//  FlixDemo
//
//  Created by Chaliana Rolon on 6/29/18.
//  Copyright © 2018 Chaliana Rolon. All rights reserved.
//

#import "MovieTrailerViewController.h"
#import "UIWebView+AFNetworking.h"

@interface MovieTrailerViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *trailerView;
@property (strong, nonatomic) NSArray *keyForVideo;

@end

@implementation MovieTrailerViewController

// https://api.themoviedb.org/3/movie/{movie_id}/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-U
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *baseURLString = @"https://api.themoviedb.org/3/movie/";
    NSString *trailerURLString = [[baseURLString stringByAppendingString:self.id] stringByAppendingString:@"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"];
    NSURL *trailerURL = [NSURL URLWithString:trailerURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:trailerURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *videoData = dataDictionary[@"results"];
            
            self.keyForVideo = [videoData valueForKey:@"key"];
            NSString *baseVidURL = @"https://www.youtube.com/watch?v=";
            NSString *videoURL = [baseVidURL stringByAppendingString:self.keyForVideo[0]];
            NSURL *video = [NSURL URLWithString:videoURL];
            [self.trailerView loadRequest:[NSURLRequest requestWithURL:video cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0]];
        }
    }];
    
   [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
