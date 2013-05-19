# SimpleTables

This library provides some classes to help with creating UITableViews that are programmatically defined, for example in a Settings page of an app.

Instead of having to deal with NSIndexPaths to determine what should happen in a cell, this library delegates that functionality to a set of classes:

* `SimpleTableViewController`: a UITableViewController subclass that looks up sections from SimpleTableSecitons.
* `SimpleTableSection`: A container with an array of SimpleTableCells.
* `SimpleTableCell`: A generic cell "controller" where the configuration of the cell can be delegated to a block or subclass.

Note that creating all of these objects does use more memory than a direct UITableViewController implementation. In a small table, however, the number of extra objects is small. The purpose of this library is to allow the user to set up a table declaratively for speed of setup and maintainability.

## Examples

Create a view controller that is a subclass of `MCSimpleTableViewController`, and in its `viewDidLoad` method, construct the sections and cells required. Example for a simple settings page:



## Requirements

This library is for iOS apps, and uses ARC. It is build for iOS >= 5.1.

## License

This is licensed under BSD license. See LICENSE.md for legal wording.
