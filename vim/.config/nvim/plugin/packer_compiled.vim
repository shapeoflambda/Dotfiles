" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/Users/chndha/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/chndha/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/chndha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/chndha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/chndha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ["ayu-vim"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/ayu-vim"
  },
  ["dark-purple.vim"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/dark-purple.vim"
  },
  fzf = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n∆\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fkeymaps\1\0\0\1\0\5\fnoremap\2\nn ,gu!<cmd>Gitsigns reset_hunk<CR>\tn [g <cmd>Gitsigns prev_hunk<CR>\vbuffer\2\tn ]g <cmd>Gitsigns next_hunk<CR>\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n„\4\0\0\a\0 \00056\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\v\0004\4\3\0005\5\n\0>\5\1\4=\4\f\0034\4\3\0005\5\r\0>\5\1\4=\4\14\0034\4\3\0005\5\15\0005\6\16\0=\6\17\5>\5\1\4=\4\18\0035\4\19\0=\4\20\0034\4\3\0005\5\21\0>\5\1\4=\4\22\0035\4\23\0=\4\24\3=\3\25\0025\3\26\0004\4\0\0=\4\f\0034\4\0\0=\4\14\0035\4\27\0=\4\18\0035\4\28\0=\4\20\0034\4\0\0=\4\22\0034\4\0\0=\4\24\3=\3\29\0025\3\30\0=\3\31\2B\0\2\1K\0\1\0\15extensions\1\2\0\0\bfzf\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\1\0\vbranch\ticon\bÓÇ†\14lualine_x\1\3\0\0\rencoding\rfiletype\14lualine_c\fsources\1\2\0\0\rnvim_lsp\1\2\0\0\16diagnostics\14lualine_b\1\2\1\0\rfilename\16file_status\2\14lualine_a\1\0\0\1\2\1\0\tmode\nupper\2\foptions\1\0\0\25component_separators\1\3\0\0\5\5\23section_separators\1\3\0\0\5\5\1\0\2\ntheme\15ayu_mirage\18icons_enabled\2\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n¡\1\0\0\4\0\t\0\0286\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0014\3\0\0B\1\2\0019\1\4\0009\1\3\0014\3\0\0B\1\2\0019\1\5\0009\1\3\0014\3\0\0B\1\2\0019\1\6\0009\1\3\0014\3\0\0B\1\2\0019\1\a\0009\1\3\0014\3\0\0B\1\2\0019\1\b\0009\1\3\0014\3\0\0B\1\2\1K\0\1\0\rtsserver\18rust_analyzer\ngopls\nvimls\vbashls\nsetup\fpyright\14lspconfig\frequire\0" },
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n≈\2\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\2B\0\2\1K\0\1\0\16action_keys\1\0\0\16toggle_fold\1\3\0\0\azA\aza\15open_folds\1\3\0\0\azR\azr\16close_folds\1\3\0\0\azM\azm\15jump_close\1\2\0\0\6o\tjump\1\3\0\0\t<cr>\n<tab>\1\0\t\nhover\6K\19toggle_preview\6P\16toggle_mode\6m\rprevious\a[q\frefresh\6r\vcancel\n<esc>\tnext\a]q\nclose\6q\fpreview\6p\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-cool"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/vim-cool"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n|\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\fplugins\1\0\0\rspelling\1\0\0\1\0\2\fenabled\2\16suggestions\3\20\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/Users/chndha/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time("Defining packer_plugins", false)
-- Config for: which-key.nvim
time("Config for which-key.nvim", true)
try_loadstring("\27LJ\2\n|\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\fplugins\1\0\0\rspelling\1\0\0\1\0\2\fenabled\2\16suggestions\3\20\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time("Config for which-key.nvim", false)
-- Config for: nvim-lspconfig
time("Config for nvim-lspconfig", true)
try_loadstring("\27LJ\2\n¡\1\0\0\4\0\t\0\0286\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0014\3\0\0B\1\2\0019\1\4\0009\1\3\0014\3\0\0B\1\2\0019\1\5\0009\1\3\0014\3\0\0B\1\2\0019\1\6\0009\1\3\0014\3\0\0B\1\2\0019\1\a\0009\1\3\0014\3\0\0B\1\2\0019\1\b\0009\1\3\0014\3\0\0B\1\2\1K\0\1\0\rtsserver\18rust_analyzer\ngopls\nvimls\vbashls\nsetup\fpyright\14lspconfig\frequire\0", "config", "nvim-lspconfig")
time("Config for nvim-lspconfig", false)
-- Config for: lualine.nvim
time("Config for lualine.nvim", true)
try_loadstring("\27LJ\2\n„\4\0\0\a\0 \00056\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\v\0004\4\3\0005\5\n\0>\5\1\4=\4\f\0034\4\3\0005\5\r\0>\5\1\4=\4\14\0034\4\3\0005\5\15\0005\6\16\0=\6\17\5>\5\1\4=\4\18\0035\4\19\0=\4\20\0034\4\3\0005\5\21\0>\5\1\4=\4\22\0035\4\23\0=\4\24\3=\3\25\0025\3\26\0004\4\0\0=\4\f\0034\4\0\0=\4\14\0035\4\27\0=\4\18\0035\4\28\0=\4\20\0034\4\0\0=\4\22\0034\4\0\0=\4\24\3=\3\29\0025\3\30\0=\3\31\2B\0\2\1K\0\1\0\15extensions\1\2\0\0\bfzf\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\1\0\vbranch\ticon\bÓÇ†\14lualine_x\1\3\0\0\rencoding\rfiletype\14lualine_c\fsources\1\2\0\0\rnvim_lsp\1\2\0\0\16diagnostics\14lualine_b\1\2\1\0\rfilename\16file_status\2\14lualine_a\1\0\0\1\2\1\0\tmode\nupper\2\foptions\1\0\0\25component_separators\1\3\0\0\5\5\23section_separators\1\3\0\0\5\5\1\0\2\ntheme\15ayu_mirage\18icons_enabled\2\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time("Config for lualine.nvim", false)
-- Config for: trouble.nvim
time("Config for trouble.nvim", true)
try_loadstring("\27LJ\2\n≈\2\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\2B\0\2\1K\0\1\0\16action_keys\1\0\0\16toggle_fold\1\3\0\0\azA\aza\15open_folds\1\3\0\0\azR\azr\16close_folds\1\3\0\0\azM\azm\15jump_close\1\2\0\0\6o\tjump\1\3\0\0\t<cr>\n<tab>\1\0\t\nhover\6K\19toggle_preview\6P\16toggle_mode\6m\rprevious\a[q\frefresh\6r\vcancel\n<esc>\tnext\a]q\nclose\6q\fpreview\6p\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time("Config for trouble.nvim", false)
-- Config for: gitsigns.nvim
time("Config for gitsigns.nvim", true)
try_loadstring("\27LJ\2\n∆\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fkeymaps\1\0\0\1\0\5\fnoremap\2\nn ,gu!<cmd>Gitsigns reset_hunk<CR>\tn [g <cmd>Gitsigns prev_hunk<CR>\vbuffer\2\tn ]g <cmd>Gitsigns next_hunk<CR>\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time("Config for gitsigns.nvim", false)
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
