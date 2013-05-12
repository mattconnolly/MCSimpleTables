//
//  MCSimpleTableCoreDataSection.h
//  MCSimpleTables
//
//  Created by Matt Connolly on 12/05/13.
//  Copyright (c) 2013 Matthew Connolly. All rights reserved.
//
// This is a MC Simple Table Section that uses a NSFetchResultsController
// to control the cells in the section. This is designed for the very simple
// use case where a number of objects are fetched from core data and shown
// in a single section: ie: no grouping.
//

#import "MCSimpleTableSection.h"
#import "MCSimpleTableCoreDataCell.h"
#import <CoreData/CoreData.h>

@class MCSimpleTableCoreDataSection;

typedef void(^MCSimpleTableCoreDataCellConfigureBlock)(MCSimpleTableCoreDataSection* section, UITableViewCell* tableCell, NSManagedObject* object);
typedef void(^MCSimpleTableCoreDataCellSelectedBlock)(MCSimpleTableCoreDataCell* cell, NSManagedObject* object);


@interface MCSimpleTableCoreDataSection : MCSimpleTableSection <NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController * _controller;
    
    // blocks for configuration and responding to actions
    MCSimpleTableCoreDataCellConfigureBlock _configureBlock;
    MCSimpleTableCoreDataCellSelectedBlock _selectedBlock;
}

@property (nonatomic,readonly) NSFetchRequest* fetchRequest;

// a special simple table class instance that is re-used for each NSManagedObject
// shown in the section. Only one instance of this object exists for the whole
// table. Customise its class, identifier and style, but it will be more convenient
// to use the configure and select blocks in this section class which will also
// pass the managed object itself.
@property (nonatomic,readonly) MCSimpleTableCoreDataCell* prototypeCell;

// block for configuring the cell
@property (nonatomic, copy) MCSimpleTableCoreDataCellConfigureBlock configureBlock;

// block for responding to selections
@property (nonatomic, copy) MCSimpleTableCoreDataCellSelectedBlock selectedBlock;

@property (nonatomic, assign) BOOL showsNoObjectsCell; // does the section show a "no objects"
// cell when the section is empty?


- (id)initWithFetchRequest:(NSFetchRequest*)fetchRequest
      managedObjectContext:(NSManagedObjectContext *)context
                 cacheName:(NSString *)name;


@end
