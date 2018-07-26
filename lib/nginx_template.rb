
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
                client_max_body_size 10M;
                keepalive_timeout 10;
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

