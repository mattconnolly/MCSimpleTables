//
//  MCSimpleTableCoreDataSectionCellProxy.h
//  MCSimpleTables
//
//  Created by Matt Connolly on 13/05/13.
//  Copyright (c) 2013 Matthew Connolly. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCSimpleTableCoreDataCell;
@class NSManagedObject;

@interface MCSimpleTableCoreDataSectionCellProxy : NSObject

@property (nonatomic,weak) MCSimpleTableCoreDataCell* cell;
@property (nonatomic,weak) NSManagedObject* object;
@property (nonatomic,retain) NSIndexPath* indexPath;
- (id)initWithPrototypeCell:(MCSimpleTableCoreDataCell*)cell andManagedObject:(NSManagedObject*)object;

@end
