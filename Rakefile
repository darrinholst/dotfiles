desc 'link em up'
task 'link' do
  symlink_this('.ackrc')
  symlink_this('.autotest')
  symlink_this('.bin')
  symlink_this('.gemrc')
  symlink_this('.gitconfig')
  symlink_this('.gitignore-global')
  symlink_this('.gvimrc')
  symlink_this('.irbrc')
  symlink_this('.oh-my-zsh/custom')
  symlink_this('.synergy.conf')
  symlink_this('.vim')
  symlink_this('.vimrc')
  symlink_this('.zshenv')
  symlink_this('.zshrc')
end

def symlink_this(f)
  home_path = File.join(ENV["HOME"], f)
  remote_path = File.join(Dir.pwd, f)

  sh "rm -rf #{home_path}"
  sh "ln -s #{remote_path} #{home_path}"
end

