//
//  SimpleTableTextEditCell.h
//  SimpleTables
//
//  Created by Matt Connolly on 25/04/12.
//  Copyright (c) 2012 Sound Evolution Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleTableCell.h"

/**
 
 The default UITextField behaviour will be to have "Done" as the return key, and to end editing 
 when return is pressed. This will invoke the didEndEditingBlock where custom code can read the
 text field contents, etc.
 
 If more customisation is required, it would be better to subclass SimpleTableTextEditCell and 
 implement the UITextFieldDelegate methods accordingly.
 
 **/

@class SimpleTableTextEditCell;

typedef void(^SimpleTableTextEditCell_DidBeginEditing)(SimpleTableTextEditCell* simpleCell, UITextField* textField);
typedef void(^SimpleTableTextEditCell_DidEndEditing)(SimpleTableTextEditCell* simpleCell, UITextField* textField);

@interface SimpleTableTextEditCell : SimpleTableCell<UITextFieldDelegate>
{
    int _textFieldHeight;
}

@property (nonatomic, readonly) UITextField* textField;
@property (nonatomic, assign) int textFieldHeight;

// this block will be called when the text field begins / ends editing
@property (nonatomic, copy) SimpleTableTextEditCell_DidEndEditing didEndEditingBlock;
@property (nonatomic, copy) SimpleTableTextEditCell_DidBeginEditing didBeginEditingBlock;

@end


@interface SimpleTableTextEditCell_Cell : UITableViewCell
{
    UITextField* _textField;
    int _textFieldHeight;
}

@property (nonatomic, readonly) UITextField* textField;
@property (nonatomic, assign) int textFieldHeight;

@end