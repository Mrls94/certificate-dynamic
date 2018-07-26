class HomesController < ApplicationController
  include SaveFile
  file_path_saves = '/home/ubuntu/conf.d/'.freeze

  def hello
  end

  def create
    domain = params[:domain]
    certificate = params[:certificate]
    public_key = params[:public_key]

    create_ssl_folder(domain).to_s

    save_text_to(text: certificate, file_path: "/home/ubuntu/ssl/#{domain}/#{domain}.pem")
    save_text_to(text: public_key, file_path: "/home/ubuntu/ssl/#{domain}/#{domain}.key")

    @nginx = NginxTemplate.new(domain).build
    save_text_to(text: @nginx, file_path: "/home/ubuntu/conf.d/#{domain}.conf")
    render :hello
  end
end
