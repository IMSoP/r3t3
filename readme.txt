*************************************************
*******                R3T3               *******
**  Rowan's Really Rubbish Time Tracking Tool  **
*******              v 0.3.1              *******
*************************************************

*****************
** Quick Start **
*****************

I've tried a couple of shareware time-tracking tools, but none of them really met my needs - at least not well enough to spend money on, so I dug out my copy of Delphi and wrote my own.

The basic idea is to be as simple and unobtrusive as possible - it's a bit like those "sticky notes" and "shopping list" programs you get, but with timers on it. That said, it's also been hacked together pretty quickly, and while it basically works, it's none too pretty, and there's plenty more to do.

It should be fairly obvious how to use it, but the absolutely key things to know before you use it are:

[1] Flag + \ [Holding the Windows Flag key and pressing backslash] hides and shows the main window. When hidden, there's no entry in the taskbar or system tray, it's truly invisible.

[2] Whenever no task is selected (including when you first run it) an extra red "Paused" timer appears at the bottom of the window; next time you activate a task, this time will be *added to that task*. The idea is you can quickly pause the timer when someone/something interrupts you, and work out where the time belongs later.

[3] All the descriptions, and all the timers (including the Paused timer, but not including the Total) can be editted by clicking on them; click the tick or press enter/return to confirm the change (clicking the cross, pressing escape, or clicking out of the box cancels).

[4] Use the Save button to specify a location to save to (e.g. using the date as the filename) and the system will save its state to that file once a minute. It's just a text file with tab-separated fields, so you can open it with notepad or whatever.


************************
** Keyboard Shortcuts **
************************

Note that I've only ever run this with a standard UK keyboard, and some of the virtual keycodes are a bit vague, so if you're using anything else, YMMV.

** Global Windows Shortcuts **

Flag + \	Show/hide main window

** Main Window Shortcuts **

\	Pause
0 to 9	Activate task with that number [numpad works too]
`	The button to the left of 1 acts as an extra 0, because it felt natural
+ or =	Add a new task


***********
** To Do **
***********

Things I intend to do at some point, but no promises when; in no particular order:

* Tidy up the GUI some more; choose nicer colours
* Resize the window to fit the number of tasks; currently, only about 11 tasks fit
* More keyboard shortcuts
* Persistent auto-save settings: store a directory name in an INI file, and automatically save (and load) "today's file" in that directory

**************
** Might Do **
**************

If I get round to it, or someone begs me enough.

* System Tray icon - pretty easy to do, but I'm personally happy without it

**************
** Won't Do **
**************

If you want these, find a different tool.

* Persistent management of tasks - I just want to scribble notes and work out the specifics later.
* Storage of more than one day in the GUI / files - this would be pretty pointless if all the tasks are free-form text.
* Integration with a central time logging system - if you wanted, you could always write a script to interpret the TSV auto-save files.

**********************************
** Licensing and Technical Info **
**********************************

(C) Copyright Rowan Collins, 2008 <mailto:r3t3@rwec.co.uk>

Licensed under the Creative Commons CC-BY-NC or whatever it's called.
Basically, use it, share it, modify it, but credit me and don't sell it.
And, preferably, let me know what you think of it, and what you're doing with it...

To compile the source code you will need a copy of Turbo Delphi Explorer (the free version of Delphi 2006), which is available from  http://www.turboexplorer.com/downloads
I haven't used any custom libraries or anything that's not included in the source code, so you should be able to open the .bdsproj file and build straight away.