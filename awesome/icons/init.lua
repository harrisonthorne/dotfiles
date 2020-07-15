local gears = require("gears")

local function file_exists(path)
    -- Try to open it
    local f = io.open(path)
    if f then
        f:close()
        return true
    end
    return false
end

local icons = {}
icons.image = {}
icons.text = {}

-- TODO Set up weather text icons here instead of in ../noodle/text_weather.lua
-- icons.text.weather = {}

-- Set up text symbols and accent colors to be used in tasklists or docks
-- instead of awful.widget.clienticon
-- Based on the client's `class` property
-- TODO Ability to match using rules instead of just class
icons.text.by_class = {
    -- Terminals
    ['kitty'] = { symbol = "", color = colors.color5 },
    ['Alacritty'] = { symbol = "", color = colors.color5 },
    ['Termite'] = { symbol = "", color = colors.color5 },
    ['URxvt'] = { symbol = "", color = colors.color5 },
    ['st'] = { symbol = "", color = colors.color5 },
    ['st-256color'] = { symbol = "", color = colors.color5 },

    -- Image viewers
    ['feh'] = { symbol = "", color = colors.color1 },
    ['Sxiv'] = { symbol = "", color = colors.color1 },

    -- General
    ['TelegramDesktop'] = { symbol = "", color = colors.color4 },
    ['Firefox'] = { symbol = "", color = colors.color3 },
    ['firefox'] = { symbol = "", color = colors.color3 },
    ['Nightly'] = { symbol = "", color = colors.color4 },
    ['Chromium'] = { symbol = "", color = colors.color4 },
    ['Chromium-browser'] = { symbol = "", color = colors.color4 },
    ['Steam'] = { symbol = "", color = colors.color2 },
    ['Lutris'] = { symbol = "", color = colors.color6 },
    ['editor'] = { symbol = "", color = colors.color5 },
    ['Emacs'] = { symbol = "", color = colors.color2 },
    ['email'] = { symbol = "", color = colors.color6 },
    ['music'] = { symbol = "", color = colors.color6 },
    ['mpv'] = { symbol = "", color = colors.color6 },
    ['KeePassXC'] = { symbol = "", color = colors.color1 },
    ['Gucharmap'] = { symbol = "", color = colors.color6 },
    ['Pavucontrol'] = { symbol = "", color = colors.color4 },
    ['htop'] = { symbol = "", color = colors.color2 },
    ['Screenruler'] = { symbol = "", color = colors.color3 },
    ['Galculator'] = { symbol = "", color = colors.color2 },
    ['Zathura'] = { symbol = "", color = colors.color2 },
    ['Qemu-system-x86_64'] = { symbol = "", color = colors.color3 },
    ['Wine'] = { symbol = "", color = colors.color1 },
    ['markdown_input'] = { symbol = "", color = colors.color2 },
    ['scratchpad'] = { symbol = "", color = colors.color1 },
    ['weechat'] = { symbol = "", color = colors.color5 },
    ['discord'] = { symbol = "", color = colors.color5 },
    ['6cord'] = { symbol = "", color = colors.color3 },
    ['libreoffice-writer'] = { symbol = "", color = colors.color4 },
    ['libreoffice-calc'] = { symbol = "", color = colors.color2 },
    ['libreoffice-impress'] = { symbol = "", color = colors.color1 },
    ['Godot'] = { symbol = "", color = colors.color4 },

    -- File managers
    ['Thunar'] = { symbol = "", color = colors.color3 },
    ['Nemo'] = { symbol = "", color = colors.color3 },
    ['files'] = { symbol = "", color = colors.color3 },

    ['Gimp'] = { symbol = "", color = colors.color4 },
    ['Inkscape'] = { symbol = "", color = colors.color2 },
    ['Gpick'] = { symbol = "", color = colors.color6 },

    -- Default
    ['_'] = { symbol = "", color = colors.color7.."99" }
}

-- Available icons
local image_icon_names = {
    -- "playerctl_toggle",
    -- "playerctl_prev",
    -- "playerctl_next",
    -- "stats",
    -- "search",
    -- "volume",
    -- "muted",
    -- "firefox",
    -- "youtube",
    -- "reddit",
    -- "discord",
    -- "telegram",
    -- "steam",
    -- "games",
    -- "files",
    -- "manual",
    -- "keyboard",
    -- "appearance",
    -- "editor",
    -- "redshift",
    -- "gimp",
    -- "terminal",
    -- "mail",
    -- "music",
    -- "temperature",
    -- "battery",
    -- "battery_charging",
    -- "cpu",
    -- "compositor",
    -- "start",
    -- "ram",
    -- "screenshot",
    -- "home",
    -- "alarm",
    -- "alarm_off",
    -- "alert",
    -- "submenu",
    -- -- Weather icons
    -- "cloud",
    -- "dcloud",
    -- "ncloud",
    -- "sun",
    -- "star",
    -- "rain",
    -- "snow",
    -- "mist",
    -- "storm",
    -- "whatever",
    -- -- Exit screen icons
    -- "exit",
    -- "poweroff",
    -- "reboot",
    -- "suspend",
    -- "lock",
}

-- Path to icons
local p

-- Assumes all the icon files end in .png
-- TODO maybe automatically detect icons in icon theme directory
local function set_image_icon(icon_name)
    local i = p..icon_name..".png"
    icons.image[icon_name] = i
end

-- Set all the icon variables
function icons.init(theme_name)
    -- Set the path to image icons
    p = gears.filesystem.get_configuration_dir().."icons/"..theme_name.."/"

    for i = 1, #image_icon_names do
        set_image_icon(image_icon_names[i])
    end

    -- Set symbols and accent colors for text icons
end

return icons
