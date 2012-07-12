//
//  DatabaseHelper.m
//  Basic Database Skeleton
//
//  Created by bhuvan khanna on 12/07/12.
//  Copyright (c) 2012 webonise software solutions pvt ltd. All rights reserved.
//

#import "DatabaseHelper.h"
#import "DatabaseAppDelegate.h"

@implementation DatabaseHelper

@synthesize context,fetchedResultsController,dbName,dbColumns,persistentStoreCoordinator;

- (id)init
{
    self = [super init];
    if (self) {
            // [self initializePointers];
        DatabaseAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        self.context = [appDelegate managedObjectContext];
        inTransaction = NO;
    }
    
    return self;
}


-(void)insertIntoTable:(NSDictionary*)dictionary{
    NSManagedObject *data;
    data = [NSEntityDescription insertNewObjectForEntityForName:dbName inManagedObjectContext:[self context]];
    for(id key in dictionary) {
        [data setValue:[dictionary objectForKey:key] forKey:key];  
    }
    
    [self save];
}

-(void)updateFromTable:(NSManagedObject*)mObject:(NSString *)key:(NSString *)value{
    
    [mObject setValue:value forKey:key];
    [self save];
}


-(void)deleteFromTable:(NSManagedObject*)mObject{
    [context deleteObject:mObject];
    [self save];
}


-(NSArray *)fetch:(int)remoteId {
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:dbName inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"remote_id = %d", remoteId];
        //NSLog(@"DatabaseHelper::fetch with predicate %@ and id %d", predicate, remoteId);    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *records = [context executeFetchRequest:request error:&error];
        //NSLog(@"Records fetch function - %@",records);
        //  NSLog(@"Remote Id - %@",remoteId);
        //if (![context save:&error]) {
        //NSLog(@"Error deleting %@ - error:%@",dbName,error);
        //}
    
    return records;
    
}

-(NSArray *)fetchAll {
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:dbName inManagedObjectContext:context];
    [request setEntity:entity];
    
    [request setPredicate:nil];
    
    NSError *error = nil;
    NSArray *records = [context executeFetchRequest:request error:&error];
    
        //NSLog(@"Records - %@",records);
        //  NSLog(@"Remote Id - %@",remoteId);
        //if (![context save:&error]) {
        //NSLog(@"Error deleting %@ - error:%@",dbName,error);
        //}
    
    return records;
    
}

-(void)deleteAll {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:dbName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items) {
        [context deleteObject:managedObject];
            //NSLog(@"%@ object deleted",dbName);
    }
    [self save];
}

- (NSFetchedResultsController *)fetchedResultsController{
    if (mfetchedResultsController) return mfetchedResultsController;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:dbName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[dbColumns objectAtIndex:0] ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];  
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
        // aFetchedResultsController.delegate = self;
    [self setFetchedResultsController:aFetchedResultsController];
    mfetchedResultsController=aFetchedResultsController;
    
    return mfetchedResultsController;        
} 

-(NSArray*)fetchWithPredicate:(NSPredicate*)predicate {
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:dbName inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSError *error = nil;
    [request setPredicate:predicate];
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    
    if ( fetchedObjects == nil ) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    NSLog(@"Predicate: %@ ", predicate);
    NSLog(@"Matching fetched count %d", [fetchedObjects count]);
    
    return fetchedObjects; 
}

-(void)startTransaction {
        //Set a flag not to save operations in the MOC
    inTransaction = YES;
}

-(void)endTransaction {
    NSError *error = nil;
    
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Saving changes failed: %@", error);        
    }    
}

-(BOOL)save {
    if ( !inTransaction ) {
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error saving transaction %@ - error:%@",dbName,error);
            return NO;
        } else {
            return YES;
        }
    } else {
        return YES; 
    }
}


@end
