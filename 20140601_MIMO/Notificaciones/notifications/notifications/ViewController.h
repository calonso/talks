//
//  ViewController.h
//  notifications
//
//  Created by Carlos on 18/03/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    IBOutlet UIView *loadingView;
    IBOutlet UIButton *btn;
    
    NSString *token;
}

- (void) setDevicetoken:(NSString *)deviceToken;

@end
