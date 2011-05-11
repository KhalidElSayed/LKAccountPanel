Custom UIAlertView
====================

LKAccountPanel class can display custom UIAlertView to require username and password.
![](https://github.com/lakesoft/LKAccountPanel/documents/LKAccountPanel-1.jpg)

Usage
-----

Only call the show method like below:

	[LKAccountPanel showWithTitle:@"Test"
		completion:^(BOOL result, NSString* username, NSString* password) {
			NSLog(@"result: %d\nusername: %@\npassword: %@",
				result, username, password);
	}];

'result' argument of the blocks is for detecting whether OK button is pushed. If 'result' is YES then OK button is pushed.


Installation
-----------

You should copy below files to your projects.

 LKAccountPanel.h
 LKAccountPanel.m
 en.lproj/LKAccountPanel.strings
 ja.lproj/LKAccountPanel.strings	*optional



License
-------
MIT

Copyright (c) 2011 Hiroshi Hashiguchi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

