//
//  ViewController.h
//  KeyValueStore
//
//  Created by Gupta, Ajay E. on 14/07/16.
//  Copyright © 2016 Gupta,Ajay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "EditInfoVC.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,EditInfoViewControllerDelegate>{
    NSMutableArray * fetchedObjects;
}

@property (weak, nonatomic) IBOutlet UITableView *peopleTbl;
- (IBAction)addNewRecord:(id)sender;

@end

