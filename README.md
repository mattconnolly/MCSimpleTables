# SimpleTables

This library provides some classes to help with creating UITableViews that are programmatically defined, for example in a Settings page of an app.

Instead of having to deal with NSIndexPaths to determine what should happen in a cell, this library delegates that functionality to a set of classes:

* `SimpleTableViewController`: a UITableViewController subclass that looks up sections from SimpleTableSecitons.
* `SimpleTableSection`: A container with an array of SimpleTableCells.
* `SimpleTableCell`: A generic cell "controller" where the configuration of the cell can be delegated to a block or subclass.

Note that creating all of these objects does use more memory than a direct UITableViewController implementation. In a small table, however, the number of extra objects is small. The purpose of this library is to allow the user to set up a table declaratively for speed of setup and maintainability.

## Examples

Create a view controller that is a subclass of `MCSimpleTableViewController`, and in its `viewDidLoad` method, construct the sections and cells required. Example for a simple settings page:

	- (void)viewDidLoad
	{
	    [super viewDidLoad];
		// Do any additional setup after loading the view.
    
	    // create a section for our cells:
	    MCSimpleTableSection* section = [[MCSimpleTableSection alloc] init];
	    section.title = @"Configuration";
    
	    // create a cell with a switch in it
	    MCSimpleTableCell* cell = [[MCSimpleTableCell alloc] init];
	    cell.cellIdentifier = @"switch";
	    cell.configureBlock = ^(MCSimpleTableCell* cell, UITableViewCell* tableCell)
	    {
	        tableCell.textLabel.text = @"On/off setting";
	        UISwitch* control = [[UISwitch alloc] initWithFrame:CGRectZero];
	        control.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"switch"];
	        [control addTarget:self
	                    action:@selector(switchChanged:)
	          forControlEvents:UIControlEventValueChanged];
	        tableCell.accessoryView = control;
	        tableCell.selectionStyle = UITableViewCellSelectionStyleNone;
	    };
	    [section addCell:cell];
    
	    // create a cell with a text edit field in it.
	    MCSimpleTableTextEditCell* textEditCell = [[MCSimpleTableTextEditCell alloc] init];
	    textEditCell.cellIdentifier = @"text-edit-cell";
	    textEditCell.configureBlock = ^(MCSimpleTableCell* cell, UITableViewCell* tableCell)
	    {
	        tableCell.textLabel.text = @"Your name:";
	        MCSimpleTableTextEditCell* textCell = (MCSimpleTableTextEditCell*)cell;
	        textCell.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
	    };
	    textEditCell.didEndEditingBlock = ^(MCSimpleTableTextEditCell* simpleCell, UITextField* textField)
	    {
	        // save changed text into defaults
	        [[NSUserDefaults standardUserDefaults] setObject:textField.text
	                                                  forKey:@"name"];
	    };
	    [section addCell:textEditCell];
    
	    [self addSection:section];
	}
    
	- (void)viewDidDisappear:(BOOL)animated
	{
	    [super viewDidDisappear:animated];
    
	    [[NSUserDefaults standardUserDefaults] synchronize];
	}
    
	- (IBAction)switchChanged:(id)sender
	{
	    UISwitch* control = (UISwitch*)sender;
	    [[NSUserDefaults standardUserDefaults] setBool:control.isOn forKey:@"switch"];
	}

## Requirements

This library is for iOS apps, and uses ARC. It is build for iOS >= 5.1.

## License

This is licensed under BSD license. See LICENSE.md for legal wording.
