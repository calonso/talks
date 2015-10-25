//
//  ViewController.m
//  BitsHandler
//
//  Created by Carlos on 17/04/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (IBAction)convert {
    int value = [numberInputField.text intValue];
    
    int bits[32];
    int i = 0;
    while((1 << i) <= value) {
        bits[i] = (value & (1 << i)) >> i;
        ++i;
    }
    
    NSMutableString *tempResult = [NSMutableString stringWithCapacity:32];
    for (int j = i - 1 ; j >= 0 ; --j) {
        [tempResult appendFormat:@"%d", bits[j], nil];
    }
    bitsResultLabel.text = tempResult;
    
    Byte first = (value & 0xFF000000) >> 24;
    Byte second = (value & 0x00FF0000) >> 16;
    Byte third = (value & 0x0000FF00) >> 8;
    Byte fourth = value & 0x000000FF;
    
    bytesResultLabel.text =
        [NSString stringWithFormat:@"%d %d %d %d", first, second, third, fourth];
}

@end
