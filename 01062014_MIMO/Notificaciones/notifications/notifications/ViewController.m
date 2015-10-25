//
//  ViewController.m
//  notifications
//
//  Created by Carlos on 18/03/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void) setDevicetoken:(NSString *)deviceToken {
    token = deviceToken;
    btn.enabled = deviceToken != nil;
    [loadingView removeFromSuperview];
}

- (IBAction)requestNotification {
    // Prepare the body
    NSDictionary *jsonObject = @{@"name": @"My name", @"token": token};
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
    
    // Prepare the request
    NSURL *url = [NSURL URLWithString:@"http://mimo-apns.herokuapp.com/users/greet"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Send and handle the request asynchronously
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error) {
                               
                               int code = [(NSHTTPURLResponse *)response statusCode];
                               if (code == 200 && error == nil) {
                                   NSLog(@"Notification successfully requested");
                               } else if(error != nil) {
                                   NSLog(@"An error happened: %@", [error localizedDescription]);
                               } else {
                                   NSLog(@"A %d error happened", code);
                               }
                           }];
}

@end
