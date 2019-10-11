desc 'bootstrap'
task 'bootstrap' => 'link' do
  sh "xcode-select --install"
  sh "/usr/bin/ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\""
  sh "brew doctor"
  sh "brew bundle install"
  sh "curl -L http://install.ohmyz.sh | sh"
  sh "git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell"
  echo "install snappy, xscope, soulver, pixelmator from mas"
end

desc 'link em up'
task 'link' do
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

