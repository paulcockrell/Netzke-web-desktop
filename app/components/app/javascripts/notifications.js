 /**
 * Ext.ux.ToastWindow
 *
 * @author  Edouard Fattal
 * @date	March 14, 2008
 *
 * @class Ext.ux.ToastWindow
 * @extends Ext.Window
 */
Ext.namespace("Ext.ux"),


Ext.ux.NotificationMgr = {
	notifications: [],
    originalBodyOverflowY: null
},

Ext.ux.Notification = Ext.extend(Ext.Window, {
	initComponent: function(){
		Ext.apply(this, {
			iconCls: this.iconCls || 'x-icon-information',
			cls: 'x-notification',
			width: 200,
			autoHeight: true,
			plain: false,
			draggable: false,
 		        shadow: false,
			bodyStyle: 'text-align:center'
		});
		if(this.autoDestroy) {
			this.task = new Ext.util.DelayedTask(this.hide, this);
		} else {
			this.closable = true;
		}
		Ext.ux.Notification.superclass.initComponent.apply(this);
	},
	setMessage: function(msg){
		this.body.update(msg);
	},
	setTitle: function(title, iconCls){
		Ext.ux.Notification.superclass.setTitle.call(this, title, iconCls||this.iconCls);
	},
	onRender:function(ct, position) {
		Ext.ux.Notification.superclass.onRender.call(this, ct, position);
	},
	onDestroy: function(){
		Ext.ux.NotificationMgr.notifications.remove(this);
		Ext.ux.Notification.superclass.onDestroy.call(this);
	},
	cancelHiding: function(){
		this.addClass('fixed');
		if(this.autoDestroy) {
			this.task.cancel();
		}
	},
	afterShow: function(){
		Ext.ux.Notification.superclass.afterShow.call(this);
		Ext.fly(this.body.dom).on('click', this.cancelHiding, this);
		if(this.autoDestroy) {
			this.task.delay(this.hideDelay || 5000);
	   }
	},
	animShow: function(){
        if (Ext.ux.NotificationMgr.originalBodyOverflowY == null)
        {
            Ext.ux.NotificationMgr.originalBodyOverflowY = document.body.style.overflowY;
        }
        if (document.body.clientHeight == document.body.scrollHeight)
        {
            document.body.style.overflowY = 'hidden';
        }

        this.setSize(200,100);
        pos = -50;

        for (var i = 0; i < Ext.ux.NotificationMgr.notifications.length; i++)
        {
            pos -= Ext.ux.NotificationMgr.notifications[i].getSize().height + 15;
        }
		Ext.ux.NotificationMgr.notifications.push(this);
		this.el.alignTo(document.body, "br-br", [ -20, pos ]);
		this.el.slideIn('b', {
			duration: 1,
			callback: this.afterShow,
			scope: this
		});
	},
	animHide: function(){
		this.el.ghost("b", {
			duration: 1,
			remove: false,
            callback: function() {
            Ext.ux.NotificationMgr.notifications.remove(this);
            if (Ext.ux.NotificationMgr.notifications.length == 0)
            {
                document.body.style.overflowY = Ext.ux.NotificationMgr.originalBodyOverflowY;
            }
            this.destroy();
            }.createDelegate(this)
		});
	},
	focus: Ext.emptyFn 

}),

Ext.Ajax.request({
  url: '/notify.wav',
  method: 'GET'
})
