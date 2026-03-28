-- zoxide.yazi: jump to frecent directories via zoxide interactive mode
return {
	entry = function()
		local _permit = ya.hide()
		local child, err = Command("zoxide")
			:args({ "query", "--interactive" })
			:stdin(Command.INHERIT)
			:stdout(Command.PIPED)
			:stderr(Command.INHERIT)
			:spawn()

		if not child then
			ya.notify({
				title = "Zoxide",
				content = "Failed to spawn zoxide: " .. tostring(err),
				timeout = 3,
				level = "error",
			})
			return
		end

		local output = child:wait_with_output()
		if output and output.status.success then
			local dir = output.stdout:gsub("[\n\r]+$", "")
			if dir ~= "" then
				ya.mgr_emit("cd", { dir })
			end
		end
	end,
}
