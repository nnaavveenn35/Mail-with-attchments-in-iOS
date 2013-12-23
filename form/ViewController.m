//
//  ViewController.m
//  form
//
//  Created by NAVEEN  on 12/11/13.
//  Copyright (c) 2013 NAVEEN . All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()
{
    NSArray *paths;
    NSString *filename,*newPath;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
//    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
//    [_webview loadHTMLString:htmlString baseURL:nil];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)takescreenshotes{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);

    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData * data = UIImagePNGRepresentation(image);
    filename=@"latest.png"; //create a custome file name for your screen shots
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    newPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:filename];
    
    [data writeToFile:newPath atomically:YES]; //Path to store the screen shots
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:data], nil, nil, nil);
}
- (IBAction)openMail:(id)sender
{
    [self takescreenshotes];
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Email Subject"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"fisrtMail@example.com", nil];
        [mailer setToRecipients:toRecipients];
        
        UIImage *myImage = [UIImage imageWithContentsOfFile:newPath];
        NSData *imageData = UIImagePNGRepresentation(myImage);
        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        
        NSString *emailBody = @"Please check the attached image: Naveen";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        // only for iPad
        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentModalViewController:mailer animated:YES];
        
        //[mailer release];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
       // [alert release];
    }
    
}



#pragma mark - MFMailComposeController delegate


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}





@end
