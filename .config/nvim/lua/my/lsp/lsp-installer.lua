local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")

if not status_ok then
	return
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("my.lsp.handlers").on_attach,
		capabilities = require("my.lsp.handlers").capabilities,
	}

	if server.name == "yamlls" then
		local yamlls_opts = require("my.lsp.settings.yamlls")
		opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
	end

	if server.name == "r_language_server" then
		local r_language_server_opts = require("my.lsp.settings.r_language_server")
		opts = vim.tbl_deep_extend("force", r_language_server_opts, opts)
	end

	if server.name == "jsonls" then
		local jsonls_opts = require("my.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("my.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	server:setup(opts)
end)
