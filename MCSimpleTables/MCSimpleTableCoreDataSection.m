//
//  MCSimpleTableCoreDataSection.m
//  MCSimpleTables
//
//  Created by Matt Connolly on 12/05/13.
//  Copyright (c) 2013 Matthew Connolly. All rights reserved.
//

#import "MCSimpleTableCoreDataSection.h"
#import "MCSimpleTableCoreDataCell.h"
#import "MCSimpleTableViewController.h"
#import "MCSimpleTableCoreDataSectionCellProxy.h"
#import <CoreData/CoreData.h>

@implementation MCSimpleTableCoreDataSection

@synthesize fetchedResultsController = _controller;

- (id)initWithFetchRequest:(NSFetchRequest*)fetchRequest
      managedObjectContext:(NSManagedObjectContext *)context
                 cacheName:(NSString *)name;
{
    self = [super init];
    if (self) {
        _controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:context
                                                            sectionNameKeyPath:nil
                                                                     cacheName:name];
        _controller.delegate = self;
        
        _prototypeCell = [[MCSimpleTableCoreDataCell alloc] initWithSection:self];
        NSError* error = nil;
        [_controller performFetch:&error];
        if (error) {
            NSLog(@"Failed to perform fetch: %@", error.localizedDescription);
            return nil;
        }
    }
    return self;
}

- (NSFetchRequest*)fetchRequest
{
    return _controller.fetchRequest;
}

- (NSUInteger)cellCount
{
    NSUInteger min = (self.noObjectCell != nil) ? 1 : 0;
    
    id<NSFetchedResultsSectionInfo> info = [_controller.sections objectAtIndex:0];
    NSUInteger numberOfObjects = [info numberOfObjects];
    return MAX(min, numberOfObjects);
}

- (MCSimpleTableCell*) cellAtIndex:(NSUInteger)index
{
    NSManagedObject* object = nil;
    MCSimpleTableCell* cell = nil;
    
    id<NSFetchedResultsSectionInfo> info = [_controller.sections objectAtIndex:0];
    NSUInteger numberOfObjects = [info numberOfObjects];
    
    if (numberOfObjects > 0 && index < info.objects.count) {
        object = info.objects[index];
        MCSimpleTableCoreDataSectionCellProxy* proxy;
        proxy = [[MCSimpleTableCoreDataSectionCellProxy alloc] initWithPrototypeCell:self.prototypeCell
                                                                    andManagedObject:object];
        cell = (MCSimpleTableCell*)proxy;
    } else {
        cell = self.noObjectCell;
    }
    
    return cell;
}

- (void) addCell:(MCSimpleTableCell*)cell;
{
    @throw [[NSException alloc] initWithName:@"Cannot add cells to MCSimpleTableCoreDataSection"
                                      reason:@"This section has cells provided by core data, not explicitly from code."
                                    userInfo:nil];
}



#pragma mark NSFetchedResultsControllerDelegate protocol methods


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    // this class is for single section use. No action required here.
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    if (indexPath) {
        indexPath = [NSIndexPath indexPathForRow:indexPath.row
                                       inSection:_sectionIndex];
    }
    if (newIndexPath) {
        newIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row
                                          inSection:_sectionIndex];
    }
    
    id<NSFetchedResultsSectionInfo> info = [_controller.sections objectAtIndex:0];
    NSInteger numObjects = info.numberOfObjects;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            if (self.noObjectCell != nil && numObjects == 1 && newIndexPath.row == 0) {
                // swap no objects cell for first cell;
                [tableView reloadRowsAtIndexPaths:@[newIndexPath]
                                 withRowAnimation:self.rowAnimation];
            } else {
                [tableView insertRowsAtIndexPaths:@[newIndexPath]
                                 withRowAnimation:self.rowAnimation];
            }
            break;
            
        case NSFetchedResultsChangeDelete:
            if (self.noObjectCell != nil && numObjects == 0 && indexPath.row == 0) {
                // swap out last cell for no objects cell
                [tableView reloadRowsAtIndexPaths:@[indexPath]
                                 withRowAnimation:self.rowAnimation];
            } else {
                [tableView deleteRowsAtIndexPaths:@[indexPath]
                                 withRowAnimation:self.rowAnimation];
            }
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:self.rowAnimation];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:self.rowAnimation];
            [tableView insertRowsAtIndexPaths:@[newIndexPath]
                             withRowAnimation:self.rowAnimation];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end

