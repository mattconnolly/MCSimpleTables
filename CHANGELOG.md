## Version 0.3.0

Fixes:

* Fixes a possible exception in `MCSimpleTableCoreDataSection` when using the no object cell and adding multiple core data objects into a fetched results controller at a time.

Notes:

* MCSimpleTableCoreDataSection: If you are using the No Object cell, ensure that you use [table reloadData] before adding multiple core data objects in a single context save so that the visibility of the No Object cell can be correctly managed.

## Version 0.2.0

Additions:

* Added core data fetched results section: `MCSimpleTableCoreDataSection`

## Version 0.1.0

Initial release
