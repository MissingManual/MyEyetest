// Version 56

#import "MyEyetestView.h"


/// Implementation of a view - Also implements a simple controller
@implementation MyEyetestView


/// Sets enter and exit of the tracking rect to the frame of the boxView
/// This method is being called by the system, after start and after resize!
- (void)updateTrackingAreas {
    [self removeTrackingArea:trackingArea];
    double width = boxView.frame.size.width;
    NSRect eyeBox = NSMakeRect(self.frame.size.width-width
                               , self.frame.origin.y
                               , width
                               , self.frame.size.height
                    );

    trackingArea = [[NSTrackingArea alloc] initWithRect:eyeBox
        options: (NSTrackingMouseEnteredAndExited | NSTrackingActiveInKeyWindow)
        owner:self userInfo:nil];
    [self addTrackingArea:trackingArea];
}


/// Unhide the boxVIew with the controls
/// - Parameter theEvent: Unused
///
/// Event generated by the tracking rectangle
- (void)mouseEntered:(NSEvent *)theEvent {
    [boxView setHidden:false];
}
 

/// Hide the boxView
/// - Parameter theEvent: Unused
///
/// Event generated by the tracking rectangle
- (void)mouseExited:(NSEvent *)theEvent {
    [boxView setHidden:true];
}



/// Called after nib was loaded
///
/// Initializes all parameters with the settings used in design by IB.
/// Sets the outlet boxView as I could not get it from IB
/// Some trials using the Helpmanagner did not succeed
- (void)awakeFromNib
{
	[self changeParameters:self];								                // retrieve parameters from nib
    //[self.window toggleFullScreen:self];                                      // make full screen directly

    boxView = self.window.contentView.subviews[0].subviews[0];

    // In the original version help was working as described by Apple in 2013,
    // but conversion to modern ... was breaking the help. Therefore help is
    // implemented as simple html (see below:''myEyetestHelp'')
    //BOOL test = [[NSHelpManager sharedHelpManager]
    //                  registerBooksInBundle:[NSBundle mainBundle]
    //            ];
    //assert(test);
    /*
    [[NSHelpManager sharedHelpManager]
                openHelpAnchor:@"Augentest"
                        inBook:nil
    ];
    */
    //NSString *locBookName = @"Resources/de.lproj/MyEyetestHelp/Augentest Hilfe.htm"; //[[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleHelpBookName"];
    //NSString *locBookName = @"Augentest Hilfe.htm"; //[[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleHelpBookName"];
    //[[NSHelpManager sharedHelpManager] openHelpAnchor:@"Augentest"  inBook:locBookName];
}



/// Draw everything
/// - Parameter rect: Complete view rectangle
///
/// Draws a vertcal and horizontal grid of lines and finally circles on top of it.
- (void)drawRect:(NSRect)rect {
	NSRect  lineRect;											                // to draw the horizontal and vertical lines
	int		xPosition;											                // position counters for horizontal and vertical position
	int		yPosition;
	int		d		            = distances.intValue;			                // distance between the lines in pixel, taken from slider control
	int		lineWidthValue		= lineWidth.intValue;			                // linewidth ...
	int		sizeValue			= size.intValue;				                // diameter of the circles ...
	float   transp              = transparency.floatValue;	                    // transparancy of the lines: 0.0...1.0
	NSRect  myBounds			= self.bounds;				                    // complete bounding rectangle
	
	NSRectFill(myBounds);										                // fill with black color
	
    NSLog(@"%f", transp);
    [[NSColor colorWithDeviceRed:transp green:transp blue:transp alpha:1.0] set];
	
    
	// plot n horizontal lines
	lineRect	= myBounds;										                // initialize for a horizontal line
	lineRect.size.height = lineWidthValue;
	for (yPosition = myBounds.size.height/2 - d*floor(myBounds.size.height/(2*d));
         yPosition <= myBounds.size.height;
         yPosition += d
    ) {
		lineRect.origin.y = myBounds.origin.y - lineWidthValue/2 + yPosition;
		//NSRectFill(lineRect);
        NSRectFill(lineRect);
	}
	
    
	// plot n vertical lines
	lineRect	= myBounds;										                // initialize for a vertical line
	lineRect.size.width = lineWidthValue;
	for (xPosition = myBounds.size.width/2 - d*floor(myBounds.size.width/(2*d));
         xPosition <= myBounds.size.width;
         xPosition += d
    ) {
		lineRect.origin.x = myBounds.origin.x - lineWidthValue/2 + xPosition;
        NSRectFill(lineRect);
	}
    

	// plot grid of circles
    [[NSColor colorWithCalibratedRed:1.0f green:1.0f blue:1.0f alpha:1.0f] set];
	lineRect.size.width = sizeValue;							                // rectangle enclosing the circle
	lineRect.size.height = sizeValue;
	for (yPosition = myBounds.size.height/2
         - d*floor(1+myBounds.size.height/(2*d));
         yPosition <= myBounds.size.height+d;
         yPosition += d
    ) {
		lineRect.origin.y = myBounds.origin.y - (sizeValue+1)/2 + yPosition;
		for (xPosition = myBounds.size.width/2
             - d*floor(1+myBounds.size.width/(2*d));
             xPosition <= myBounds.size.width+d;
             xPosition += d
        ) {
			lineRect.origin.x = myBounds.origin.x - (sizeValue+1)/2 + xPosition;
			[[NSBezierPath bezierPathWithOvalInRect:lineRect] fill];
		}
	}
    
}

/// Common method to be called to refresh the screen after any parameter has been changed
/// - Parameter sender: Just ignored
///
- (IBAction)myEyetestHelp:(NSMenuItem *)sender {
    
    /*
    
    // All supported languages
    NSURL* resourceURL = NSBundle.mainBundle.resourceURL;
    NSError* error = nil;
    
    NSArray *dirContents =
          [NSFileManager.defaultManager contentsOfDirectoryAtURL:resourceURL
            includingPropertiesForKeys:@[]
                               options:NSDirectoryEnumerationSkipsHiddenFiles
                                 error:nil
          ];
    NSPredicate *predicate = [NSPredicate
                                predicateWithFormat:@"pathExtension='lproj'
                            && ! lastPathComponent='Base.lproj'"];
    NSArray *folders = [dirContents filteredArrayUsingPredicate:predicate];
    
    NSMutableArray *supportedLanguages = [[NSMutableArray alloc] init];
    for (NSString *path in folders) {
        NSString *dirName = [path.lastPathComponent stringByDeletingPathExtension];
        [supportedLanguages addObject:dirName] ;
    }
  

    NSString *langugeCode = NSLocale.currentLocale.languageCode;
    NSString *filePath    = @"en.lproj/MyEyetest.help/MyEyetest";
    if ([supportedLanguages containsObject:langugeCode]) {
        filePath = [NSString
                        stringWithFormat:@"%@.lproj/MyEyetest.help/MyEyetest"
                      , langugeCode
                    ];
    }
    
    NSString *urlPath = [NSBundle.mainBundle
                         pathForResource:filePath
                         ofType:@"html"
                        ];
    NSURL *openLink = [NSURL fileURLWithPath:urlPath];
    [NSWorkspace.sharedWorkspace openURL:openLink];
    */
    NSString *langugeCode = NSLocale.currentLocale.languageCode;
    
    NSString *filePath = [NSString
                              stringWithFormat:@"%@.lproj/MyEyetest.help/MyEyetest"
                             , langugeCode
                         ];
    
    NSString *urlPath = [NSBundle.mainBundle
                         pathForResource:filePath
                         ofType:@"html"
                        ];
    if (!urlPath) {
        /// If file access failed we use english
        filePath = @"en.lproj/MyEyetest.help/MyEyetest";
        urlPath = [NSBundle.mainBundle
                             pathForResource:filePath
                             ofType:@"html"
                            ];
    }
    NSURL *openLink = [NSURL fileURLWithPath:urlPath];
    [NSWorkspace.sharedWorkspace openURL:openLink];

}

/// Called whenever a slider was changed to update the view
/// - Parameter sender: Ignored
- (IBAction)changeParameters:(id)sender {
	[self setNeedsDisplay: YES];
}


/// Generic printing method - Copies the view contents onto the selected paper
/// - Parameter sender: Just ignored
///
- (IBAction)print:(id)sender {									                // we overwrite this method to print only this view, without any controls

	op = [NSPrintOperation printOperationWithView:self];
	pInfo = op.printInfo;										                // we need access to the print info record to overwrite some settings
	pInfo.topMargin = 0.0;									                    // set all margins to 0 to get most out of the paper size
	pInfo.leftMargin = 0.0;
	pInfo.rightMargin = 0.0;
	pInfo.bottomMargin = 0.0;
	[pInfo setVerticallyCentered:YES];							                // center the image in both directions
	[pInfo setHorizontallyCentered:YES];
    if (pInfo.orientation == NSPaperOrientationLandscape) {
		pInfo.verticalPagination = NSFitPagination;			                    // fit the size of the picture, so that it fits on one page only
	} else {
		pInfo.horizontalPagination = NSFitPagination;
	}
	[op runOperation];
}



@end
