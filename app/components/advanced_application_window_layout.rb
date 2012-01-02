class AdvancedApplicationWindowLayout < Netzke::Basepack::BorderLayoutPanel

  include AdvancedApplicationWindowLayoutHelper

  def configuration
    super.merge(
      :header => false,
      :border => false,
      :tbar   => [{
                    :xtype => 'buttongroup',
                    :title   => 'Sample jobs',
                    :columns => 3,
                    :layout  => 'table',
                    :height  => 80,
                    :items   => [{
                                 :text       => 'Job 1',
                                 :iconCls    => 'icon-job-1',
                                 :rowspan    => '2',
                                 :scale      => 'medium',
                                 :arrowAlign => 'bottom',
                                 :iconAlign  => 'top',
                                 :width      => 50,
                                 :menu       => [{
                                                   :text    => 'Backup emails',
                                                   :iconCls => 'icon-execute-job-1',
                                                   :handler => :on_long_running_job,
                                                   :data    => {:sleep_for => 7, :job_label => "Backup emails"}
                                                }]
                               },{
                                 :text       => 'Job 2',
                                 :iconCls    => 'icon-job-2',
                                 :rowspan    => '2',
                                 :scale      => 'medium',
                                 :arrowAlign => 'bottom',
                                 :iconAlign  => 'top',
                                 :width      => 40,
                                 :menu       => [{
                                                   :text    => 'Backup Google servers',
                                                   :iconCls => 'icon-execute-job-2',
                                                   :handler => :on_long_running_job,
                                                   :data    => {:sleep_for => 30, :job_label => "Backup Google servers"}
                                                }]
                               },{
                                 :iconCls    => 'icon-job-3',
                                 :tooltip    => 'Job 3 - Execute 30 second job'
                               },{
                                 :iconCls    => 'icon-job-4',
                                 :tooltip    => 'Job 4 - Execute 60 second job'
                               }]
                 }],
      :items => [ 
        {
          :name => "details",
          :class_name => "Netzke::Basepack::Panel",
          :region => :east,
          :title  => "Details",
          :width => 250,
          :split => true
        },
        {
          :name => "advanced_window_tree",
          :class_name => "AdvancedWindowTree",
          :region => :center,
          :title => "Job history",
        }
      ]
    )
  end

  endpoint :select_item do |params|
    # store selected location id in the session for this component's instance
    component_session[:item_type] = params[:item_type]
    component_session[:item_id]   = params[:item_id]
   
    # selected node
    unless params[:item_type].nil?
      item = case params[:item_type]
               when 'node'
                 Job.find(params[:item_id])
               when 'tree'
                 Infrastructure.find(params[:item_id])
               else
                 Job.find(params[:item_id])
             end
    end

    {
      :details => {:update_body_html => params[:item_type] == 'node' ? job_info_html(item) : infrastructure_info_html(item), :set_title => "#{item.label} details"}
    }
  end
 
  def infrastructure_details(item)
    infrastructure_info_html(item)
  end

  def node_details(item)
    node_info_html(item)
  end

  # Overriding initComponent
  js_method :init_component, <<-JS
    function(){
      // calling superclass's initComponent
      #{js_full_class_name}.superclass.initComponent.call(this);
  
      // setting the 'rowclick' event
      this.getChildComponent('advanced_window_tree').on('click', this.onItemSelectionChanged, this);
    }
  JS
  
  # Event handler
  js_method :on_item_selection_changed, <<-JS
    function(self, rowIndex){
      var tree_object = self.id.split("-");
      var item_type = tree_object[0];
      var item_id   = tree_object[1];
      this.selectItem({item_id: item_id, item_type: item_type});
    }
  JS

  js_method :on_long_running_job, <<-JS
    function(self){
      var sleep_for = self.data.sleepFor;
      var job_label = self.data.jobLabel;
      this.getEl().mask('Processing...','loadingMask');
      this.longRunningJob({el_id: this.id, sleep_for: sleep_for, job_label: job_label}, function(result) {}, this);
    }
  JS
  
  endpoint :long_running_job do |params|
    # pass a code representing the origin of the message,
    # so when the job is completed, and the message returned
    # with the same code via websockets, we know which 
    # window to update etc
    el_id     = params[:el_id]
    sleep_for = params[:sleep_for]
    job_label = params[:job_label]
    Delayed::Job.enqueue LongRunningJob.new(:return_code => :success_reload,
                                            :element_id  => el_id,
                                            :sleep_for   => sleep_for,
                                            :job_label   => job_label)
  end

end
