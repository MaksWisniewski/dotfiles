vim.api.nvim_create_user_command("RUN", function()
    local file = vim.fn.expand("%")
    local output = vim.fn.expand("%:r") -- same name without extension
    -- vim.cmd("!g++ " .. file .. " -o " .. output .. " && ./" .. output)
    vim.cmd("!g++ -std=c++17 -O2 -Wall -Wextra -Wshadow -Wconversion -Wunreachable-code -Wreturn-type -Wno-unused-result " .. file .. " -o " .. output)
    vim.cmd("!g++ " .. file .. " -o " .. output)
end, {})


-- CP command: copy whole file to system clipboard
vim.api.nvim_create_user_command("CP", function()
    vim.cmd([[ %y+ ]]) -- % = entire file, y = yank, + = system clipboard
    print("File copied to system clipboard ✅")
end, {})
