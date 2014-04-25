desc 'update all submodules'
task 'update' do
  sh "git submodule foreach git pull origin master"
end

desc 'bootstrap'
task 'bootstrap' do
  sh "/usr/bin/ruby -e \"$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)\""
  sh "brew doctor"
  sh "brew bundle"
  sh "curl -sSL https://get.rvm.io | bash -s stable --ruby=2.1.1"
  sh "curl -L http://install.ohmyz.sh | sh"
end

desc 'link em up'
task 'link' do
  symlink_this('.ackrc')
  symlink_this('.autotest')
  symlink_this('.bin')
  symlink_this('.gemrc')
  symlink_this('.git_template')
  symlink_this('.gitconfig')
  symlink_this('.gitignore-global')
  symlink_this('.gvimrc')
  symlink_this('.hgrc')
  symlink_this('.hgignore-global')
  symlink_this('.irbrc')
  symlink_this('.js')
  symlink_this('.oh-my-zsh/custom/aliases.zsh')
  symlink_this('.oh-my-zsh/custom/ec2.zsh')
  symlink_this('.oh-my-zsh/custom/exports.zsh')
  symlink_this('.oh-my-zsh/custom/functions.zsh')
  symlink_this('.oh-my-zsh/custom/keys.zsh')
  symlink_this('.oh-my-zsh/custom/prompt.zsh')
  symlink_this('.oh-my-zsh/custom/source.zsh')
  symlink_this('.rvmrc')
  symlink_this('.synergy.conf')
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

