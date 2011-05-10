require File.dirname(__FILE__) + '/model_helper'

class Fact < ActiveRecord::Base
  include ModelHelper
   
  def to_s
    puts "Fact: #{text}"
  end
  
end
