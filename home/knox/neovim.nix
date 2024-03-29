{ pkgs, minimalist-source, ... }:

{
  programs.neovim = 
  let
    minimalist = pkgs.vimUtils.buildVimPlugin {
      name = "minimalist";
      src = minimalist-source;
    };
  in{
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins;
    [ # coc turns vim into an ide
      coc-nvim
      coc-css
      coc-emmet
      coc-git
      coc-highlight
      coc-html
      coc-json
      coc-prettier
      coc-rls
      coc-svelte
      coc-tslint-plugin
      coc-tsserver
      coc-yaml
      coc-yank
      
      # various syntax hilighters
      typescript-vim
      vim-jsx-typescript
      vim-nix
      vim-svelte
      vim-toml
      vim-tsx
      vim-vue

      # pretty colors @w@
      minimalist
    ];

    extraConfig = ''
      syntax on

      set termguicolors
      set number        " line numbers

      set tabstop=2
      set softtabstop=2
      set shiftwidth=2
      set expandtab
      set autoindent
      set copyindent

      " set tabstop etc to 4 for select languages
      au BufEnter,BufNew *.c setlocal ts=4 sts=4 sw=4 " c source
      au BufEnter,BufNew *.h setlocal ts=4 sts=4 sw=4 " c header

      " enable syntax hilighting
      au BufEnter,BufNew *.ts  setlocal filetype=typescript
      au BufEnter,BufNew *.tsx setlocal filetype=typescriptreact

      " fix the godawful default colors for pmenu
      hi Pmenu             ctermbg=1   ctermfg=0   guibg=DarkBlue
      hi PmenuSel          ctermbg=0   ctermfg=242 guibg=Grey40
      hi PmenuThumb        ctermbg=242 ctermfg=0   guibg=White   guifg=Black
      hi RedrawDebugClear  ctermbg=11  ctermfg=0   guibg=Yellow  guifg=Black
      hi NvimInternalError ctermbg=4   ctermfg=9   guibg=DarkRed guifg=Red
      hi Conceal           ctermbg=0   ctermfg=8   guibg=Black   guifg=DarkGray
      hi TabLine           ctermbg=242 ctermfg=15  guibg=Grey40
                         \ cterm=underline gui=underline

      " no more code completion please
      "let b:coc_suggest_disable = 1

      " enable syntax hilight in svelte
      let g:vim_svelte_plugin_use_typescript = 1
    '';
  };
}

