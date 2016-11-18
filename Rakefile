desc 'bootstrap'
task 'bootstrap' do
  # Install xcode from App Store
  # sh "xcode-select --install"
  sh "/usr/bin/ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\""
  sh "brew doctor"
  sh "brew tap Homebrew/brewdler"
  sh "brew brewdle"
  sh "curl -sSL https://get.rvm.io | bash -s stable --ruby=2.2.1"
  sh "curl -L http://install.ohmyz.sh | sh"
end

desc 'link em up'
task 'link' do
  symlink_this('.ackrc')
  symlink_this('.bash_profile')
  symlink_this('.bin')
  symlink_this('.curlrc')
  symlink_this('.gemrc')
  symlink_this('.git_template')
  symlink_this('.gitconfig')
  symlink_this('.gitignore-global')
  symlink_this('.gvimrc')
  symlink_this('.irbrc')
  symlink_this('.oh-my-zsh/custom/aliases.zsh')
  symlink_this('.oh-my-zsh/custom/base16.zsh')
  symlink_this('.oh-my-zsh/custom/exports.zsh')
  symlink_this('.oh-my-zsh/custom/functions.zsh')
  symlink_this('.oh-my-zsh/custom/keys.zsh')
  symlink_this('.oh-my-zsh/custom/prompt.zsh')
  symlink_this('.oh-my-zsh/custom/source.zsh')
  symlink_this('.tmux.conf')
  symlink_this('.tmuxline.conf')
  symlink_this('.vim')
  symlink_this('.vimrc')
  symlink_this('.zshenv')
  symlink_this('.zshrc')
end

def symlink_this(source, target = nil)
  target_path = File.join(ENV["HOME"], target || source)
  source_path = File.join(Dir.pwd, source)

  sh "rm -rf \"#{target_path}\""
  sh "ln -s \"#{source_path}\" \"#{target_path}\""
end

