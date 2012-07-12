//
//  DatabaseAdapter.h
//  Basic Database Skeleton
//
//  Created by bhuvan khanna on 12/07/12.
//  Copyright (c) 2012 webonise software solutions pvt ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseHelper.h"
#import "Result.h"

@interface DatabaseAdapter : DatabaseHelper {
    
}

-(void)setDbName:(NSString*)databaseName;
-(void)setDbColumns;
-(void)createRecord:(Result*)record;
-(void)deleteRecord:(int)remote_id;
-(void)deleteAll;
-(Result *)getRecord:(int)remote_id;

@end
