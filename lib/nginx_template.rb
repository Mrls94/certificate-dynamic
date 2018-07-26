
class NginxTemplate
  attr_reader :domain

  home_path = '/home/ubuntu/'

  def initialize(domain)
    @domain = domain
  end

  def template
    ERB.new("
              server {
                listen 443;
                ssl on;
                ssl_certificate /home/ubuntu/ssl/#{domain}/#{@domain}.pem;
                ssl_certificate_key /home/ubuntu/ssl/#{domain}/#{@domain}.key;
                server_name #{@domain};
                root ~/coverapps;
                index index.html
                access_log off;
                error_log #{ENV['HOME']}/ask_method/output_app/log/nginx.error.log info;
                error_page 500 502 503 504 /500.html;
                client_max_body_size 10M;
                keepalive_timeout 10;
                location / {
                  try_files $uri $uri/ @prerender;
                }
                include #{ENV['HOME']}/ask_method/output_app/dist/configurations/prerender/prerender.conf;
                location @prerender {
                  include #{ENV['HOME']}/ask_method/output_app/dist/configurations/prerender/helper.conf;
                  rewrite .* /index.html break;
                }
              }
            "
          )
  end

  def build
    template.result
  end

  def save_to(file)
    File.open(file, "w+") do |f|
      f.write(build)
    end
  end
end

