local jdtls = require("jdtls")

-- Find root directory (essential for project-specific configuration)
local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })

-- Get the mason installation path
local install_path = require("mason-registry").get_package("jdtls"):get_install_path()

-- Get the current OS
local os_config = "linux" -- or 'mac' or 'win'
if vim.fn.has("mac") == 1 then
	os_config = "mac"
elseif vim.fn.has("win32") == 1 then
	os_config = "win"
end

-- Setup workspace folder
local workspace_folder = os.getenv("HOME") .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Setup config
local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		install_path .. "/config_" .. os_config,
		"-data",
		workspace_folder,
	},
	root_dir = root_dir,
	settings = {
		java = {
			configuration = {
				updateBuildConfiguration = "interactive",
			},
			eclipse = {
				downloadSources = true,
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			format = {
				enabled = true,
			},
		},
		signatureHelp = {
			enabled = true,
		},
		completion = {
			favoriteStaticMembers = {
				"org.junit.Assert.*",
				"org.junit.Assume.*",
				"org.junit.jupiter.api.Assertions.*",
				"org.junit.jupiter.api.Assumptions.*",
				"org.junit.jupiter.api.DynamicContainer.*",
				"org.junit.jupiter.api.DynamicTest.*",
			},
		},
		contentProvider = {
			preferred = "fernflower",
		},
		extendedClientCapabilities = jdtls.extendedClientCapabilities,
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			useBlocks = true,
		},
	},
	flags = {
		allow_incremental_sync = true,
	},
	init_options = {
		bundles = {},
	},
}

-- Start jdtls
jdtls.start_or_attach(config)
