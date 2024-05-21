{ config, lib, ... }:

{
  xsession.windowManager.i3 = 
    let
      modifier = "Mod1";
    in {
      enable = true;

      config = {
        inherit modifier;

        keybindings = lib.mkOptionDefault {
          "${modifier}+Shift+e" = "exec xfce4-session-logout";

          # Vim bindings
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";
        };

        # Rest of autostart is handled by xfce
        startup = [
          { command = "xfce4-panel"; notification = false; }
        ];

        defaultWorkspace = "workspace number 1"; # default is 10 for some reason

        floating.criteria = [
          { class = "Xfce4-panel"; }
          { class = "Xfce4-appfinder"; }
          { class = "Thunar"; }
        ];
        
        bars = [];

        window = {
          titlebar = false;
          border = 5;
        };

        gaps = {
          inner = 10;
        };

        # Default applications
        terminal = "kitty";
      };
    };
}
