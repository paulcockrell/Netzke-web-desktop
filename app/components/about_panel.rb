class AboutPanel < Netzke::Basepack::Panel
  action :update_html

  js_properties :id   => "app__about",
                :title  => "SimplePanel",
                :height => 250,
                :width  => 200,
                :html => %Q{<p>This is a super hot desktop application written with the following super cool languages and frameworks:<br/></p>
                            <ul><li>Ruby 1.8.7</li><li>Ruby on Rails 3.0.1</li><li>Netzke Gem 0.6.4</li><li>ExtJS 3.0.1</li></ul><br/>
                            <p style="text-align: center">All this hard work was done by Dr Paul Cockrell Esq</p>
                         }
end
