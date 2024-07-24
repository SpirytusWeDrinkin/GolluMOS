{ config, lib, host, pkgs, ... }: 
{
    programs.waybar.enable = true;
    programs.waybar.settings = {
        mainBar = {
            layer = "top";

            modules-left = [ "custom/launcher" "clock" "network" ];
            modules-center = [ "hyprland/workspaces" ];
            modules-right = [ "pulseaudio" "cpu" "memory" "battery" "custom/power" ];

            pulseaudio = {
                tooltip = false;
                scroll-step = 2;
                format = "{icon} {volume}%";
                format-muted = "{icon} {volume}%";
                on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
                format-icons = {
                    default = [ " " " " " " ];
                };
            };

            "hyprland/workspaces" = {
                active-only = false;
                all-output = true;
                on-click = true;
                format = "{icon}";
                format-icons = {
                    urgent = "󰵚 ";
                    active = "󰝥 ";
                    default = " ";
                };
                persistent-workspaces = {
                    "*"= 5;
                };
            };

            network = {
                tooltip = false;
                format-wifi = "  {essid}";
                format-ethernet = "󰈀 ";
            };

            battery = {
                states = {
                    good = 95;
                    warning = 30;
                    critical = 20;
                };
                format = "{icon} {capacity}%";
                format-charging = " {capacity}%";
                format-plugged = " {capacity}%";
                format-alt = "{time} {icon}";
                format-icons = [ " " " " " " " " " " ];
            };

            clock = {
                format = "{:%H:%M    %d/%m/%Y}";
            };

            cpu = {
                interval = 15;
                format = "󰍛  {}%";
                max-length = 10;
            };

            memory = {
                interval = 30;
                format = "  {}%";
                max-length = 10;
            };

            "custom/launcher" = {
                format = " ";
                on-click = "rofi -show drun";
                on-click-right = "killall rofi";
            };
            "custom/power" = {
                format = " ";
                on-click = "bash ~/.config/rofi/leave.sh";
            };
        };
    };
    stylix.targets.waybar.enable = false;
    programs.waybar.style =
        ''
        * {
border: none;
        border-radius: 10px;
        font-family: "IosevkaTerm Nerd Font";
        font-weight: bold;
        font-size: 15px;
        min-height: 10px;
        }

    window#waybar {
background: transparent;
    }

    window#waybar.hidden {
opacity: 0.2;
    }

#window {
    margin-top: 6px;
    padding-left: 10px;
    padding-right: 10px;
    border-radius: 10px;
transition: none;
color: transparent;
background: transparent;
}

#workspaces {
    margin-top: 6px;
    margin-left: 12px;
    font-size: 4px;
    margin-bottom: 0px;
    border-radius: 10px;
background: #${config.lib.stylix.colors.base00};
transition: none;
}

#workspaces button {
padding: 1px 9px;
margin: 3px 3px;
        border-radius: 15px;
border:0px;
color: #${config.lib.stylix.colors.base03};
background: #${config.lib.stylix.colors.base00};
transition: all 0.3s ease-in-out;
opacity:0.4;
}

#workspaces button.active {
color: #${config.lib.stylix.colors.base0A};
background: transparent;
            border-radius: 15px;
            min-width: 30px;
transition: all 0.3s ease-in-out;
opacity:1.0;

}

#workspaces button:hover {
transition: none;
            box-shadow: inherit;
            text-shadow: inherit;
color: #${config.lib.stylix.colors.base0A};
}

#network {
    margin-top: 6px;
    margin-left: 8px;
    padding-left: 10px;
    padding-right: 10px;
    margin-bottom: 0px;
    border-radius: 10px;
transition: none;
color: #${config.lib.stylix.colors.base0D};
background: #${config.lib.stylix.colors.base00};
}

#pulseaudio {
    margin-top: 6px;
    margin-left: 8px;
    padding-left: 10px;
    padding-right: 10px;
    margin-bottom: 0px;
    border-radius: 10px;
transition: none;
color: #${config.lib.stylix.colors.base0E};
background: #${config.lib.stylix.colors.base00};
}

#battery {
    margin-top: 6px;
    margin-left: 8px;
    padding-left: 10px;
    padding-right: 10px;
    margin-bottom: 0px;
    border-radius: 10px;
transition: none;
color: #${config.lib.stylix.colors.base0B};
background: #${config.lib.stylix.colors.base00};
}

#battery.charging, #battery.plugged {
color: #${config.lib.stylix.colors.base0C};
background: #${config.lib.stylix.colors.base00};
}

#battery.critical:not(.charging) {
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
color: #${config.lib.stylix.colors.base05};
background: #${config.lib.stylix.colors.base08};
}


#clock {
    margin-top: 6px;
    margin-left: 8px;
    padding-left: 10px;
    padding-right: 10px;
    margin-bottom: 0px;
    border-radius: 10px;
transition: none;
color: #${config.lib.stylix.colors.base0C};
background: #${config.lib.stylix.colors.base00};
}

#memory {
    margin-top: 6px;
    margin-left: 8px;
    padding-left: 10px;
    margin-bottom: 0px;
    padding-right: 10px;
    border-radius: 10px;
transition: none;
color: #${config.lib.stylix.colors.base0A};
background: #${config.lib.stylix.colors.base00};
}

#cpu {
    margin-top: 6px;
    margin-left: 8px;
    padding-left: 10px;
    margin-bottom: 0px;
    padding-right: 10px;
    border-radius: 10px;
transition: none;
color: #${config.lib.stylix.colors.base08};
background: #${config.lib.stylix.colors.base00};
}

#custom-launcher {
    font-size: 24px;
    margin-top: 6px;
    margin-left: 8px;
    padding-left: 5px;
    padding-right: 5px;
    border-radius: 10px;
transition: none;
background: #7EBAE4;
color: #5277C3;
}

#custom-power {
    font-size: 20px;
    margin-top: 6px;
    margin-left: 8px;
    margin-right: 5px;
    padding-left: 7px;
    padding-right: 5px;
    margin-bottom: 0px;
    border-radius: 10px;
transition: none;
color: #${config.lib.stylix.colors.base08};
background: #${config.lib.stylix.colors.base00};
}
'';
}
