-- lazygit.yazi: open lazygit rooted at the current yazi directory
return {
	entry = function()
		local cwd = cx.active.current.cwd
		local _permit = ya.hide()

		local child, err = Command("lazygit")
			:args({ "-p", tostring(cwd) })
			:stdin(Command.INHERIT)
			:stdout(Command.INHERIT)
			:stderr(Command.INHERIT)
			:spawn()

		if not child then
			ya.notify({
				title = "Lazygit",
				content = "Failed to spawn lazygit: " .. tostring(err),
				timeout = 3,
				level = "error",
			})
			return
		end

		child:wait()
	end,
}
