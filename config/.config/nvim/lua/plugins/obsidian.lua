return {
  -- TODO: set keymaps
  -- TODO: configure picker to work
  -- TODO:
  -- TODO:
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "Saghen/blink.cmp",
    "ibhagwan/fzf-lua",
    "echasnovski/mini.pick",
    "folke/snacks.nvim",
    "nvim-treesitter/nvim-treesitter",
    "preservim/vim-markdown",
    "MeanderingProgrammer/render-markdown.nvim",
    -- see above for full list of optional dependencies ☝️
  },
  ---@module 'obsidian'
  opts = {
    workspaces = {
      {
        name = "workshop-vault",
        path = "~/shared/building-a-second-brain-with-neovim/obsidian/workshop-vault",
      },
    },

    new_notes_location = "current_dir",
    templates = {
      folder = "workshop-vault/Templates",
      date_format = "%YYYY-%MM-%DD",
      time_format = "%HH:%mm",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },
    ui = { enable = false },
    completion = {
      -- Enables completion using nvim_cmp
      nvim_cmp = false,
      -- Enables completion using blink.cmp
      blink = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
      -- Set to false to disable new note creation in the picker
      create_new = true,
      -- prepend_note_id = true,
    },
    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
      name = "snacks.pick",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = "<C-x>",
        -- Insert a tag at the current location.
        insert_tag = "<C-l>",
      },
    },
    -- mappings
    -- https://github.com/obsidian-nvim/obsidian.nvim/wiki/Keymaps
    -- Remove default mapping
    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "ObsidianNoteEnter",
    --   callback = function(ev)
    --     vim.keymap.del("n", "<CR>", { buffer = ev.buf })
    --   end,
    -- }),
    vim.api.nvim_create_autocmd("User", {
      pattern = "ObsidianNoteEnter",
      callback = function(ev)
        local obsidian_keymaps = {
          { mode = "n", key = "<leader>ob", cmd = "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
          { mode = "n", key = "<leader>ojd", cmd = "<cmd>Obsidian dailies<cr>", desc = "Dailies" },
          { mode = "v", key = "<leader>oe", cmd = "<cmd>Obsidian extract_note<cr>", desc = "[e]xtract to note body" },
          -- { mode = "n", key = "<CR>", cmd = "<cmd>Obsidian follow_link<cr>", desc = "[f]ollow [l]ink" },
          { mode = "v", key = "<leader>ol", cmd = "<cmd>Obsidian link<cr>", desc = "[l]ink to note" },
          { mode = "v", key = "<leader>oL", cmd = "<cmd>Obsidian link_new<cr>", desc = "New [L]inked Note" },
          { mode = "n", key = "<leader>osl", cmd = "<cmd>Obsidian links<cr>", desc = "[s]earch [l]inks" },
          { mode = "n", key = "<leader>onn", cmd = "<cmd>Obsidian new<cr>", desc = "[n]ew [n]ote" },
          {
            mode = "n",
            key = "<leader>ont",
            cmd = "<cmd>Obsidian new_from_template<cr>",
            desc = "[n]ew [t]emplated note",
          },
          { mode = "n", key = "<leader>oo", cmd = "<cmd>Obsidian open<cr>", desc = "[o]pen in app" },
          { mode = "n", key = "<leader>osn", cmd = "<cmd>Obsidian quick_switch<cr>", desc = "[s]earch [n]otes" },
          { mode = "n", key = "<leader>osg", cmd = "<cmd>Obsidian search<cr>", desc = "[s]earch [g]rep" },
          { mode = "n", key = "<leader>ost", cmd = "<cmd>Obsidian tags<cr>", desc = "[s]earch [t]ags" },
          { mode = "n", key = "<leader>ot", cmd = "<cmd>Obsidian template<cr>", desc = "[t]emplate [i]nsert" },
          { mode = "n", key = "<leader>ojt", cmd = "<cmd>Obsidian today<cr>", desc = "[j]ournal [t]oday" },
          { mode = "n", key = "<leader>ojT", cmd = "<cmd>Obsidian tomorrow<cr>", desc = "[j]ournal [T]omorrow" },
          { mode = "n", key = "<leader>osh", cmd = "<cmd>Obsidian toc<cr>", desc = "[s]earch [h]eaders" },
          { mode = "n", key = "<leader>oc", cmd = "<cmd>Obsidian toggle_checkbox<cr>", desc = "toggle [c]heckbox" },
          { mode = "n", key = "<leader>ow", cmd = "<cmd>Obsidian workspace<cr>", desc = "[w]workspaces" },
          { mode = "n", key = "<leader>ojy", cmd = "<cmd>Obsidian yesterday<cr>", desc = "[j]ournal [y]esterday" },
        }

        -- Set keymaps in a loop
        for _, map in ipairs(obsidian_keymaps) do
          vim.keymap.set(map.mode, map.key, map.cmd, { buffer = ev.buf, desc = map.desc })
        end
      end,
    }),
    -- To upgrade your config, set wiki_link_func as follows. If you have completion.prepend_note_id, then set:
    -- https://github.com/epwalsh/obsidian.nvim/pull/406
    --
    wiki_link_func = function(opts)
      if opts.id == nil then
        return string.format("[[%s]]", opts.label)
      elseif opts.label ~= opts.id then
        return string.format("[[%s|%s]]", opts.id, opts.label)
      else
        return string.format("[[%s]]", opts.id)
      end
    end,

    -- Optional, alternatively you can customize the frontmatter data.
    ---@return table
    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      if note.title then
        note:add_alias(note.title)
      end

      local out = { id = note.id, aliases = note.aliases, tags = note.tags, area = "", project = "" }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,
  },
}
