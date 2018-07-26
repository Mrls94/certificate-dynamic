module SaveFile
  require 'fileutils'
  home_folder = '/home/ubuntu'

  def save_text_to(text:, file_path:)
    File.open(file_path, 'w+') do |f|
      f.write(text)
    end
  end

  def create_ssl_folder(domain)
    create_folder("#{home_folder}/ssl/#{domain}")
  end

  private

  def create_folder(folder_path)
    FileUtils::mkdir_p folder_path
  end
end
