{
  /** Loads a specified component */
  loadChild: function(cmp, options) {
    var windowCount = this.items.getCount(),
        cmpName,
        receivingWindow,
        params;

    options = options || {};

    if (options.newWindow) {
      var lastWindowIndex;
      if (this.items.last().netzkeComponentId===undefined) {
        lastWindowIndex = 0;
      } else {
        lastWindowIndex = parseInt(this.items.last().netzkeComponentId.replace("app__cmp", ""));
      }
      cmpName = "cmp" + (lastWindowIndex + 1);
      var dummyObj = new Ext.Window({id: "app__cmp"+(lastWindowIndex+1), netzkeComponentId: "app__cmp"+(lastWindowIndex+1)});
      this.items.add(dummyObj);
      params = {component: cmp};
      params.config = options.config;
      
      this.loadComponent({name: cmpName, container: 'main-panel' , params: params, callback: function(component) {
        component.netzkeComponentId=component.id;
        component.show();
        if (options.callback) options.callback(component);
      }});
    }
  }
}
