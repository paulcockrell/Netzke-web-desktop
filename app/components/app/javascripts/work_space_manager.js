{
  current_work_space: 1,
  work_spaces: [],

  initWorkSpaceManager: function() {
    // load the work space buttons into an array, used for class toggling
    // on user click
    this.work_spaces = [Ext.getCmp('app__work_space_one'),
                        Ext.getCmp('app__work_space_two'),
                        Ext.getCmp('app__work_space_three'),
                        Ext.getCmp('app__work_space_four')];

    // set first workspace icon as active
    this.work_spaces[0].btnEl.toggleClass('active');
  },

  getCurrentWorkSpace: function() {
    return this.current_work_space;
  },

  setCurrentWorkSpace: function(work_space) {
    this.setWorkSpaceIcon(work_space);
    this.current_work_space = work_space;
  },

  // return false if already in current work space, true if a move had to be made
  showWorkSpace: function(to_work_space) {
    // return if we are already viewing the requested work space
    if (this.current_work_space === to_work_space)
        return false;
    
    // get dimensions of desktop
    var panel_dimensions_x = Ext.getCmp('main-panel').getWidth();
    var panel_dimensions_y = Ext.getCmp('main-panel').getHeight();

    // calculate pixels to shift windows
    var shift_amount = Math.abs(this.current_work_space - to_work_space) * panel_dimensions_x;
    
    // calculate direction to shift windows
    var shift_amount = (this.current_work_space < to_work_space) ?
                                shift_amount * -1 :
                                shift_amount;
    
    // itterate through the window manager, ghost everything, then based on the space we are 
    // about to view, subtract/add (panel width * space number) of the windows x pos
    // and then animate to new locations, and reshow!
    Ext.WindowMgr.each( function(item) {
        item.el.moveTo(item.el.getX()+shift_amount, item.el.getY(), true);
    });

    // update the current work space to this one
    this.setCurrentWorkSpace(to_work_space);
    this.alertUser(this.current_work_space);

    return true;
  },
  
  shiftItemToWorkSpace: function(items, to_work_space) {
    // return if we are already viewing the requested work space
    if (this.current_work_space === to_work_space)
        return;
    
    // get dimensions of desktop
    var panel_dimensions_x = Ext.getCmp('main-panel').getWidth();
    var panel_dimensions_y = Ext.getCmp('main-panel').getHeight();

    // calculate pixels to shift windows
    var shift_amount = Math.abs(this.current_work_space - to_work_space) * panel_dimensions_x;
    
    // calculate direction to shift windows
    var shift_amount = (this.current_work_space > to_work_space) ?
                                shift_amount * -1 :
                                shift_amount;
    
    // itterate through the window manager, ghost everything, then based on the space we are 
    // about to view, subtract/add (panel width * space number) of the windows x pos
    // and then animate to new locations, and reshow!
    items.forEach( function(item) {
        item.el.moveTo(item.el.getX()+shift_amount, item.el.getY(), true);
    });
  },

  showWorkSpaceOne: function(work_space) {
    this.showWorkSpace(1);
  },
  
  showWorkSpaceTwo: function(work_space) {
    this.showWorkSpace(2);
  },
  
  showWorkSpaceThree: function(work_space) {
    this.showWorkSpace(3);
  },
  
  showWorkSpaceFour: function(work_space) {
    this.showWorkSpace(4);
  },

  setWorkSpaceIcon: function(work_space) {
    var old_work_space = this.work_spaces[this.current_work_space-1];
    var new_work_space = this.work_spaces[work_space-1];
    old_work_space.btnEl.toggleClass('active');
    new_work_space.btnEl.toggleClass('active');
  }

}
