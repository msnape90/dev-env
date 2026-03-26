# LazyVim Basics
## sources
(Zero to IDE with LazyVim)[https://www.youtube.com/watch?v=N93cTbtLCIM]

# Keys

## <leader> sr
- "search replace"
- global search and replace

## <leader> sk
- search Keymaps
## s
- plugin leap
- search for a word to jump to then press the leading letter to jump to multi words

## <leader> sg
- "search grep"
- live grep for a string throughout project dir

## <leader> cr
- "code replace"
- replace a variable

## Splits
###Create 
#### <leader> |
- action: create a vertical split
#### <leader> -
- action: create a horizontal split
### Navigate
#### <C-{h,j,k,l}>
### Adjust size
#### <C-{up,down,left,right}>

## Help
### <leader> sh
- "search help"

## TODO
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
    { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
