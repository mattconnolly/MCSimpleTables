//
//  SimpleTableFooterLabel.m
//  SimpleTables
//
//  Created by Matt Connolly on 24/05/12.
//  Copyright (c) 2012 Sound Evolution Pty Ltd. All rights reserved.
//
// This isn't actually a label, but a view that contains the label and gives it a reasonable
// margin and some auto-sizing behaviour
//

static const CGFloat DEFAULT_MARGIN = 23.0f;


#import "SimpleTableFooterLabel.h"

@implementation SimpleTableFooterLabel

@synthesize label = _label;
@synthesize margin = _margin;

- (id)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.backgroundColor = [UIColor clearColor];
        _label.lineBreakMode = UILineBreakModeWordWrap;
        _label.minimumFontSize = 12.0f;
        _label.numberOfLines = 0;
        _label.textAlignment = UITextAlignmentCenter;
        _label.font = [UIFont boldSystemFontOfSize:14.0f];
        _label.textColor = [UIColor colorWithRed:0.30f green:0.34f blue:0.43f alpha:1.0f];
        _label.shadowColor = [UIColor whiteColor];
        _label.shadowOffset = CGSizeMake(0, 1);
        _label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:_label];
        self.margin = DEFAULT_MARGIN;
    }
    return self;
}


- (CGSize) sizeThatFits:(CGSize)size
{
    size.width -= self.margin * 2.0f;
    CGSize label_size = [_label.text sizeWithFont:_label.font 
                                constrainedToSize:size 
                                    lineBreakMode:_label.lineBreakMode];
    label_size.width += self.margin * 2.0f;
    return label_size;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    CGRect frame = bounds;
    
    frame.origin.x = bounds.origin.x + self.margin;
    frame.size.width = bounds.size.width - self.margin * 2.0f;
    _label.frame = frame;
}

@end
