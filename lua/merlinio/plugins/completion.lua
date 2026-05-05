return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
        {
            "rafamadriz/friendly-snippets"
        },
    },

    version = "1.*",
    build = "if [ command -v nix  >/dev/null ]; then nix run .#build-plugin; else cargo build --release; fi",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = "default" },

        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },

        completion = { documentation = { auto_show = false }, ghost_text = { enabled = true } },


        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            per_filetype = {
                sql = { "dadbod", "path", "snippets", "buffer" },
            },

            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },

                dadbod = {
                    name = "Dadbod",
                    module = "vim_dadbod_completion.blink",
                },

            },
        },

        fuzzy = {
            implementation = "prefer_rust_with_warning",
            prebuilt_binaries = { download = false },
        },
    },
}
