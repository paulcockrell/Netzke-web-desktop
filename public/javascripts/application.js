// Websocket connector
if ("WebSocket" in window) {
  ws = new WebSocket("ws://localhost:8080");
  
  ws.onmessage = function(evt) {
    var message = evt.data.evalJSON(true);
    var el = Ext.getCmp(message['element_id']);
    if (message['return_code'] == 1 || message['return_code'] == 3)
      el.store.reload();
    el.getEl().unmask();
    ws.showmessage(message['message']);
  };
  
  ws.onclose = function() { 
    console.log("socket closed");
  };
  
  ws.onopen = function() {
    console.log("connected...");
  };
  
  ws.showmessage = function(message) {
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
} else {
  alert("You browser has not got, or does not support 'WebSockets'. This will mean not all the functionaily required to run the desktop is present.");
}

String.prototype.toTitleCase = function()
{
    return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1);});
};
