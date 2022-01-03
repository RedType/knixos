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
      coc-tslint-plugin
      coc-tsserver
      coc-yank
      
      # various syntax hilighters
      typescript-vim
      vim-jsx-typescript
      vim-nix
      vim-toml
      vim-tsx

      # pretty colors @w@
      minimalist
    ];

    extraConfig = ''
      syntax on

      set termguicolors
      set number        " line numbers

      set tabstop=4
      set softtabstop=4
      set shiftwidth=4
      set expandtab
      set autoindent
      set copyindent

      " set tabstop etc to 2 for select languages
      au BufEnter,BufNew *.hs  setlocal ts=2 sts=2 sw=2 " haskell
      au BufEnter,BufNew *.nix setlocal ts=2 sts=2 sw=2 " nix
      au BufEnter,BufNew *.js  setlocal ts=2 sts=2 sw=2 " javascript
      au BufEnter,BufNew *.jsx setlocal ts=2 sts=2 sw=2
      au BufEnter,BufNew *.ts  setlocal ts=2 sts=2 sw=2 " typescript
      au BufEnter,BufNew *.tsx setlocal ts=2 sts=2 sw=2
      au BufEnter,BufNew *.rs  setlocal ts=2 sts=2 sw=2 " rust

      " enable syntax hilighting for react
      au BufEnter,BufNew *.ts  setlocal filetype=typescript
      au BufEnter,BufNew *.tsx setlocal filetype=typescriptreact

      " fix the godawful default colors for pmenu
      hi Pmenu      ctermfg=0   ctermbg=1 guibg=DarkBlue
      hi PmenuSel   ctermfg=242 ctermbg=0 guibg=Grey40
      hi PmenuThumb ctermfg=0 ctermbg=242 guifg=Black guibg=White
      hi TabLine    cterm=underline ctermfg=15 ctermbg=242 gui=underline guibg=Grey40
      hi RedrawDebugClear ctermbg=11 ctermfg=0 guibg=Yellow guifg=Black
      hi NvimInternalError ctermfg=9 ctermbg=4 guifg=Red guibg=DarkRed
      hi Conceal    ctermbg=0 ctermfg=8 guibg=Black guifg=DarkGray

      " no more code completion please
      let b:coc_suggest_disable = 1
    '';
  };
}

