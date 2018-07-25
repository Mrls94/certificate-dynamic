class HomesController < ApplicationController
  def hello
  end

  def create
    @nginx = NginxTemplate.new(params[:domain]).build
    render :hello
  end
end
