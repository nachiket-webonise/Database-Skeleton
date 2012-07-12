//
//  DatabaseHelper.h
//  Basic Database Skeleton
//
//  Created by bhuvan khanna on 12/07/12.
//  Copyright (c) 2012 webonise software solutions pvt ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DatabaseHelper : NSObject {
    
    NSManagedObjectContext *context;
    NSFetchedResultsController *mfetchedResultsController;
    NSString *dbName;
    NSArray *dbColumns;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    BOOL inTransaction;
}

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSArray *dbColumns;
@property (nonatomic, retain)  NSString *dbName;
@property (nonatomic, retain)  NSPersistentStoreCoordinator *persistentStoreCoordinator;


-(void)insertIntoTable:(NSDictionary*)dictionary;
- (NSFetchedResultsController *)fetchedResultsController;
-(void)deleteFromTable:(NSManagedObject*)mObject;
-(NSArray *)fetch:(int)remoteId;
-(NSArray *)fetchAll;
-(void)deleteAll;
-(NSArray*)fetchWithPredicate:(NSPredicate*)predicate;
-(void)updateFromTable:(NSManagedObject*)mObject:(NSString *)key:(NSString *)value;
-(BOOL)save;
-(void)startTransaction;
-(void)endTransaction;

@end

