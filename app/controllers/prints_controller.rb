class PrintsController < ApplicationController

  def index
    our_file = File.new("./responses/out_#{DateTime.now}.txt", 'w')
    our_file.puts("#{params}\n #{headers}\n #{request.body.read}")
    our_file.close
  end
end
