//
//  ContactDetailViewController.m
//  ContactBook
//
//  Created by Prashanna Raghavan on 3/30/16.
//  Copyright © 2016 Pefin. All rights reserved.
//

#import "ContactDetailViewController.h"
#import <MessageUI/MessageUI.h>

@interface ContactDetailViewController ()<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
@property(nonatomic,strong) NSString *primaryEmail;
@property(nonatomic,strong) NSString *primaryNumber;
@property(nonatomic,strong) NSString *contactName;
@end

@implementation ContactDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self displayContact];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)displayContact
{
    self.contactName = [NSString stringWithFormat:@"%@ %@",self.contact.givenName,self.contact.familyName];
    self.nameLabel.text = self.contactName;
    
    for (CNLabeledValue *email in self.contact.emailAddresses) {
        self.primaryEmail = email.value;
        break;
    }
    self.emailLabel.text = self.primaryEmail;
    
    
    for (CNLabeledValue *phoneNumber in self.contact.phoneNumbers) {
        CNPhoneNumber *number = phoneNumber.value;
        self.primaryNumber=[number stringValue];
        break;
    }
    self.phoneNumberLabel.text = self.primaryNumber;
    UIImage *defaultImage = [UIImage imageNamed:@"profile"];
    self.contactImage.image = defaultImage;
    
}

-(void)displayAlertWithTitle:(NSString *)title andMessage:(NSString *)message
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            NSString *message = [NSString stringWithFormat:@"Failed to send SMS to %@. Please try again later.",self.contactName];
            
            [self displayAlertWithTitle:@"Error" andMessage:message];
            
            break;
        }
            
        case MessageComposeResultSent:
        {
            NSString *message = [NSString stringWithFormat:@"Message successfully sent to %@",self.contactName];
            
            [self displayAlertWithTitle:@"Message sent" andMessage:message];
        }
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)sendSMS {
    
    if(![MFMessageComposeViewController canSendText]) {
        
        NSString *message = @"Your device doesn't support SMS!";
        [self displayAlertWithTitle:@"Error" andMessage:message];
        
        return;
    }
    
    NSArray *recipents = @[self.primaryNumber];
    NSString *message = self.messageTexxt.text;
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    [self presentViewController:messageController animated:YES completion:nil];
}

- (IBAction)messageBtnClicked:(id)sender {
    if (![self.messageTexxt.text isEqualToString:@""] && self.messageTexxt.text!=nil) {
        [self sendSMS];
    }
    else{
        
        NSString *message = @"Please type a message to send";
        [self displayAlertWithTitle:@"Error" andMessage:message];
    }
}

- (IBAction)emailBtnClicked:(id)sender {
    
}


@end
