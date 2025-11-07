local wezterm = require("wezterm")
local appearance = require("lua/appearance")
local mux = wezterm.mux

local moon = require("lua/rose-pine").moon
local dawn = require("lua/rose-pine").dawn

local config = wezterm.config_builder()

if appearance.is_dark() then
	config.colors = moon.colors()
	config.window_frame = moon.window_frame()
else
	config.colors = dawn.colors()
	config.window_frame = dawn.window_frame()
end

config.window_background_opacity = 0.95
config.macos_window_background_blur = 30

config.font = wezterm.font("Vulf Mono")

config.window_frame = {
	font = wezterm.font("Vulf Sans"),
	font_size = 15,
}

config.command_palette_font_size = 18

config.leader = { key = "Tab", mods = "CTRL", timeout_milliseconds = 1000 }

local function move_pane(key, direction)
	return {
		key = key,
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection(direction),
	}
end

config.keys = {
	{ mods = "LEADER", key = "-", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "=", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{
		mods = "LEADER",
		key = "Backspace",
		action = wezterm.action.CloseCurrentPane({ domain = "CurrentPaneDomain", confirm = false }),
	},
	{ mods = "LEADER", key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
	{ mods = "LEADER", key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
	{ mods = "LEADER", key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
	{ mods = "LEADER", key = "l", action = wezterm.action.ActivatePaneDirection("Right") },
}

config.window_close_confirmation = "NeverPrompt"
config.skip_close_confirmation_for_processes_named = {
	"bash",
	"sh",
	"zsh",
	"fish",
	"tmux",
	"nu",
	"cmd.exe",
	"pwsh.exe",
	"powershell.exe",
}

return config
