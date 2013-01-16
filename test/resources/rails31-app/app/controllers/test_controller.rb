require 'sample_gem1'
require 'sample_gem2'

class TestController < ApplicationController
  def show
    messages = [
      SampleGem1.test_message,
      SampleGem2.test_message
    ]

    render :text =>  messages.join("\n")
  end
end
