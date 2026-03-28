-- pdfpreview.yazi: preview PDFs as extracted text using poppler's pdftotext
return {
	entry = function(_, job)
		local child, err = Command("pdftotext")
			:args({ "-l", "5", tostring(job.file.url), "-" })
			:stdout(Command.PIPED)
			:stderr(Command.NULL)
			:spawn()

		if not child then
			ya.preview_code(job)
			return
		end

		local output = child:wait_with_output()
		if output and output.status.success and #output.stdout > 0 then
			ya.preview_widget(job, ui.Text.parse(output.stdout))
		else
			ya.preview_code(job)
		end
	end,
}
