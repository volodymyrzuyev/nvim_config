local orgPath = "~/org/"
local baseTemplate = [[* TODO %?
    SCHEDULED: %T
    DEADLINE: %u]]

return {
	"nvim-orgmode/orgmode",
	dependencies = {
		"akinsho/org-bullets.nvim",
		"danilshvalov/org-modern.nvim",
	},
	ft = { "org" },
	config = function()
		local org = require("orgmode")

		org.setup({
			org_agenda_files = orgPath .. "**/*",
			org_default_notes_file = orgPath .. "refile.org",
			org_todo_keywords = {
				"TODO",
				"NEXT",
				"WORKING",
				"TO_SUBMIT",
				"WAITING",
				"|",
				"DONE",
				"CANCELED",
			},
			org_capture_templates = {
				s = {
					description = "school todo",
					template = baseTemplate,
					target = orgPath .. "school/refile.org",
				},
				p = {
					description = "project todo",
					template = baseTemplate,
					target = orgPath .. "projects/refile.org",
				},
				t = {
					description = "task",
					template = baseTemplate,
					target = orgPath .. "refile.org",
				},
				n = {
					description = "note",
					template = "* %u %?",
					target = orgPath .. "refile.org",
				},
			},
			org_tags_column = -80,
			org_agenda_custom_commands = {
				p = {
					description = "Projects",
					types = {
						{
							type = "tags_todo",
							org_agenda_files = { orgPath .. "projects/**/*" },
							org_agenda_todo_ignore_deadlines = "far",
						},
					},
				},
				s = {
					description = "School",
					types = {
						{
							type = "agenda",
							org_agenda_files = { orgPath .. "school/**/*" },
							org_agenda_overriding_header = "School",
							org_agenda_todo_ignore_deadlines = "far",
						},
						{
							type = "tags_todo",
							org_agenda_overriding_header = "TODO",
							org_agenda_files = { orgPath .. "school/**/*" },
						},
					},
				},
				d = {
					description = "Today",
					types = {
						{
							type = "agenda",
							org_agenda_overriding_header = "Today",
							org_agenda_span = "day",
						},
					},
				},
			},
		})
		local Menu = require("org-modern.menu")
		require("orgmode").setup({
			ui = {
				menu = {
					handler = function(data)
						Menu:new({
							window = {
								margin = { 1, 0, 1, 0 },
								padding = { 0, 1, 0, 1 },
								title_pos = "center",
								border = "single",
								zindex = 1000,
							},
							icons = {
								separator = "➜",
							},
						}):open(data)
					end,
				},
			},
		})
	end,
}
