*************************************************
*******                R3T3               *******
**  Rowan's Really Rubbish Time Tracking Tool  **
*******              v 0.4.1              *******
*************************************************

******************
** Introduction **
******************

I've tried a couple of shareware time-tracking tools, but none of them really met my needs - at least not well enough to spend money on - so I dug out my copy of Delphi and wrote my own.

The basic idea is to be as simple and unobtrusive as possible - it's a bit like those "sticky notes" and "shopping list" programs you get, but with timers on it. That said, it's also been hacked together pretty quickly, and while it now works fairly well, it's still not exactly polished, and there's plenty more to do.

Note that the program should be completely standalone; all settings are saved in a file called R3T3.ini in the same directory as the executable.

The latest version, including source, can be found at http://rwec.co.uk/r3t3

*****************
** Quick Start **
*****************

It should be fairly obvious how to use it, but the absolutely key things to know before you use it are:

[1] Flag + \ [Holding the Windows Flag key and pressing backslash] hides and shows the main window. When hidden, there's no entry in the taskbar or system tray, it's truly invisible.

[2] Whenever no task is selected (including when you first run it) an extra red "Paused" timer appears at the bottom of the window; next time you activate a task, this time will be *added to that task*. The idea is you can quickly pause the timer when someone/something interrupts you, and work out where the time belongs later.

[3] All the descriptions, and all the timers (including the Paused timer, but not including the Total) can be editted by clicking on them; click the tick or press enter/return to confirm the change (clicking the cross, pressing escape, or clicking out of the box cancels).

[4] To set up automatic saving, click "Options", and set a directory and file mask; whenever you start the program, it will create a filename based on today's date, and save to it every minute. If "today's" file already exists, it will be automatically loaded, so if you have to exit the program, it will pick up where it left off. The result is just a text file with tab-separated fields, so you can open it with notepad or whatever.

************************
** Manual Save / Load **
************************

As well as the full auto-save described above, you can also use the Save button to manually specify a location to save to and the system will save its state to that file once a minute. Similarly, the Load button will read in an existing file, and then use that file as the location to save to.

If you want to stop the timers being saved once a minute, untick the Auto-Save box on the main screen.

************************
** Keyboard Shortcuts **
************************

Note that I've only ever run this with a standard UK keyboard, and some of the virtual keycodes are a bit vague, so if you're using anything else, YMMV.

** Global Windows Shortcuts **

Flag + \	Show/hide main window

** Main Window Shortcuts **

\		Pause
Shift + \	Pause, and edit paused time
+ or =		Add a new task
Alt + (+ or =)	Add a new task, and edit its description
0 to 9		Activate task with that number
Alt + 0 to 9	Edit the description for that task
Shift + 0 to 9	Edit the time for that task
`		The button to the left of 1 acts as an extra 0, including with Shift and Alt, because it felt natural
Numpad		The numpad works for plain 0-9, and Alt + 0-9; using Shift over-rides numlock, so the app just sees "Insert", "Page Up", etc


*******************
** Time Editting **
*******************

When editting a timer, the following formats are recognised:

m		Any number on its own is interpretted as a number of minutes
		e.g. '5' => '00:05:00', '130' => '02:10:00'
hh:mm		Hours and minutes - minutes must be 0 to 59, leading 0 is optional
		Either hours or minutes can be omitted
		e.g. '1:23' => '01:23:00', '1:' => '01:00:00', '1:02' => '01:02:00', '1:2' => '01:02:00'
hh:mm:ss	As above, but with seconds
h.xxx		Hours and fractions of hours; if h is missing, 0 is assumed
		e.g. '1.5' => '01:30:00', '.25' => '00:15:00'


**********************************
** Licensing and Technical Info **
**********************************

(C) Copyright Rowan Collins, 2009 <mailto:r3t3@rwec.co.uk>

Licensed under the Creative Commons CC-BY-NC or whatever it's called.
Basically, use it, share it, modify it, but credit me and don't sell it.
And, preferably, let me know what you think of it, and what you're doing with it...

To compile the source code you will need a copy of Turbo Delphi Explorer (the free version of Delphi 2006), which is available from  http://www.turboexplorer.com/downloads
I haven't used any custom libraries or anything that's not included in the source code, so you should be able to open the .bdsproj file and build straight away.