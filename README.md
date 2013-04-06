# SimpleTables

This library provides some classes to help with creating UITableViews that are programmatically defined, for example in a Settings page of an app.

Instead of having to deal with NSIndexPaths to determine what should happen in a cell, this library delegates that functionality to a set of classes:

* `SimpleTableViewController`: a UITableViewController subclass that looks up sections from SimpleTableSecitons.
* `SimpleTableSection`: A container with an array of SimpleTableCells.
* `SimpleTableCell`: A generic cell "controller" where the configuration of the cell can be delegated to a block or subdlass.


## Examples

TODO: Write examples.

## Requirements

This library is for iOS apps, and uses ARC. It is build for iOS >= 5.0.

## License

This is licensed under BSD license. See LICENSE.md for legal wording.
