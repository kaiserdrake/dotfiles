return {
  "folke/which-key.nvim",
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "whichkey")
			require("which-key").setup(opts)
			local present, wk = pcall(require, "which-key")
			if not present then
				return
			end
			wk.add({
        { "<leader>g", group = "GitSigns" },
			})
		end,
		setup = function()
			require("core.utils").load_mappings("whichkey")
		end,
}
