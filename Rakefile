desc 'bootstrap'
task 'bootstrap' => 'link' do
  # xcode command line tools are installed the first time you try to clone this repo
  #sh "xcode-select --install"

  sh "/usr/bin/ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\""
  sh "brew doctor"
  sh "brew bundle install"
  sh "curl -L http://install.ohmyz.sh | sh"

  # this didn't seem to work...probably something to do with the variable substitution
  #sh "git clone https://github.com/denysdovhan/spaceship-prompt.git \"$ZSH_CUSTOM/themes/spaceship-prompt\""
  #sh "ln -s \"$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme\" \"$ZSH_CUSTOM/themes/spaceship.zsh-theme\""

  sh "git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell"

  # python support needed for ultisnips in neovim
  sh "sudo python -m ensurepip --default-pip"
  sh "python -m pip install --user --upgrade pynvim"

  sh "nodenv install 10.16.3 && nodenv global 10.16.3"
end

desc 'link em up'
task 'link' do
  sh "mkdir -p ~/.config ~/.ssh"
  symlink_this('.bash_profile')
  symlink_this('.config/nvim')
  symlink_this('.gemrc')
  symlink_this('.git_template')
  symlink_this('.gitconfig')
  symlink_this('.gitignore-global')
  symlink_this('.irbrc')
  symlink_this('.ssh/config')
  symlink_this('.tmux.conf')
  symlink_this('.tmuxline.conf')
  symlink_this('.vim')
  symlink_this('.vimrc')
  symlink_this('.zshenv')
  symlink_this('.zshrc')
  symlink_this('Brewfile')
end

def symlink_this(source, target = nil)
  target_path = File.join(ENV["HOME"], target || source)
  source_path = File.join(Dir.pwd, source)

  sh "rm -rf \"#{target_path}\""
  sh "ln -s \"#{source_path}\" \"#{target_path}\""
end

