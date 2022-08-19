local on_attach = function(_, bufnr)
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		signs = true,
	})

	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<F5>", vim.lsp.buf.format, bufopts)
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

require("nvim-lsp-installer").on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if server.name == "yamlls" then
		local settings = {
			yaml = {
				schemas = {
					["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",
				},
			},
		}

		local setup = {
			commands = {
				Format = {
					function()
						vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
					end,
				},
			},
		}

		opts = vim.tbl_deep_extend("force", { settings = settings, setup = setup }, opts)
	end

	if server.name == "r_language_server" then
		local settings = { r = { lsp = { diagnostics = false } } }
		opts = vim.tbl_deep_extend("force", { settings = settings }, opts)
	end

	if server.name == "jsonls" then
		local settings = {
			json = {
				schemas = {
					{
						fileMatch = { "tsconfig.json", "tsconfig.*.json" },
						url = "https://json.schemastore.org/tsconfig.json",
					},
					{
						fileMatch = { ".eslintrc.json", ".eslintrc" },
						url = "https://json.schemastore.org/eslintrc.json",
					},
					{
						fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
						url = "https://json.schemastore.org/prettierrc",
					},
					{
						fileMatch = { "package.json" },
						url = "https://json.schemastore.org/package.json",
					},
				},
			},
		}

		local setup = {
			commands = {
				Format = {
					function()
						vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
					end,
				},
			},
		}

		opts = vim.tbl_deep_extend("force", { settings = settings, setup = setup }, opts)
	end

	if server.name == "sumneko_lua" then
		local settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		}

		opts = vim.tbl_deep_extend("force", { settings = settings }, opts)
	end

	server:setup(opts)
end)
