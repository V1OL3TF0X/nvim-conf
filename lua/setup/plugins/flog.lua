return {
    "rbong/vim-flog",
    cmd = { "Flog", "Flogsplit", "Floggit" },
    keys = { { '<leader>gg', vim.cmd.Flogsplit } },
    dependencies = {
        "tpope/vim-fugitive",
    },
};
