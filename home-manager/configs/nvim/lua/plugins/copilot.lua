return {
    {
        "zbirenbaum/copilot.lua",
        enabled = true,
        event = "BufEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        enabled = true,
        opts = {}
    },
} 
