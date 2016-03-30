//
//  ContactDetailViewController.h
//  ContactBook
//
//  Created by Prashanna Raghavan on 3/30/16.
//  Copyright © 2016 Pefin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>
#import "ContactImageView.h"

@interface ContactDetailViewController : UIViewController<UITextViewDelegate>
@property(nonatomic,strong) CNContact *contact;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextView *emailLabel;
@property (weak, nonatomic) IBOutlet UITextView *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet ContactImageView *contactImage;
@property (weak, nonatomic) IBOutlet UITextView *messageTexxt;
@property (weak, nonatomic) IBOutlet UITextView *emailText;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;

@end
