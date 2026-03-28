-- bat.yazi: syntax-highlighted text preview using bat
return {
	entry = function(_, job)
		local start = job.skip + 1
		local finish = job.skip + job.area.h

		local child, err = Command("bat")
			:args({
				"--color=always",
				"--style=numbers,changes",
				"--pager=never",
				"--line-range=" .. start .. ":" .. finish,
				tostring(job.file.url),
			})
			:stdout(Command.PIPED)
			:stderr(Command.NULL)
			:spawn()

		if not child then
			ya.preview_code(job)
			return
		end

		local output = child:wait_with_output()
		if output and output.status.success then
			ya.preview_widget(job, ui.Text.parse(output.stdout))
		else
			ya.preview_code(job)
		end
	end,
}
