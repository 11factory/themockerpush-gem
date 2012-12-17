require 'themockerpush/themockerpush_active_resource'

module Themockerpush
  class Notification < ThemockerpushActiveResource
    
    alias_method :original_save, :save
    
    def push
      save
    end
  end
end