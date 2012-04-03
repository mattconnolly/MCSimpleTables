//
//  SimpleTableViewController.h
//  SimpleTables
//
//  Created by Matt Connolly on 3/04/12.
//  Copyright (c) 2012 Sound Evolution Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimpleTableSection;

@interface SimpleTableViewController : UITableViewController
{
    NSMutableArray* _sections;
}

// array of SimpleTableSection objects
@property (nonatomic, readonly) NSMutableArray* sections;

// convenience to add a section to the array of sections
- (void) addSection:(SimpleTableSection*)section;

@end
