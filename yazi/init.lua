-- git status in file list
require("git"):setup()

-- relative motions (3j, 5k etc.)
require("relative-motions"):setup({ show_numbers = "relative", show_motion = true })

-- persistent bookmarks
require("bookmarks"):setup({
	save_path = os.getenv("HOME") .. "/.config/yazi/bookmarks.json",
	desc_format = "full",
	notify = {
		enable = false,
	},
})
