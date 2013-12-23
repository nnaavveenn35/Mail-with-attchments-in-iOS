//
//  ViewController.h
//  form
//
//  Created by NAVEEN  on 12/11/13.
//  Copyright (c) 2013 NAVEEN . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webview;

- (IBAction)openMail:(id)sender;
@end
