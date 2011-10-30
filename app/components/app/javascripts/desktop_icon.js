Ext.Window.DesktopIcon = function(menu_item, el) {
  this.menu_item = menu_item;
  Ext.Window.DesktopIcon.superclass.constructor.call(this, {
    icon: menu_item.icon,
    text: Ext.util.Format.ellipsis(menu_item.text, 12),
    tooltip: menu_item.text,
    renderTo: el,
    hidden: true,
    cls: 'desktop-icon-text-icon',
    clickEvent: 'dblclick'
  });
},

Ext.extend(Ext.Window.DesktopIcon, Ext.Button, {
  initComponent: function() {
    Ext.Window.DesktopIcon.superclass.initComponent.call(this);
    this.addEvents("dblclick");  
  },

  onDblClick: function()  {
    this.menu_item.handler.call(this.menu_item.scope, this.menu_item, Ext.EventObject)
  },

  onRender: function() {
    Ext.Window.DesktopIcon.superclass.onRender.apply(this, arguments);       
    this.el.on("dblclick", this.onDblClick,  this);
    this.cmenu = new Ext.menu.Menu({
      items: [{
                text: 'Open app',
                handler: function(){
                  this.menu_item.handler.call(this.menu_item.scope, this.menu_item, Ext.EventObject)
                },
                scope: this,
                icon: 'images/icons/application_run.png'
              }, '-', {
                text: 'Remove icon',
                handler: function() {
                  Ext.getCmp('app').handleDestroy(this);
                },
                scope: this,
                icon: 'images/icons/cross_circle.png'
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
}),

Ext.DDProxy = function(id, sGroup, config) {
  Ext.DDProxy.superclass.constructor.call(this, id, sGroup, config);
},
  
Ext.extend(Ext.DDProxy, Ext.dd.DDProxy, {
  startDrag: function(x, y){
    var dragEl = Ext.get(this.getDragEl());
    var el = Ext.get(this.getEl());
    dragEl.applyStyles({
                         border: '',
                         'z-index': 2000
                       });
    var contents = Ext.cloneInnerHTML(el.dom.innerHTML);
    dragEl.removeClass(dragEl.dom.getAttribute('class'))
    dragEl.update(contents);
    dragEl.addClass(el.dom.className);
    dragEl.addClass('dd-proxy');
  }
}),
  
Ext.cloneInnerHTML = function(value) {
  if (value) {
    var PLACE_HOLDER = '_*_*_';
    var regex1 = /id="[^"]*"/;
    var regex2 = /_\*_\*_/;
    var idAttribute;

    while(value.match(regex1))  {
      value = value.replace(regex1, PLACE_HOLDER);
    }
    
    while(value.match(regex2))  {
      value = value.replace(regex2, 'id="' + Ext.id() + '"');
    }
  }
  
  return value;
}
