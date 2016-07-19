//
//  KVManager.h
//  KeyValueStore
//
//  Created by Gupta, Ajay E. on 14/07/16.
//  Copyright © 2016 Gupta,Ajay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVManager : NSObject
-(instancetype)initWithKeyValueStoreFilename:(NSString *)kvStoreFilename;

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *keyValueStoreFilename;

-(void)copyKeyValueStoreIntoDocumentsDirectory;

@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

-(NSArray *)loadDataFromKVStore:(NSString *)query;
-(void)executeQuery:(NSString *)query;

@end