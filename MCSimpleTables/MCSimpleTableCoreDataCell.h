//
//  MCSimpleTableCoreDataCell.h
//  MCSimpleTables
//
//  Created by Matt Connolly on 12/05/13.
//  Copyright (c) 2013 Matthew Connolly. All rights reserved.
//

#import "MCSimpleTableCell.h"
#import <CoreData/CoreData.h>

@class MCSimpleTableCoreDataSection;

@interface MCSimpleTableCoreDataCell : MCSimpleTableCell
@property (nonatomic,retain) NSManagedObject* managedObject;
@property (nonatomic,weak) MCSimpleTableCoreDataSection* section;

- (id)initWithSection:(MCSimpleTableCoreDataSection*)section;

@end
