//
//  DatabaseViewController.m
//  Basic Database Skeleton
//
//  Created by bhuvan khanna on 12/07/12.
//  Copyright (c) 2012 webonise software solutions pvt ltd. All rights reserved.
//

#import "DatabaseViewController.h"
#import "Result.h"
#import "DatabaseAdapter.h"

@interface DatabaseViewController ()

@end

@implementation DatabaseViewController

@synthesize txtDeleteId,txtAddRecordId,txtFetchRecord,txtAddRecordName,btnAddRecord,btnDeleteAll,btnFetchRecord,btnDeleteRecord,lblFetchId,lblFetchName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    txtAddRecordId.delegate=self;
    txtAddRecordName.delegate=self;
    txtDeleteId.delegate=self;
    txtFetchRecord.delegate=self;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(IBAction)addRecord:(id)sender {
    Result *res = [[Result alloc]init];
    res.remote_id=[txtAddRecordId.text intValue];
    res.name=txtAddRecordName.text;
    
    DatabaseAdapter *adpt = [[DatabaseAdapter alloc]init];
    [adpt createRecord:res];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Record Added" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    txtAddRecordId.text=@"";
    txtAddRecordName.text=@"";
}

-(IBAction)fetchRecord:(id)sender {
    Result *res = [[Result alloc]init];  
    res.remote_id=[txtFetchRecord.text intValue];
    
    DatabaseAdapter *adpt = [[DatabaseAdapter alloc]init];
    res=[adpt getRecord:res.remote_id];
    NSString *name = res.name;
    int remote_id = res.remote_id;
    NSString *idInString = [NSString stringWithFormat:@"%d",remote_id];
    lblFetchId.text =idInString;
    lblFetchName.text=name;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Record Fetched" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    txtFetchRecord.text=@"";
}

-(IBAction)deleteRecord:(id)sender {
    Result *res = [[Result alloc]init];  
    res.remote_id=[txtDeleteId.text intValue];
    
    DatabaseAdapter *adpt = [[DatabaseAdapter alloc]init];
    [adpt deleteRecord:res.remote_id];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Record Deleted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    txtDeleteId.text=@"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
    [txtAddRecordId resignFirstResponder];
    [txtAddRecordName resignFirstResponder];
    [txtDeleteId resignFirstResponder];
    [txtFetchRecord resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:txtAddRecordId up:YES];
    [self animateTextField:txtAddRecordName up:YES];
    [self animateTextField:txtDeleteId up:YES];
    [self animateTextField:txtFetchRecord up:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:txtAddRecordId up:NO];
    [self animateTextField:txtAddRecordName up:NO];
    [self animateTextField:txtDeleteId up:NO];
    [self animateTextField:txtFetchRecord up:NO];
}


- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int movementDistance = 30; 
    const float movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame,0, movement);
    [UIView commitAnimations];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
