return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.8",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({
            defaults = {
                results_title = false,
                sorting_strategy = "ascending",
                layout_strategy = "center",
                layout_config = {
                    preview_cutoff = 1, -- Preview should always show (unless previewer = false)
                    width = function(_, max_columns, _)
                        return math.min(max_columns, 120)
                    end,
                    height = function(_, _, max_lines)
                        return math.min(max_lines, 15)
                    end,
                },
                border = true,
                borderchars = {
                    prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
                    results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
                    preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                },
            }
        })

        local builtin = require('telescope.builtin')
        local is_inside_work_tree = {}

        vim.keymap.set('n', '<C-p>', function()
            local cwd = vim.fn.getcwd()
            if is_inside_work_tree[cwd] == nil then
                vim.fn.system("git rev-parse --is-inside-work-tree")
                is_inside_work_tree[cwd] = vim.v.shell_error == 0
            end

            if is_inside_work_tree[cwd] then
                builtin.git_files({})
            else
                builtin.find_files({})
            end
        end)

        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word, initial_mode = "normal"})
        end)

        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word, initial_mode = "normal"})
        end)
        
        vim.keymap.set('n', '<leader>rg', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)

        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

        vim.keymap.set('n', '<leader>bf', function()
            builtin.buffers({initial_mode = "normal"})
        end)
        
        vim.keymap.set('n', '<leader>rr', function()
            builtin.buffers({initial_mode = "normal"})
        end)
    end
}

