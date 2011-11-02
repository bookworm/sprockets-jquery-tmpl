require 'sprockets/engines'
require 'tilt'  
    
if defined?(Rails)
  require 'action_view'
  require 'action_view/helpers'
  require 'action_view/helpers/javascript_helper'  
end

module Sprockets
  module Jquery
    module Tmpl
      class TmplProcessor < Tilt::Template
        include ActionView::Helpers::JavaScriptHelper if defined?(Rails)           
        include Padrino::Helpers::FormatHelpers if defined?(Padrino)

        def self.default_mime_type
          'application/javascript'
        end

        def prepare
        end

        def evaluate(scope, locals, &block)     
          if defined?(Rails)
            <<-TMPL
(function($) {
  $.template(#{scope.logical_path.gsub(/^tmpls\/(.*)$/i, "\\1").inspect}, "#{escape_javascript data}");
})(jQuery);   
            TMPL
          elsif defined?(Padrino)
            <<-TMPL
(function($) {
  $.template(#{scope.logical_path.gsub(/^tmpls\/(.*)$/i, "\\1").inspect}, "#{js_escape_html data}");
})(jQuery);   
            TMPL
          end
        end
      end
    end
  end
  
  register_engine '.tmpl', ::Sprockets::Jquery::Tmpl::TmplProcessor
end
