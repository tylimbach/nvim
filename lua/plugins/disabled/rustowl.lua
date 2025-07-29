return {
	-- seems bugged for now
	-- {
	-- 	'cordx56/rustowl',
	-- 	version = "*",
	-- 	lazy = false,
	-- 	build = "cargo binstall rustowl",
	-- 	opts = {
	-- 		client = {
	-- 			on_attach = function(_, buffer)
	-- 				vim.keymap.set('n', '<leader>o', function()
	-- 					require('rustowl').toggle(buffer)
	-- 				end, { buffer = buffer, desc = 'Toggle RustOwl' })
	-- 			end
	-- 		}
	-- 	},
	-- }
}
