/* MyEyetestView */

#import <Cocoa/Cocoa.h>

/// NSView to show grid lines and circles on black surface
@interface MyEyetestView: NSView {
    
    IBOutlet NSSlider *distances;                                               ///< Still somehow connected, but don't know why
    IBOutlet NSSlider *lineWidth;
    IBOutlet NSSlider *transparency;
    IBOutlet NSSlider *size;

    IBOutlet NSView *allControls;                                               ///< Can't connect this one see ''awakeFromNib''
    
    /// Somehow I am not capable to add further IBOutlets using the IB, but adding IBActions does work?!
    /// Neither I am able to connect allControls
    
    
    NSPrintOperation *op;                                                       ///< Used for printing
    NSPrintInfo *pInfo;                                                         ///< Info for the printing
    
    NSTrackingArea *trackingArea;                                               ///< Mouse tracking area to show hide the box
    NSView *boxView;                                                            ///< Box for the controls - I could not get IBOutlet using IB
}

/// Connected to all sliders that change a value
- (IBAction)changeParameters:(id)sender;
- (IBAction)myEyetestHelp:(NSMenuItem *)sender;

@end
