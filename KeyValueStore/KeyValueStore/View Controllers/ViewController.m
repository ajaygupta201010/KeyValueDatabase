//
//  ViewController.m
//  KeyValueStore
//
//  Created by Gupta, Ajay E. on 14/07/16.
//  Copyright © 2016 Gupta,Ajay. All rights reserved.
//

#import "ViewController.h"
#import "KVManager.h"
#import "KeyValueModel.h"

@interface ViewController ()

@property (nonatomic, strong) KVManager *kvManager;
@property (nonatomic) NSString *recordIDToEdit;
@property(nonatomic) KeyValueModel *kvModel;

-(void)loadData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.peopleTbl.delegate = self;
    self.peopleTbl.dataSource = self;
    self.peopleTbl.tableFooterView = [[UIView alloc]init];
    
    self.kvManager = [[KVManager alloc] initWithKeyValueStoreFilename:@"KeyValueStoreDataBase.sqlite"];
    
    [self loadData];
}

-(void)loadData{
    // Form the query.
    NSString *query = @"select key,value from peopleInfo";
    
    // Get the results.
    if (fetchedObjects != nil) {
        fetchedObjects = nil;
    }
    //self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.kvManager loadDataFromKVStore:query]];
    
    fetchedObjects = [[NSMutableArray alloc]init];
    
    for (NSArray* arr in [self.kvManager loadDataFromKVStore:query]) {
        [fetchedObjects addObject:[[KeyValueModel alloc]initWithKey:arr[0] andValue:arr[1]]];
    }
    // Reload the table view.
    [self.peopleTbl reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNewRecord:(id)sender {
    // Before performing the segue, set the -1 value to the recordIDToEdit. That way we'll indicate that we want to add a new record and not to edit an existing one.
    self.recordIDToEdit = @"";
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

// Table view data source methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return fetchedObjects.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Dequeue the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    self.kvModel = [fetchedObjects objectAtIndex:indexPath.row];
    NSError* error;
    NSString *str = [NSString stringWithFormat:@"%@",self.kvModel.value];    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
   
    if (jsonResponse) {
    // Set the loaded data to the appropriate cell labels.
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [jsonResponse valueForKey:@"firstName"] ,[jsonResponse valueForKey:@"lastName"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Age: %@",[jsonResponse valueForKey:@"age"]];
    }
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    EditInfoVC *editInfoViewController = [segue destinationViewController];
    editInfoViewController.delegate = self;
    editInfoViewController.model = self.kvModel;
    editInfoViewController.recordIDToEdit = self.recordIDToEdit;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    // Get the record ID of the selected name and set it to the recordIDToEdit property.
     self.kvModel = [fetchedObjects objectAtIndex:indexPath.row];
    self.recordIDToEdit = self.kvModel.key;
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the selected record.
        // Find the record ID.
        self.kvModel = [fetchedObjects objectAtIndex:indexPath.row];
        NSString *recordIDToDelete = self.kvModel.key;
        
        // Prepare the query.
        NSString *query = [NSString stringWithFormat:@"delete from PeopleInfo where key=%@", recordIDToDelete];
        
        // Execute the query.
        [self.kvManager executeQuery:query];
        
        // Reload the table view.
        [self loadData];
    }
}

-(void)editingInfoWasFinished{
    // Reload the data.
    [self loadData];
}
@end

