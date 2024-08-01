return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      solargraph = {
        cmd = {
          "bundle",
          "exec",
          "solargraph",
          "stdio",
        },
      },
    },
  },
}
