module Sprockets
  module Jquery
    module Tmpl    
      module App
        def self.registered(app)     
          app.sprockets.append_path(File.expand_path('../../../../../app/assets/javascripts', __FILE__)) 
        end      
      end
    end
  end
end