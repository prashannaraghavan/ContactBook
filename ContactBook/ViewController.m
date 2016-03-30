//
//  ViewController.m
//  ContactBook
//
//  Created by Prashanna Raghavan on 3/29/16.
//  Copyright © 2016 Pefin. All rights reserved.
//

#import "ViewController.h"
#import "ContactKit.h"
#import "ContactDetailViewController.h"

@interface ViewController ()
{
    UITableViewCell *contactCell;
}
@property(nonatomic,strong) NSArray *contactsArray;
@property (weak, nonatomic) IBOutlet UITableView *contactsTableview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ContactKit *contactKit = [ContactKit sharedInstance];
    self.contactsArray = [contactKit fetchContacts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contactsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CNContact *contact = self.contactsArray[indexPath.row];
    contactCell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    contactCell.textLabel.text = [NSString stringWithFormat:@"%@ %@",contact.givenName,contact.familyName];
    
    NSString *primaryNumber ;
        for (CNLabeledValue *phoneNumber in contact.phoneNumbers) {
            CNPhoneNumber *number = phoneNumber.value;
            primaryNumber=[number stringValue];
            break;
        }
    
    contactCell.detailTextLabel.text=[NSString stringWithFormat:@"%@",primaryNumber];
    
    return contactCell;
}

#pragma mark - UIStoryboardSegue methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ContactDetailSegue"])
    {
        NSIndexPath *selectedRow = [self.contactsTableview indexPathForSelectedRow];
        ContactDetailViewController *contactDetailViewController = [segue destinationViewController];
        contactDetailViewController.contact = self.contactsArray[selectedRow.row];
    }
}

@end
