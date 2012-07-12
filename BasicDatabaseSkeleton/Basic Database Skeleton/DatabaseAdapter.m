//
//  DatabaseAdapter.m
//  Basic Database Skeleton
//
//  Created by bhuvan khanna on 12/07/12.
//  Copyright (c) 2012 webonise software solutions pvt ltd. All rights reserved.
//

#import "DatabaseAdapter.h"

@implementation DatabaseAdapter

- (id)init
{
    self = [super init];
    if (self) {
        [self setDatabase];  
    }
    
    return self;
}

-(void)setDatabase {
    [self setDbName:@"Sample"];
    [self setDbColumns];
    
}

-(void)setDbName:(NSString *)databaseName{
    dbName = databaseName;
}

-(void)setDbColumns{
    dbColumns =  [[NSArray alloc] initWithObjects :@"name",@"remote_id",nil];
}

- (NSFetchedResultsController *)getBusinessList {
    return [super fetchedResultsController];        
} 

-(void)createRecord:(Result*)record {

    NSArray *objects = [NSArray arrayWithObjects:record.name,[NSNumber numberWithInt:record.remote_id],nil]; 
    NSArray *keys = [[NSArray alloc]initWithObjects:[dbColumns objectAtIndex:0],[dbColumns objectAtIndex:1], nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [super insertIntoTable:dictionary];
    keys = nil;
}

-(Result *)getRecord:(int)remote_id {
    Result *business;
    NSArray *businesses=[super fetch:remote_id];
    
    for(int i=0;i<[businesses count];i++) {
        business = [businesses objectAtIndex:i];
        
        return business;
    }      
    
    return nil;
}


-(void)deleteAll {
    [super deleteAll];
}

-(void)deleteRecord:(int)remote_id{
    NSArray *records=[super fetch:remote_id];
    
    for(int i=0;i<[records count];i++) {
        NSManagedObject *item = [records objectAtIndex:i];
        if ( [[item valueForKey:@"remote_id"] intValue] == remote_id) {
            [super deleteFromTable:(NSManagedObject *)item];
            break;
        }
    }
    
}


@end
