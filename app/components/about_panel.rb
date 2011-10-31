class AboutPanel < Netzke::Basepack::Panel
  action :update_html

  js_properties :id   => "app__about",
                :title  => "SimplePanel",
                :html => %Q{<p>A fully featured desktop application written with the following languages and frameworks:<br/><br/></p>
                            <ul><li>Ruby 1.8.7</li><li>Ruby on Rails 3.0.1</li><li>Netzke Gem 0.6.4</li><li>ExtJS 3.0.1</li></ul><br/>
                            <p style="text-align: center">Source available on <a href="http://github.com/paulcockrell/Netzke-web-desktop" alt="Netzke web desktop source on GitHub">GitHub</a></p>
                         }
end
