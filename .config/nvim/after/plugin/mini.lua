require('mini.ai').setup();
require('mini.cursorword').setup();
require('mini.indentscope').setup({
  draw = {
    animation = require('mini.indentscope').gen_animation.none(),
  },
})
