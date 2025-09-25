return {
    handlers = {
	-- the roslyn lsp currently errors on restores
        ["workspace/_roslyn_projectNeedsRestore"] = function(_, result, ctx) end
    }
}
