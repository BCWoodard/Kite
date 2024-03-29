/*
 UITextfieldScrollViewController is a class that scroll texfields up the keyboard with animation, when keyboard is shown.
 Copyright (C) 2013 Michele Caldarone
 
 This file is part of UITextfieldScrollViewController.
 
 Implementation Instructions: https://github.com/mikthebig/ios-textfield-scroll/blob/master/README.md
 
 UITextfieldScrollViewController is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 UITextfieldScrollViewController is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with UITextfieldScrollViewController.  If not, see <http://www.gnu.org/licenses/>.
*/

#import <UIKit/UIKit.h>

#define DEFAULT_DISTACE_FROM_KEYBOARD       16.0

@interface UITextfieldScrollViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

// change this property to desired distance that textfield must have from keyboard when shown. Default value is set to DEFAULT_DISTACE_FROM_KEYBOARD
@property (nonatomic, assign) CGFloat distanceFromKeyboard;

// change this property if you want the textfield do not returns in own original position when keyboard is hiding. Default value is set to TRUE
@property (nonatomic, assign) BOOL scrollToPreviousPosition;

@end
