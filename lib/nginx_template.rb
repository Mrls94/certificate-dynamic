
class NginxTemplate
  attr_reader :domain

  def initialize(domain)
    @domain = domain
  end

  def template
    ERB.new("
              server {
                listen 443;
                ssl on;
                ssl_certificate /etc/ssl/#{@domain}.pem;
                ssl_certificate_key /etc/ssl/#{@domain}.key;
                server_name #{@domain};
                root #{ENV['HOME']}/ask_method/output_app/dist;
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

