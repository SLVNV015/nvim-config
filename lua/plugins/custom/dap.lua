return {
  {
    "mfussenegger/nvim-dap",
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      dapui.setup()

      -- Авто-открытие UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup()
    end,
  },

  -- TS/JS: адаптер для vscode-js-debug
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require "dap"

      require("dap-vscode-js").setup {
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      }

      for _, lang in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
        dap.configurations[lang] = {
          -- 1) Запуск текущего файла через node
          {
            type = "pwa-node",
            request = "launch",
            name = "Node: current file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
          },

          -- 2) Запуск проекта (полезно для TS, если у тебя dev-сервер)
          -- поменяй runtimeExecutable / args под свой проект (npm/pnpm/yarn)
          {
            type = "pwa-node",
            request = "launch",
            name = "Node: npm run dev",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "npm",
            runtimeArgs = { "run", "dev" },
            sourceMaps = true,
            console = "integratedTerminal",
          },

          -- 3) Attach к уже запущенному node --inspect
          {
            type = "pwa-node",
            request = "attach",
            name = "Node: attach (9229)",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            port = 9229,
          },
        }
      end
    end,
  },

  -- Сам vscode-js-debug (его надо скачать и собрать)
  {
    "microsoft/vscode-js-debug",
    -- важно: этот build-скрипт прямо из README nvim-dap-vscode-js
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  },
}
