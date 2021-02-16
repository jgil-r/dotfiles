local builtin = require('el.builtin')
local extensions = require('el.extensions')
local sections = require('el.sections')
local subscribe = require('el.subscribe')

local git_branch = subscribe.buf_autocmd(
  "el_git_branch",
  "BufEnter",
  function(window, buffer)
    local branch = extensions.git_branch(window, buffer)
    if branch then
      return ' ' .. branch
    end
  end
)

require('el').setup {
  generator = function(_, _)
    return {
      extensions.gen_mode {
        format_string = ' %s '
      },
      git_branch,
      ' ',
      sections.split,
      builtin.tail_file,
      sections.split,
      builtin.line, '/', builtin.number_of_lines,  ':', builtin.column, ' ',
      builtin.filetype,
    }
  end
}
