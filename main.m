//
//  main.m
//  MyEyetest
//
//  Created by MacCurver on Wed May 08 2002.
//  Copyright (c) 2001 MacCurver. All rights reserved.
//  Version 56
//


#import <Cocoa/Cocoa.h>

/// This prgram contains a tiny graphics routine to draw a pattern in a window,
/// showing a surprising effect of
/// how the eye can not manage certain aspects of vision.
///
/// -   The program is very tiny, but contains an English and German version
/// -   Printing is enabled and completely functional. However printing cocoa
///    controls gives stupid effects.
/// -   The help text is properly displayed in the english version, however
///    the German version the help is
///    being registered but not automatically displayed after being called
///    from the application help menu.
///    Must use "hiutil -vCaf ./search.helpindex English.lproj" === Still not ok
/// -   The ICON registration does not work properly, since the icons are not
///    correctly assigned to the application when running on another MAC. On
///    an iMac the myEytest application got the blast application ICON and
///    the Scetch application got the myEyetest ICON?!
/// -   Up to now now completely understood how to create a stand alone
///    running application.
///
/// Menu 'Build:Show detailed Build Results' Deployment is necessary?!
///
/// cd en.lproj
/// hiutil -I corespotlight -Caf MyEyetest.help/MyEyeTest.cshelpindex MyEyetest.help
///
/// - Parameters:
///   - argc: Propagated to NSApplicationMain but not used
///   - argv: Propagated to NSApplicationMain but not used
int main(int argc, const char *argv[]) {
    return NSApplicationMain(argc, argv);
}
