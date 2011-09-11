plugins_to_keep = [
  "ack.vim",
  "command_t",
  "cucumber",
  "irblack",
  "javascript",
  "nerdtree",
  "nerdcommenter",
  "supertab",
  "unimpaired",
  "zoomwin"
]

(Rake::Task[:default].prerequisites - plugins_to_keep).each{|plugin| skip_vim_plugin(plugin)}

# vim_plugin_task "bufexplorer", "https://github.com/vim-scripts/bufexplorer.zip.git"
vim_plugin_task "tabular", "https://github.com/godlygeek/tabular.git"

