return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        hls = {
          cmd = { "haskell-language-server-wrapper", "--lsp" },
          filetypes = { "haskell", "lhaskell" },
          root_dir = require('lspconfig.util').root_pattern("*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml"),
          settings = {
            haskell = {
              checkProject = true,
              formattingProvider = "ormolu",
              checkParents = "CheckOnSave",
            }
          }
        }
      }
    }
  }
}
