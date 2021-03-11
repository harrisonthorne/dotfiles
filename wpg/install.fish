#! /usr/bin/env fish

function make_wpg_link -a config_file wpg_base_file
	set config_file ~/.config/$argv[1]
	set wpg_base_file ~/.config/wpg/templates/$argv[2]
	set wpg_generated_file (string split -r -m1 . $wpg_base_file)[1]
	touch $config_file
	if test -e $wpg_generated_file
		set bak_file "$wpg_generated_file.bak"
		mv $wpg_generated_file $bak_file
		echo "warning: `$wpg_generated_file` was moved to `$bak_file`"
	end
	ln -vsrf $config_file $wpg_generated_file
end

make_wpg_link alacritty/alacritty.yml config_alacritty_alacritty.yml.base
make_wpg_link awesome/colors.lua config_awesome_colors.lua.base
make_wpg_link bspwm/bspwmrc bspwmrc.base
make_wpg_link bspwm/panel.sh panel.sh.base
make_wpg_link cava/config config_cava_config.base
make_wpg_link dunst/dunstrc dunstrc.base
make_wpg_link i3/lock.sh config_i3_lock.sh.base
make_wpg_link kitty/colors.conf config_kitty_colors.conf.base
make_wpg_link mako/config mako.base
make_wpg_link rofi/muse.rasi muse.rasi.base
make_wpg_link sway/config config_sway_config.base
make_wpg_link sway/lock.sh config_sway_lock.sh.base
