//
//  MainMenuViewController.h
//  Agenda
//
//  Created by Carlos on 28/11/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgendaController.h"

@interface MainMenuViewController : UIViewController<AgendaController>

- (IBAction) newUser;
- (IBAction) list;

@end
