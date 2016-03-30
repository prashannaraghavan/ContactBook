//
//  ContactKit.h
//  ContactBook
//
//  Created by Prashanna Raghavan on 3/29/16.
//  Copyright © 2016 Pefin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>

@interface ContactKit : NSObject
{
    CNContactStore *contactStore;
    ABAddressBookRef *addressBookRef;
}

+(id)sharedInstance;
-(instancetype)init;
-(NSMutableArray *)fetchContacts;
-(NSMutableArray *)fetchFromContactsFramework;

@end
