//
//  EditInfoVC.h
//  KeyValueStore
//
//  Created by Gupta, Ajay E. on 14/07/16.
//  Copyright © 2016 Gupta,Ajay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyValueModel.h"

@protocol EditInfoViewControllerDelegate

-(void)editingInfoWasFinished;

@end

@interface EditInfoVC : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *age;

@property (nonatomic, strong) id<EditInfoViewControllerDelegate> delegate;
@property (nonatomic) KeyValueModel *model;
@property NSString *recordIDToEdit;

- (IBAction)saveInfo:(id)sender;

@end
