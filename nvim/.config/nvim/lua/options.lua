require "nvchad.options"

-- Set nvim options outside of chadrc
-- Currently it is troublesome to memorize which option is included and not
-- included in core.utils.config.options, it is highliy likely that overlap
-- of settings can occur here.

local function bind_option(options)
  for k, v in pairs(options) do
    if v == true or v == false then
      vim.cmd('set ' .. k)
    else
      vim.cmd('set ' .. k .. '=' .. v)
    end
  end
end

local function load_options()
  local global_local = {
    wildignorecase = true;
    wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**";
    backup = false;
    writebackup = false;

    grepformat = "%f:%l:%c:%m";
    grepprg = 'rg --hidden --vimgrep --smart-case --';

    jumpoptions = "stack";
    showmode = false;
    showbreak = "↳  ";
    listchars = "tab:» ,nbsp:+,trail:·,extends:→,precedes:←";

    swapfile = true;

    shell = "/usr/bin/zsh";
  }

  local bw_local  = {
    colorcolumn = 80;
    concealcursor = "nvc";
  }

  for name, value in pairs(global_local) do
    vim.o[name] = value
  end
  bind_option(bw_local)
end

load_options()
