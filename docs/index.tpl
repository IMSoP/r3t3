{include file='html-start.tpl' title="R3T3 - Rowan's Really Rubbish Time Tracking Tool"}
{include file='generic-header.tpl'}

	<div id="content">
	
		<img src="r3t3-logo.png" alt="" style="float: right;" />
		
		<h1>R3T3 - Rowan's Really Rubbish Time Tracking Tool</h1>

		<h2>Introduction</h2>
			<p>I've tried a couple of shareware time-tracking tools, but none of them really met my needs - at least not well enough to spend money on - so I dug out my copy of Delphi and wrote my own.</p>
	
			<p>The basic idea is to be as simple and unobtrusive as possible - it's a bit like those "sticky notes" and "shopping list" programs you get, but with timers on it. That said, it's also been hacked together pretty quickly, and while it now works fairly well, it's still not exactly polished, and there's plenty more to do.</p>
	
			<p>Note that the program should be completely standalone; all settings are saved in a file called R3T3.ini in the same directory as the executable.</p>

		<h2>Use</h2>
			<p>To run, all you need is the executable file - download it, place it in a <strong>permanent</strong> location (so it can create a settings file), and run!
			
			<ul>
				<li><a href="RRRTTT.exe">Latest Version - 0.5 - 32-bit executable</a>
				</li>
				<li>End-user documentation is maintained (for now) as a good old <a href="ReadMe.txt">ReadMe.txt</a></li>
			</ul>
			</p>
			
		<h2>Develop</h2>
			<p>To hack around in it - or just laugh at my ridiculously unstructured code (did I mention I spent very little time coding this?) - you'll want the source, and a copy of Delphi.</p>
			
			<p>
				It's written with Turbo Delphi Explorer (the free version of Delphi 2006), which <del>is available from  <a href="http://www.turboexplorer.com/downloads">TurboExplorer.com</a></del><ins>appears to no longer be available</ins>. 
				I haven't used any custom libraries that aren't included in the source code, so if you do have a copy of Delphi at least that recent you should be able to open the <code>.bdsproj</code> file and build straight away.
				(The best alternative appears to be a free clone called Lazarus, but it may be some work to convert - see below. I guess that's what I get for developing on a non-free toolkit.)
			</p>
			
			<ul>
				<li><a href="RRRTTT-source-0.5.zip">Latest Version - source, zipped</a>
				</li>
			</ul>
			
		<h2>Pipeline</h2>
			<h3>Bugs</h3>
			
				<p>Things that shouldn't be that way in the first place, and need fixing:</p>
				
				<p style="font-style: italic; color: #666">Let me know if you find any...</p> 
				
			<h3>To Do</h3>
			
				<p>
				Things I intend to do at some point, but no promises when; in no particular order:
				</p>
				
				<ul>
					<li>Option to automatically start when Windows starts</li>
					<li>Tidy up the GUI some more; choose nicer colours</li>
					<li>Tidy up the code, and check for weird inefficiencies and memory leaks</li>
					<li>Option to periodically pop up and ask what the user is doing</li>
					<li>Warn the user if they leave the timer paused for &quot;too long&quot;</li> 
					<li>Ability to enter adjustments to timers, such as &quot;add 1 hour&quot;, &quot;remove 15 minutes&quot;, etc</li>
					<li>Idle timer (potentially related to adjustments, GUI-wise)</li>
					<li>Ability to re-order tasks (drag and drop)</li>
				</ul>
			
			 <h3>Might Do</h3> 
			
				<p>If I get round to it, or someone begs me enough.</p>
				
				<ul>
					<li>Configurable colours</li>
					<li>Load a "template" on first start of the day</li>
					<li>Some kind of smart layout for fitting large numbers of tasks on the screen</li>
					<li>Migrate project to <a href="http://www.lazarus.freepascal.org/">Lazarus</a>, a Free Delphi-clone IDE. Initial experiments suggest it would be possible, and it opens the interesting possiblity of cross-platform development, but it would require some re-work&hellip;</li>
				</ul>
			
			 <h3>Won't Do</h3> 
			
				<p>If you want these, find a different tool. Or, you know, <em>fork off</em>!</p>
				
				<ul>
					<li>Persistent management of tasks - I just want to scribble notes and work out the specifics later.</li>
					<li>Storage of more than one day in the GUI / files - this would be pretty pointless if all the tasks are free-form text.</li>
					<li>Integration with a central time logging system - if you wanted, you could always write a script to interpret the TSV auto-save files.</li>
				</ul>
				
		<h2>Changelog</h2>
		
			<h3>Version 0.5 - 23<sup>rd</sup> Feb 2010</h3>
			
			<ul>
				<li>FIXED: Some of the time formats don't get parsed right - I think I forgot to escape some dots&hellip;</li>
				<li>FIXED: When editting a click-to-edit field, loss of focus should imply accept, not cancel</li>
				<li>System Tray icon - enabled by default, but can be disabled in Options; double-click to show/hide task list</li>
				<li>Improved display of, and keyboard access to, more than 10 tasks, using labels and keys A to Z</li>
				<li>Save on exit; warn if no auto-save file active</li>
				<li><strong>.</strong> as short-cut representing current task (for editting time / description)</li>
			</ul>
		
		<h2>Licensing and Contact Info</h2>
		
			<p>&copy; Copyright Rowan Collins, 2010</p>
			
			<p><a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-Noncommercial-Share Alike 3.0 Unported License</a></p>
			
			<p>Basically, use it, share it, modify it, but credit me and don't sell it.
			And, preferably, let me know what you think of it, and what you're doing with it&hellip; Mail me on <tt>r3t3 [[AAHTT]] rwec.co.uk</tt></p>
	
	</div>
	
{include file='generic-footer.tpl'}
{include file='html-end.tpl'}
