local global = {}
local home = os.getenv("HOME")
local path_sep = global.is_windows and '\\' or '/'
local os_name = vim.loop.os_uname().sysname

function global:get_hostname()
  local f = io.popen ("/bin/hostname")
  local hostname = f:read("*a") or ""
  f:close()
  hostname =string.gsub(hostname, "\n$", "")
  return hostname
end

function global:get_env_context()
  env_context = os.getenv("META_IMAGEREF")
  if (env_context == nil or env_context == '') then
    return global:get_hostname()
  else
    return env_context
  end
end  

function global:set_linenumber(option)
  if (option == 'relative') then
    vim.wo.number = true
    vim.wo.relativenumber = true
  elseif (option == 'on') then
    vim.wo.number = true
    vim.wo.relativenumber = false
  elseif (option == 'off') then
    vim.wo.number = false
    vim.wo.relativenumber = false
  end
end

function global:load_variables()
  self.is_mac = os_name == 'Mac'
  self.is_linux = os_name == 'Linux'
  self.is_windows = os_name == 'Windows'
  self.vim_path = vim.fn.stdpath('config')
  self.cache_dir = home..path_sep..'.cache'..path_sep..'nvim'..path_sep
  self.modules_dir = self.vim_path..path_sep..'modules'
  self.path_sep = path_sep
  self.home = home
  self.data_dir = string.format('%s/site/',vim.fn.stdpath('data'))
  self.hostname = global:get_hostname()
  self.env_context = global:get_env_context()
end

global:load_variables()

return global
