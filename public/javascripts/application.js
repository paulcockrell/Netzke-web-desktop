document.observe("dom:loaded", function() {
  console.log("Establishing connection to Faye");
  var faye = new Faye.Client('http://localhost:9292/faye');
  faye.subscribe("/messages/new", function(data) {
    onMessage(data);
  });
});


var onMessage = function(data) {
  console.log(":: Received message");
  var el = Ext.getCmp(data['element_id']);
  if (el) {
    if (data['return_code'] == 1 || data['return_code'] == 3) {
      var panels_count = el.items.length;
      var panel = null;
      for (var i=0; i < panels_count; i++) {
        panel = el.items.get(i);
        console.log(panel);
        if (panel.store !== undefined) {
          // reload regular component data
          panel.store.reload();
        } else if (panel.getRootNode !== undefined) {
          // reload tree data
          panel.getRootNode().reload();
        } else {
          // do nothing
        }
      }
    }
    el.getEl().unmask();
  }

  showMessage(data['message']);
};

var showMessage = function(message) {
  new Ext.ux.Notification({
    iconCls:    'x-icon-error',
    title:      'System message',
    html:       message,
    autoDestroy: true,
    hideDelay:   5000,
    listeners: {
      'beforerender': function(){
        Sound.enable();
        Sound.play('notify.wav');
        Sound.disable();
      }
    }
  }).show(document);
};

String.prototype.toTitleCase = function()
{
    return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1);});
};

