//
//  SimpleTablesTextEditCell.m
//  SimpleTables
//
//  Created by Matt Connolly on 25/04/12.
//  Copyright (c) 2012 Matthew Connolly. All rights reserved.
//

#import "MCSimpleTableTextEditCell.h"

static CGRect DEFAULT_RECT = { { 0, 0 }, { 300.0f, 24.0f } };
static CGFloat DEFAULT_CELL_HEIGHT = 65.0f;
static CGFloat DEFAULT_TEXTFIELD_HEIGHT = 28.0f;
static CGFloat VERTICAL_SPACING = 4.0f;
static int TEXTFIELD_TAG = 999;

@interface MCSimpleTableTextEditCell()
@property (nonatomic, retain) UITextField* textField;
@end

@implementation MCSimpleTableTextEditCell

- (id)init
{
    self = [super init];
    if (self) {
        self.cellClass = [SimpleTableTextEditCell_Cell class];
        self.cellHeight = DEFAULT_CELL_HEIGHT;
        self.textFieldHeight = DEFAULT_TEXTFIELD_HEIGHT;
    }
    return self;
}


- (void) configureCell:(UITableViewCell *)cell
{
    // additional config
    SimpleTableTextEditCell_Cell* text_cell = (SimpleTableTextEditCell_Cell*)cell;
    text_cell.simpleCell = self;
    text_cell.textFieldHeight = self.textFieldHeight;
    text_cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textField = text_cell.textField;
    self.textField.delegate = self;
    self.textField.borderStyle = UITextBorderStyleLine;
    self.textField.returnKeyType = UIReturnKeyDone;
    
    // allow block to overide above
    [super configureCell:cell];
}


#pragma mark - UITextFieldDelegate methods

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if (self.didEndEditingBlock)
    {
        self.didEndEditingBlock(self, textField);
    }
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.didBeginEditingBlock)
    {
        self.didBeginEditingBlock(self, textField);
    }
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:NO];
    
    return YES;
}

@end





@implementation SimpleTableTextEditCell_Cell

@synthesize textField = _textField;
@synthesize textFieldHeight = _textFieldHeight;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _textField = [[UITextField alloc] initWithFrame:DEFAULT_RECT];
        _textField.tag = TEXTFIELD_TAG;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    UIView* container = self.textLabel.superview;
    if ([container viewWithTag:TEXTFIELD_TAG] == nil) {
        [container addSubview:self.textField];
    }
    
    CGRect labelRect, fieldRect, bounds;
    
    bounds = container.bounds;
    labelRect = self.textLabel.frame;
    fieldRect = self.textField.frame;
    
    fieldRect.size.width = labelRect.size.width;
    fieldRect.size.height = self.textFieldHeight;
    fieldRect.origin.x = labelRect.origin.x;
    fieldRect.origin.y = bounds.origin.y + bounds.size.height - VERTICAL_SPACING - fieldRect.size.height;
    
    labelRect.origin.y = bounds.origin.y + VERTICAL_SPACING;
    labelRect.size.height = fieldRect.origin.y - VERTICAL_SPACING - labelRect.origin.y;
    
    self.textLabel.frame = labelRect;
    self.textField.frame = fieldRect;
}

- (void)prepareForReuse;
{
    [super prepareForReuse];
    
    self.simpleCell.textField = nil;
    self.simpleCell = nil;
}

@end
