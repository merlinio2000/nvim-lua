local wk = require('which-key')

wk.setup()

wk.register({
    ["<leader>"] = {
        f = { name = "+find" },
        g = { name = "+git" },
        h = { name = '+harpoon' },
        t = { name = '+file tree' },
        v = { name = '+view',
            w = { name = '+workspace' },
            r = { name = '+reference' },
        },
        x = { name = '+trouble' },
    },
    c = { name = '+comment [LSP]' },
    g = { name = '+goto' },
    s = { name = '+saga [LSP]',
        t = { name = '+terminal' },
    },
    ["["] = { name = 'Jump Previous' },
    ["]"] = { name = 'Jump Next' },
})
