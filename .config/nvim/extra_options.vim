" extra_options.vim

let g:python3_host_prog = "/usr/local/bin/python3"

" {{{ nvim-treesitter configuration

if has("nvim-0.5.0")
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp", "python", "vim", "lua"},
  auto_install = true,
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
  },
}
EOF
end

" }}}
