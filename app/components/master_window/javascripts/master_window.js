{
    initComponent: function() {
      var args = arguments;
      Netzke.classes.Basepack.Window.superclass.initComponent.call(this, args);
      this.on('minimize', function() {this.doMinimize();});
      
      var current_work_space = Ext.getCmp('app').getCurrentWorkSpace();
      this.setInWorkSpace(current_work_space);
    },

    afterRender: function() {
      var args = arguments;
      Netzke.classes.Basepack.Window.superclass.afterRender.call(this, args);
      Ext.getCmp('app').updateStatusButtons();
 
      // disable browsers right click action
      this.el.on('contextmenu', function(e) {
        e.stopEvent();
      }, this);

      // set listener to display contextmenu when the window header is right-clicked only
      // context menu needs to be rebuilt each click as to update the disabled workspace options
      var that = this;
      this.header.addListener('contextmenu', function(e) {
        e.stopEvent();

        if (that.cmenu)
          that.cmenu.destroy()
        
        that.buildContextMenu();
        that.cmenu.render();
        
        var xy = e.getXY();
        that.cmenu.showAt(xy);
      });
    },

    buildContextMenu: function() {  
      var current_work_space = Ext.getCmp('app').getCurrentWorkSpace();
      this.cmenu = new Ext.menu.Menu({
        items: [{
                  icon: 'images/icons/monitor_one_inactive.png',
                  text: 'Move to workspace 1',
                  handler: function() {
                             this.moveToWorkSpace(1)
                  },
                  scope: this,
                  disabled: current_work_space === 1 ? true : false
                },{
                  icon: 'images/icons/monitor_two_inactive.png',
                  text: 'Move to workspace 2',
                  handler: function() {
                             this.moveToWorkSpace(2)
                  },
                  scope: this,
                  disabled: current_work_space === 2 ? true : false
                },{
                  icon: 'images/icons/monitor_three_inactive.png',
                  text: 'Move to workspace 3',
                  handler: function() {
                             this.moveToWorkSpace(3)
                  },
                  scope: this,
                  disabled: current_work_space === 3 ? true : false
                },{
                  icon: 'images/icons/monitor_four_inactive.png',
                  text: 'Move to workspace 4',
                  handler: function() {
                             this.moveToWorkSpace(4)
                  },
                  scope: this,
                  disabled: current_work_space === 4 ? true : false
                }]
      });
    },

    moveToWorkSpace: function(to_work_space) {
      Ext.getCmp('app').shiftItemToWorkSpace([this], to_work_space);
      this.setInWorkSpace(to_work_space);
    },

    close: function() {
      var args = arguments;
      this.setAnimateTarget(this.orgAnimateTarget);
      Netzke.classes.Basepack.Window.superclass.close.call(this, args);
      
      Ext.History.add('');
      Ext.getCmp('app').updateStatusButtons();
    },

    toggleMinimizeVars: function() {
      this.isMinimized === true ? this.isMinimized = false : this.isMinimized = true; 
    },

    doRestore: function() { 
      this.toggleMinimizeVars();
      this.show();
    },

    doMinimize: function() {
      this.toggleMinimizeVars();
      this.animateTarget=this.associatedButton;
      this.hide();
    },

    getInWorkSpace: function() {
      return this.inWorkSpace;
    },

    setInWorkSpace: function(work_space) {
      this.inWorkSpace = work_space;
    },

    showInWorkSpace: function() {
      var moved = Ext.getCmp('app').showWorkSpace(this.getInWorkSpace());
      return moved;
    }
}
