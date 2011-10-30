{
  iconWidth:    85,
  iconHeight:   70,
  iconYPadding: 5,
  iconXPadding: 5,
  iconXStart:   5,
  iconYStart:   25,

  desktopIconStore: new Ext.data.SimpleStore({
    fields: ['id', 'xPos', 'yPos'],
    data: []
  }),

  record: new Ext.data.Record.create({
    fields: [
             {
               name: 'id',
               type: 'string'
             },
             {
               name: 'xPos',
               type: 'int'
             },
             {
               name: 'yPos',
               type: 'int'
             }
            ]
  }),

  initDesktopIconManager: function() {
    paul = this.desktopIconStore;
  },

  addDesktopIconRecordToStore: function(item) {
    this.desktopIconStore.add(new this.record({
      id: item.button.id,
      xPos: item.getX(),
      yPos: item.getY()
    }, item.button.id)
    );
  },

  removeDesktopIconRecordFromStore: function(_id) {
    var record = this.desktopIconStore.getById(_id);
    if (record === null) {
      console.log("couldnt find record with it: "+_id);
      return false;
    }

    this.desktopIconStore.remove(record);
    return true;
  },
  
  createDesktopIcon: function(item) {
    var iconXY = this.calculateNextIconXY(this.desktopIconStore.data.length+1);
    item.desktopIcon = this.container.createChild({tag: 'div'});
    item.desktopIcon.setLeftTop(iconXY[0], iconXY[1]);
    item.desktopIcon.setStyle({position: 'absolute',
                                  width: this.iconWidth+'px'});
    item.desktopIcon.button = new Ext.Window.DesktopIcon(item, item.desktopIcon);
    item.desktopIcon.dd     = new Ext.DDProxy(item.desktopIcon.id, 'icons');

    this.addDesktopIconRecordToStore(item.desktopIcon);
  },
  
  handleDestroy: function(item) {
    item.menu_item.desktopIcon.dd.unreg();
    item.menu_item.desktopIcon.dd.destroy();
    item.menu_item.desktopIcon.removeAllListeners();
    item.menu_item.desktopIcon.remove();
    item.menu_item.desktopIcon.button.destroy();
    
    this.removeDesktopIconRecordFromStore(item.id);
  },

  calculateNextIconXY: function(current_number_of_icons) {
    // get dimensions of desktop and calculate max icons to be created
    var panel_dimensions_x = Ext.getCmp('main-panel').getWidth();
    var panel_dimensions_y = Ext.getCmp('main-panel').getHeight();
    var max_icons_per_column = (panel_dimensions_y / (this.iconHeight+ this.iconXPadding)).toFixed(0);
    var max_icons_per_row    = (panel_dimensions_x / (this.iconWidth + this.iconYPadding)).toFixed(0);
    var current_column = Math.ceil(current_number_of_icons / max_icons_per_column);
    var current_row = Math.ceil(current_number_of_icons - (max_icons_per_column * (current_column - 1)));
    var newX = current_column === 1 ? this.iconXStart : this.iconXStart + ((current_column*(this.iconWidth+this.iconYPadding)) - this.iconWidth);
    var newY = current_row    === 1 ? this.iconYStart : this.iconYStart + ((current_row*(this.iconHeight+this.iconXPadding)) - this.iconHeight);
    var iconXY = [newX, newY];

    return iconXY;
  }
}
