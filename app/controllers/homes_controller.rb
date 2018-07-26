class HomesController < ApplicationController
  include SaveFile
  file_path_saves = '/home/ubuntu/conf.d/'.freeze

  def hello
  end

  def create
    domain = params[:domain]
    certificate = params[:certificate]
    public_key = params[:public_key]

    folder = create_ssl_folder(domain)

    save_text_to(text: certificate, file_path: "#{folder}/#{domain}.pem")
    save_text_to(text: public_key, file_path: "#{folder}/#{domain}.key")

    @nginx = NginxTemplate.new(domain).build
    save_text_to(text: @nginx, file_path: "#{file_path_saves}/#{domain}.conf")
    render :hello
  end
end
