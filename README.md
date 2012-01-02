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

To create your own 'application' for the desktop there is very little for you to do. Follow the steps given bellow.

### Create a desktop application

Create a regular Netzke component, for this example we will use a panel component containing some basic HTML.

Location: <rails_app_path>/app/components/hello_world_panel.rb

```ruby
     class HelloWorldPanel < Netzke::Basepack::Panel
       js_properties :height => 250,
                     :width  => 250,
                     :html   => %Q{<p>Hello world</p>}
     end
```

Now we need this component to be nested within an application window that has all the fancy features, and to do this we must create a second component that inherits from MasterWindow, which itself inherits from the regular Netzke window class

Location: <rails_app_path>/app/components/hello_world_window.rb

```ruby
     class HelloWorldWindow < MasterWindow
       js_properties :title => "Hello world"
       def default_config
         {
           :name => "Hello World",
           :minimizable => true,
           :maximizable => true,
           :persistence => true,
           :icon_cls => "about"
           :items => [{
                        :class_name => "HelloWorldPanel",
                        :header => false, :border => false
                     }]
         }
       end
     end
```

### Make the desktop aware of our application and link to menu

Okay so we have our 'application' written, lets make the desktop aware of it and hook it up to a menu and we are good to go.  The desktop is again just an extension of a regular Netzke component. In this case it inherits from SimpleApp.

Location: <rails_app_path>/app/components/app.rb

1. Add a reference to the **window** component:

```ruby
     component :hello_world_window
```

2. Declare an action for the window (so it loads)

```ruby
     action :hello_world_window,
            :icon => :information_frame,
            :isDesktopable => true,
            :text => "Hello world",
            :handler => :load_window
```
3. Create a menu entry for the Hello world application. We will put it in the 'Help' menu, next to the about app. Locate the line that begins with **:text => 'Help',** and add the following code snippet to the menu symbols array (make sure you seperate the array elements with a comma)

```ruby
     :hello_world_window.action
```

We are all ready to view our new application in the desktop. If your desktop application is running in development mode then we can just go to the browser and reload the page and there it is in the menu..

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

## Advanced applications

 * An example set of advanced Netzke-desktop-applications that can perform long running tasks server side without locking up the main rails process. This allows the user to continue using the desktop and its other applications during these processes.
 
### New Netzke-based web-desktop features

 * Implementation of the tree view panel
 * A different (much cooler) way to present applications menus courtesy of Steve Brownlees post here (http://www.fusioncube.net/index.php/sencha-extjs-making-a-boring-and-a-cool-toolbar-for-an-application)
 * Toast messages courtesy of Edouard Fattal here (http://www.sencha.com/forum/showthread.php?32365-Ext.ux.Notification)

### New server-side features
 * Delayed_job gem to run specified code outside of the main rails process
 * Faye gem for pub/sub between the server and the client browser

### Setting up and running server-side processes
**Add tree view code to the Netzke-base pack**

* Copy and rename the following file (to locate your gems folder type 'bundle show netzke-basepack):

```ruby
     FROM: <netzke.desktop.root>/lib/netzke/tree.rb.belongs.in.netzke-basepack
     TO: <gems.folder>/netzke-basepack-0.6.4/lib/netzke/basepack/tree.rb
```

**Run Faye server:**

* Open a new terminal
* Naviate to <netzke.desktop.root>
* Enter the following command:

```ruby
     rackup faye.ru -E production -s thin
```

**Run delayed job daemon**

* Open a new terminal
* Navigate to <netzke.desktop.root>
* Enter the following command: 

```ruby
     rake jobs:work
```

**Run Rails server**

* Open a new terminal
* Navigate to <netzke.desktop.root>
* If your Rails server is already running, stop it.
* Enter the following command:

```ruby
     rails s
```

### Using the advanced application
 
* Open the advanced application
* You will have a menu, a tree view and a panel
 * The menu triggers long running jobs on the server
 * The tree view lists previously ran jobs
 * The panel shows details of a job when highlighted in the tree view
* There are two jobs that can be run from the applications menu:  
*While a job is running the advanced-application will be disabled, to prevent futher jobs being actioned from it*
 * Job 1 - backup emails (it doesnt really backup anything..)  
*Clicking this menu option will set the server processing a job that runs for 7 or so seconds, and will complete successfully*
 * Job 2 - backup google emails  
*Clicking this menu option will set the server processing a job that runs for 30 or so seconds, this will fail (on purpose) to show a job that exceeds our delayed job configuration of a maximum process time of 25 seconds*
* When a job completes we get the following actions:
 * We will get a Toast message on the bottom right of the desktop notifying us of the job that has completed, successful or not.
 * The contents of the application are reloaded, thus updating the tree view with the latest completed jobs
 * The applications mask will be removed making it responsive once again

While one of the above jobs is running in this application, you may fire off another desktop application, and it will still be responsive, thus proving that the desktop can remain responsive even if we have long running jobs being triggered by its apps

## More info

View a *live* demo of the basic Netzke-based web-desktop: http://netzke-desktop-demo.heroku.com

Official Netzke project site: http://netzke.org

---
Copyright (c) 2011 Paul Cockrell, released under the MIT license
Note, that Ext JS itself is licensed [differently](http://www.sencha.com/products/extjs/license/)
