{
    updateStatusButtons: function() {
        // get the status bar object
        var sbar = Ext.getCmp('main-statusbar');
        
        // clear current buttons
        var x = sbar.items.items.slice();
        var sbar_items_length = sbar.items.length;
        for (var i = sbar_items_length-3; i > 0; i--){
            if (sbar.items.get(i-1)) {
                var item = sbar.items.get(i-1);
                sbar.remove(item);
            }
        }
        
        var that = this;
        var button = null;
        Ext.WindowMgr.each( function(item) {
          var button = new Ext.Window.StatusBarButton(item);
          sbar.insert(sbar.items.length-3, button);
          item.associatedButton=button;
            
          button.on("click", function(){
            var current_work_space = Ext.getCmp('app').getCurrentWorkSpace();
            var item_work_space    = item.getInWorkSpace();

            if (item_work_space != current_work_space) {
              Ext.getCmp('app').showWorkSpace(item_work_space);              
            } else if (item.isMinimized===false && item.id != Ext.WindowMgr.getActive().id) {
              Ext.WindowMgr.bringToFront(item);
            } else if (item.isMinimized===false && item.minimizable) {
              item.doMinimize();
            } else if (item.isMinimized===true && item.minimizable) {
              item.doRestore();
            }
            
          });
        });

        // redraw the status bar!
        sbar.doLayout();
    }

}
