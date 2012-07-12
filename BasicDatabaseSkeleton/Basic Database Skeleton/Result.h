//
//  Result.h
//  Basic Database Skeleton
//
//  Created by bhuvan khanna on 12/07/12.
//  Copyright (c) 2012 webonise software solutions pvt ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject {
    NSString *name;
    int remote_id;
}

@property(nonatomic,retain) NSString *name;
@property(nonatomic) int remote_id;

@end
