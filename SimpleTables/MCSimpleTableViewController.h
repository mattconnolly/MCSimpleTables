//
//  SimpleTableViewController.h
//  SimpleTables
//
//  Created by Matt Connolly on 3/04/12.
//  Copyright (c) 2012 Sound Evolution Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCSimpleTableSection;

@interface MCSimpleTableViewController : UITableViewController
{
    NSMutableArray* _sections;
    BOOL _usesCustomHeaderViews;
    BOOL _usesCustomFooterViews;
}

// array of SimpleTableSection objects
@property (nonatomic, readonly) NSMutableArray* sections;

// convenience to add a section to the array of sections
- (void) addSection:(MCSimpleTableSection*)section;

// YES if we provide customer header / footer views in sections
@property (nonatomic, assign) BOOL usesCustomHeaderViews;
@property (nonatomic, assign) BOOL usesCustomFooterViews;

@end
