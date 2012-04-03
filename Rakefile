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
  symlink_this('.js')
  symlink_this('.oh-my-zsh/custom')
  symlink_this('.rvmrc')
  symlink_this('.synergy.conf')
  symlink_this('.vim')
  symlink_this('.vimrc')
  symlink_this('.zshenv')
  symlink_this('.zshrc')

  Dir[".sublime/Packages/*"].each do |package|
    symlink_this(package, "Library/Application Support/Sublime Text 2/Packages/#{package.split("/").last}")
  end
end

def symlink_this(source, target = nil)
  target_path = File.join(ENV["HOME"], target || source)
  source_path = File.join(Dir.pwd, source)

  sh "rm -rf \"#{target_path}\""
  sh "ln -s \"#{source_path}\" \"#{target_path}\""
end

