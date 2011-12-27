{
  SampleButtonMenu: new Ext.ButtonGroup({
  title   : 'Sample',
  columns : 3,
  layout  : 'table',
  height  : 80,
  items   : [{
               text       : 'Hierarchy',
               iconCls    : 'icon-hierarchy',
               rowspan    : '2',
               scale      : 'medium',
               arrowAlign : 'bottom',
               iconAlign  : 'top',
               width      : 50,
               menu       : [{text:'pauls menu'}]
             },{
               text       : 'Inclusion',
               iconCls    : 'icon-treatment',
               rowspan    : '2',
               scale      : 'medium',
               arrowAlign : 'bottom',
               iconAlign  : 'top',
               width      : 40,
               menu       : [{
                               text    : 'Sample Inclusion Button Menu',
                               handler : function(){ document.location.href = 'index.cfm?sampleInclusion'; }
               }]
             },{
               iconCls    : 'icon-route',
               tooltip    : 'Route',
               handler    : function(){ document.location.href = 'index.cfm?routeSetup'; }
             },{
               iconCls    : 'icon-bandage',
               tooltip    : 'Access Mapping',
               handler    : function(){ document.location.href = 'index.cfm?accessMapping'; }
             }]
})
}
