//
//  DatabaseViewController.h
//  Basic Database Skeleton
//
//  Created by bhuvan khanna on 12/07/12.
//  Copyright (c) 2012 webonise software solutions pvt ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatabaseViewController : UIViewController <UIScrollViewDelegate,UITextFieldDelegate> {
    IBOutlet UITextField *txtAddRecordName;
    IBOutlet UITextField *txtAddRecordId;
    IBOutlet UIButton *btnAddRecord;
    
    IBOutlet UIButton *btnFetchRecord;
    IBOutlet UITextField *txtFetchRecord;
    IBOutlet UILabel *lblFetchName;
    IBOutlet UILabel *lblFetchId;
    
    IBOutlet UIButton *btnDeleteRecord;
    IBOutlet UIButton *btnDeleteAll;
    IBOutlet UITextField *txtDeleteId;
}

@property(nonatomic,retain) IBOutlet UITextField *txtAddRecordName;
@property(nonatomic,retain) IBOutlet UITextField *txtAddRecordId;
@property(nonatomic,retain) IBOutlet UIButton *btnAddRecord;
@property(nonatomic,retain) IBOutlet UIButton *btnFetchRecord;
@property(nonatomic,retain) IBOutlet UITextField *txtFetchRecord;
@property(nonatomic,retain) IBOutlet UILabel *lblFetchName;
@property(nonatomic,retain) IBOutlet UILabel *lblFetchId;

@property(nonatomic,retain) IBOutlet UIButton *btnDeleteRecord;
@property(nonatomic,retain) IBOutlet UIButton *btnDeleteAll;
@property(nonatomic,retain) IBOutlet UITextField *txtDeleteId;

-(IBAction)fetchRecord:(id)sender;
-(IBAction)addRecord:(id)sender;
-(IBAction)deleteRecord:(id)sender;

@end
