-- Define keymaps
local dap = require("dap")
local ui = require("dapui")

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Add breakpoint" })
vim.keymap.set("n", "<space>de", function() ui.eval(nil, { enter = true }) end, { desc = "Evaluate value" })


vim.keymap.set("n", "<F1>", dap.continue, { desc = "DAP Continue" })
vim.keymap.set("n", "<F2>", dap.step_into, { desc = "DAP Step-Into" })
vim.keymap.set("n", "<F3>", dap.step_over, { desc = "DAP Step-Over" })
vim.keymap.set("n", "<F4>", dap.step_out, { desc = "DAP Step-Out" })
vim.keymap.set("n", "<F5>", dap.step_back, { desc = "DAP Step-Back" })
vim.keymap.set("n", "<F6>", dap.terminate, { desc = "DAP Stop" })
vim.keymap.set("n", "<F12>", dap.restart, { desc = "DAP Restart" })

dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end

require("dapui").setup()
