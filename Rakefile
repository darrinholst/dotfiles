desc 'link em up'
task 'link' do
  symlink('.ackrc')
  symlink('.autotest')
  symlink('.gemrc')
  symlink('.gitconfig')
  symlink('.gitignore-global')
  symlink('.gvimrc.local')
  symlink('.irbrc')
  symlink('.rake_complete.rb')
  symlink('.vimrc.local')
  symlink('.zsh')
  symlink('.zshenv')
  symlink('.zshrc')
end

def symlink(f)
  home_path = File.join(ENV["HOME"], f)
  remote_path = File.join(Dir.pwd, f)

  exec "rm -rf #{home_path}"
  exec "ln -s #{remote_path} #{home_path}"
end

def exec(command)
  sh(command)
end
