{
  afterRender: function(){
    var args=arguments;
    Netzke.classes.Basepack.SimpleApp.superclass.afterRender.call(this, args);
   
    // main menu parent object
    var _menu_arr = new Array();
    _menu_arr.push(this.findById('app__application_menu'));
    _menu_arr.push(this.findById('app__system_menu'));

    var that = this;
    _menu_arr.forEach(function(_menu) {
      that.addDesktopIconActionToMenu(_menu);
    });

    // initialize the work space manager
    this.initWorkSpaceManager();

    // initialize the desktop icon manager
    this.initDesktopIconManager();
    
    // digital clock for status bar
    this.addTimeToStatusBar();
  },

  addTimeToStatusBar: function() {
    var sbarObj = Ext.getCmp('main-statusbar');
    var timeObj = new Ext.Toolbar.TextItem({text:'', id:'main-statusbar__time'});
    sbarObj.insert(sbarObj.items.length,timeObj);
    Ext.TaskMgr.start({
      run: function() {
        var d = new Date();
        timeObj.setText(d.format('G:i:s'));
      },
      interval: 1000       
    });
  },

  addDesktopIconActionToMenu: function(_menu) {
    var that=this;
   
    _menu.menu.items.each(function(_menu_item) {
      _menu_item.addListener('render', function(c) {
        c.el.on('contextmenu', function(e) { 
          e.stopEvent();
          c.parentMenu.hide(false);
          if (c.getXType() === 'menuitem' && c.isDesktopable) {
            that.instanciateContextMenu(e, c);
          }
        }, this)
      });
   
      if (_menu_item.menu) {
        that.addDesktopIconActionToMenu(_menu_item);
      }
    });
  },

  instanciateContextMenu: function(e, item) {
    this.createContextMenu(item);
    if (!this.contextMenu.el) {
      this.contextMenu.render();
      var xy = e.getXY();
      //xy[1] -= this.contextMenu.el.getHeight();
      this.contextMenu.showAt(xy);
    }
  },

  createContextMenu: function(item) {
    this.contextMenu = new Ext.menu.Menu({
      items: [{
                text: 'Create desktop icon',
                icon: 'images/icons/plus_circle_frame.png',
                handler: function(){
                  this.createDesktopIcon(item);
                  item.desktopIcon.button.show();
                },
                scope: this
              }]
     });
  },
  
  showContextMenu: function() {
    this.contextMenu.show();
  },
  
  doNothing: function() {
    return false;
  },

  alertUser: function(txt) {
//    Ext.example.msg('Workspace switch', 'You are now viewing workspace {0}', txt);
  }
}

