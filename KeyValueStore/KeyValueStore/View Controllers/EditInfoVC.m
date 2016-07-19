//
//  EditInfoVC.m
//  KeyValueStore
//
//  Created by Gupta, Ajay E. on 14/07/16.
//  Copyright © 2016 Gupta,Ajay. All rights reserved.
//

#import "EditInfoVC.h"
#import "KVManager.h"

@interface EditInfoVC()
@property (nonatomic,strong) KVManager *kvManager;
-(void)loadInfoToEdit;

@end

@implementation EditInfoVC
-(void)viewDidLoad{
    [super viewDidLoad];
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.age.delegate = self;
    
    self.kvManager = [[KVManager alloc]initWithKeyValueStoreFilename:@"KeyValueStoreDataBase.sqlite"];
    if (self.recordIDToEdit.length) {
        // Load the record with the specific ID from the database.
        [self loadInfoToEdit];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)saveInfo:(id)sender {
    // Prepare the query string.
    // If the recordIDToEdit property has value other than nil, then create an update query. Otherwise create an insert query.
    
    NSString *query;
    NSString* dictString = [NSString stringWithFormat:@"{\"firstName\":\"%@\",\"lastName\":\"%@\",\"age\":\"%d\"}",self.firstName.text, self.lastName.text, [self.age.text intValue]];
    
    NSString *identifier = [[NSProcessInfo processInfo] globallyUniqueString];
    
    if (self.recordIDToEdit.length == 0) {
    query = [NSString stringWithFormat:@"insert into PeopleInfo values(\"%@\", '%@')",identifier,dictString];
    }
    else{
        query = [NSString stringWithFormat:@"update PeopleInfo set value='%@' where key=\"%@\"", dictString, self.model.key];
    }
    
    // Execute the query.
    [self.kvManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.kvManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.kvManager.affectedRows);
        
        // Inform the delegate that the editing was finished.
        [self.delegate editingInfoWasFinished];
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"Could not execute the query.");
    }}

-(void)loadInfoToEdit{
   
    // Set the loaded data to the textfields.
    NSError *error;
    NSData *data = [self.model.value dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];

    self.firstName.text = [jsonResponse valueForKey:@"firstName"];
    self.lastName.text = [jsonResponse valueForKey:@"lastName"];
    self.age.text = [jsonResponse valueForKey:@"age"];
    }
@end

