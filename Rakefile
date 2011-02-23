desc 'link em up'
task 'link' do
  symlink('.ackrc')
  symlink('.autotest')
  symlink('.gemrc')
  symlink('.gitconfig')
  symlink('.gitignore-global')
  symlink('.gvimrc.local')
  symlink('.irbrc')
  symlink('.vimrc.local')
  symlink('.zsh')
  symlink('.zshenv')
  symlink('.zshrc')
end

def symlink(f)
  home_path = File.join(ENV["HOME"], f)
  remote_path = File.join(Dir.pwd, f)

  sh "rm -rf #{home_path}"
  sh "ln -s #{remote_path} #{home_path}"
end

