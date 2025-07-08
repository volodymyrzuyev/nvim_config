return {
	"nvim-orgmode/orgmode",
	dependencies = { "akinsho/org-bullets.nvim" },
	ft = { "org" },
	config = function()
		local org = require("orgmode")

		org.setup({
			org_agenda_files = "/home/blueberry/org/**/*",
			org_default_notes_file = "~/org/refile.org",
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
					description = "school",
					template = "* TODO %?\n  %u",
					target = "~/org/school/refile.org",
				},
				p = {
					description = "project",
					template = "* TODO %?\n  %u",
					target = "~/org/projects/refile.org",
				},
			},
			org_tags_column = -80,
			org_agenda_custom_commands = {
				p = {
					description = "Projects",
					types = {
						{
							type = "tags_todo",
							org_agenda_files = { "~/org/projects/**/*" },
							org_agenda_todo_ignore_deadlines = "far",
						},
					},
				},
				s = {
					description = "School",
					types = {
						{
							type = "agenda",
							org_agenda_files = { "~/org/school/**/*" },
							org_agenda_overriding_header = "School",
							org_agenda_todo_ignore_deadlines = "far",
						},
						{
							type = "tags_todo",
							org_agenda_overriding_header = "TODO",
							org_agenda_files = { "~/org/school/**/*" },
						},
					},
				},
			},
		})

		require("org-bullets").setup()
	end,
}
