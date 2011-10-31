# Netzke desktop demo

A web-desktop prototype using Ruby on Rails, Netzke, and Ext JS.
The Netzke desktop demo is loosely based upon the appearance of the Gnome 2.X Linux desktop.

## Requirements

* Ruby 1.9.2 (1.8.7 may work, too)
* Rails >= 3.0.0
* Ext JS = 3.3.1 (Later versions may work too)
* Sqlite 3

## Installation

In the rails application root run:

	bundle install

Build the database:

	rake db:migrate

Populate the database with example data:

	rake db:seed

## Usage

In the rails application root run:

	rails s

In your browser enter the following address (assuming that you are using the Rails default port)

	http://localhost:3000

## Features

Netzke-desktop-demo tries to emulate regular desktop functionality:

### Top toolbar

 * Menus
  * Launch an application by left-clicking on a menu item
  * Create a desktop icon by right-clicking on a menu item, revealing the context menu, select *Create desktop icon*
 * Multiple desktop switcher
  * There are four virtual desktops we can move applications to and switch between. These desktops are represented by the four numbered monitor icons on the far right of the toolbar. Clicking on these icons will switch to the corresponding virtual desktop
 * Logout
  * To log out of the desktop you click on the *unplugged power cable* icon on the far right of the toolbar. This has no action behind it and is for show only

### Desktop

 * Desktop icons
  * Launch an application by double-clicking the desktop icon
  * Right click the desktop icon to show its context menu. From this we can choose to launch the associated application or delete the desktop icon

### Application windows

 * To maximize/restore an application window double-click the title bar 
 * To move an application to another virtual desktop you right-click the title bar to show its context menu, and select the virtual desktop to move it to. The current virtual desktop option will be greyed out

### Status bar

 * Application buttons
  * To reveal the full application name hover the mouse-cursor over the application button 
  * Left clicking the button cycles through the following actions: Focus corresponding window (including switching to that windows 'desktop'), minimize corresponding window, restore corresponding window
  * Right-clicking the application button opens the context menu, which offers the following actions: Minimize application, restore application, maximize application, close application
 * Network traffic icon on the far right of the status bar, turns red while the desktop is busy communicating to the server/rendering applications
 * Digital clock showing us the time

## More info

View a *live* demo of the netzke-desktop-demo: http://freezing-meadow-3901.heroku.com

Official Netzke project site: http://netzke.org

---
Copyright (c) 2011 Paul Cockrell, released under the MIT license
Note, that Ext JS itself is licensed [differently](http://www.sencha.com/products/extjs/license/)
