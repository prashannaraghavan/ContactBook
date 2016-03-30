//
//  ContactKit.m
//  ContactBook
//
//  Created by Prashanna Raghavan on 3/29/16.
//  Copyright © 2016 Pefin. All rights reserved.
//

#import "ContactKit.h"

@implementation ContactKit

/*!
 * @discussion A function to create singleton object
 */

+(id)sharedInstance
{
    static ContactKit *contactKit = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        contactKit = [[self alloc] init];
    });
    
    return contactKit;
}

-(instancetype)init
{
    if (self=[super init]) {
        
    }
    
    return self;
}

#pragma mark - Custom Contact fetching events
/*!
 * @discussion A function to check the latest Contact Framework and trigger access notification to the user
 * @return Fetched contacts are returned as NSMutableArray.
 */

-(NSMutableArray *)fetchContacts {
    
    __block NSMutableArray *contactsArray = [NSMutableArray array];
    
    BOOL isContactFrameworkAvailable = NSClassFromString(@"CNContactStore");
    
    if (isContactFrameworkAvailable) {
        contactStore = [[CNContactStore alloc] init];
        
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        
        switch (status) {
            case CNAuthorizationStatusAuthorized:
                contactsArray = [self fetchFromContactsFramework];
                break;
                
            case CNAuthorizationStatusNotDetermined: {
                
                [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError *error) { //permission
                    if (granted) {
                        contactsArray = [self fetchFromContactsFramework];
                    }
                }];
            }
                break;
                
            default:
                break;
        }
    }
    
    else{
        
    }
    
    return contactsArray;
}

/*!
 * @discussion A function to fetch contacts from Contacts framework
 * @return Fetched contacts are returned as NSMutableArray.
 */

-(NSMutableArray *)fetchFromContactsFramework
{
    NSMutableArray *fetchContactsArray = [NSMutableArray array];
    
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:
                                            @[CNContactIdentifierKey,
                                              [CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName],
                                              CNContactThumbnailImageDataKey,
                                              CNContactPhoneNumbersKey,
                                              CNContactEmailAddressesKey
                                             ]];
    
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        [fetchContactsArray addObject:contact];
    }];
    
    return fetchContactsArray;
}

@end
