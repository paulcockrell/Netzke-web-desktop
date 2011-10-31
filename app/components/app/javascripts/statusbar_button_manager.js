Ext.Window.StatusBarButton = function(item) {
  this._window = item;
  Ext.Window.StatusBarButton.superclass.constructor.call(this, {
          align: 'left',
           text: Ext.util.Format.ellipsis(item.title, 12),
             id: 'btn__'+item.name,
        iconCls: item.iconCls,
        tooltip: item.title
  });
},

Ext.extend(Ext.Window.StatusBarButton, Ext.Button, {
  initComponent: function() {
    Ext.Window.StatusBarButton.superclass.initComponent.call(this);
  },

  onRender: function() {
    Ext.Window.StatusBarButton.superclass.onRender.apply(this, arguments);       

    this.cmenu = new Ext.menu.Menu({
      items: [{
                text: 'Minimize',
                icon: 'images/icons/application_dock_270.png',
                handler: function(){
                    var moved = this._window.showInWorkSpace();
                    if (moved === false)
                      this._window.minimize();
                },
                scope: this,
                disabled: !this._window.minimizable
              }, {
                text: 'Restore',
                icon: 'images/icons/application_resize_actual.png',
                handler: function(){
                    var moved = this._window.showInWorkSpace();
                    if (moved === false) {
                      this._window.showInWorkSpace();
                      this._window.restore();
                      this._window.show();
                    }
                },
                scope: this
              }, {
                text: 'Maximize',
                icon: 'images/icons/application_resize_full.png',
                handler: function(){
                    var moved = this._window.showInWorkSpace();
                    if (moved === false) {
                      this._window.showInWorkSpace();
                      this._window.maximize();
                      this._window.show();
                    }
                },
                scope: this,
                disabled: !this._window.maximizable
              }, '-', {
                text: 'Close',
                icon: 'images/icons/cross_circle_frame.png',
                handler: function() {
                    this._window.close();
                },
                scope: this
              }]
    });
  
    this.el.on('contextmenu', function(e){
      e.stopEvent();
      if (!this.cmenu.el) {
        this.cmenu.render();
      }
      var xy = e.getXY();
      xy[1] -= this.cmenu.el.getHeight();
      this.cmenu.showAt(xy);
    }, this);
  }  
})
