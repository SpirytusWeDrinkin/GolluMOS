{}:

{
    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        settings = {
            "$mod" = "SUPER";

            bindm = [
            "$mod, enter, alacritty"
            ];
        }
    };
}
