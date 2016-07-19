
//
//  KeyValueModel.m
//  KeyValueStore
//
//  Created by Gupta, Ajay E. on 18/07/16.
//  Copyright © 2016 Gupta,Ajay. All rights reserved.
//

#import "KeyValueModel.h"

@implementation KeyValueModel

- (id)initWithKey:(NSString*)key andValue:(NSString*)value
{
    if (self = [super init]) {
        self.key = key;
        self.value = value;
    }
    return  self;
}
@end
