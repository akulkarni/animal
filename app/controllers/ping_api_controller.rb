class PingApiController < ApplicationController

  def ok
    render :text => 'OK!'
  end

  def index
    return ok
  end

  def new
    d = Date.today()
    @today = d.strftime('%a %m/%d')
    
    @times = []
    (7..22).each do |h|
      t = Time.new(d.year, d.month, d.day, h)
      @times.push(t.strftime('%l %p'))
    end

  end

end
