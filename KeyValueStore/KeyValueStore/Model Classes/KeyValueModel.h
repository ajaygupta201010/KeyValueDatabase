//
//  KeyValueModel.h
//  KeyValueStore
//
//  Created by Gupta, Ajay E. on 18/07/16.
//  Copyright © 2016 Gupta,Ajay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyValueModel : NSObject

@property NSString *key;
@property (strong,nonatomic) NSString* value;
- (id)initWithKey:(NSString*)key andValue:(NSString*)value;

@end
