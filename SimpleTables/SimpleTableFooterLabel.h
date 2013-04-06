//
//  SimpleTableFooterLabel.h
//  SimpleTables
//
//  Created by Matt Connolly on 24/05/12.
//  Copyright (c) 2012 Sound Evolution Pty Ltd. All rights reserved.
//
// This isn't actually a label, but a view that contains the label and gives it a reasonable
// margin and some auto-sizing behaviour
//

#import <UIKit/UIKit.h>

@interface SimpleTableFooterLabel : UIView
{
    UILabel* _label;
    CGFloat _margin;
}

@property (nonatomic,readonly) UILabel* label;
@property (nonatomic,assign) CGFloat margin; // horizontal margin to leave between screen edge and label

// easy creation, it will size itself from the table
- (id) init;

@end
