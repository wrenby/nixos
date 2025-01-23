# Generated via dconf2nix: https://github.com/nix-commmunity/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "system/locale/ca/desrt/dconf-editor" = {
      show-warning = false;
    };

    "system/locale/com/solus-project/budgie-panel" = {
      builtin-theme = false;
      dark-theme = true;
      migration-level = 1;
      notification-position = "BUDGIE_NOTIFICATION_POSITION_BOTTOM_RIGHT";
      panels = [ "78dfc77a-ca1d-11ef-be59-7085c2976f67" ];
    };

    "system/locale/com/solus-project/budgie-panel/applets/{78e02b70-ca1d-11ef-be59-7085c2976f67}" = {
      alignment = "start";
      name = "Budgie Menu";
      position = 0;
    };

    "system/locale/com/solus-project/budgie-panel/applets/{7a4be4f4-ca1d-11ef-be59-7085c2976f67}" = {
      alignment = "start";
      name = "Icon Task List";
      position = 1;
    };

    "system/locale/com/solus-project/budgie-panel/applets/{7a5d70a2-ca1d-11ef-be59-7085c2976f67}" = {
      alignment = "end";
      name = "System Tray";
      position = 0;
    };

    "system/locale/com/solus-project/budgie-panel/applets/{7a6b128e-ca1d-11ef-be59-7085c2976f67}" = {
      alignment = "end";
      name = "Notifications";
      position = 1;
    };

    "system/locale/com/solus-project/budgie-panel/applets/{7a8207d2-ca1d-11ef-be59-7085c2976f67}" = {
      alignment = "end";
      name = "Status Indicator";
      position = 2;
    };

    "system/locale/com/solus-project/budgie-panel/applets/{7a9b8bbc-ca1d-11ef-be59-7085c2976f67}" = {
      alignment = "end";
      name = "Clock";
      position = 3;
    };

    "system/locale/com/solus-project/budgie-panel/applets/{7aa4db04-ca1d-11ef-be59-7085c2976f67}" = {
      alignment = "end";
      name = "Raven Trigger";
      position = 4;
    };

    "system/locale/com/solus-project/budgie-panel/instance/budgie-menu/{78e02b70-ca1d-11ef-be59-7085c2976f67}" = {
      menu-categories-hover = false;
      menu-compact = false;
      menu-headers = true;
      menu-show-control-center-items = true;
    };

    "system/locale/com/solus-project/budgie-panel/instance/icon-tasklist/{7a4be4f4-ca1d-11ef-be59-7085c2976f67}" = {
      pinned-launchers = [ "firefox.desktop" "codium.desktop" "nemo.desktop" "com.mitchellh.ghostty.desktop" ];
    };

    "system/locale/com/solus-project/budgie-panel/panels/{78dfc77a-ca1d-11ef-be59-7085c2976f67}" = {
      applets = [ "78e02b70-ca1d-11ef-be59-7085c2976f67" "7a5d70a2-ca1d-11ef-be59-7085c2976f67" "7a8207d2-ca1d-11ef-be59-7085c2976f67" "7a9b8bbc-ca1d-11ef-be59-7085c2976f67" "7aa4db04-ca1d-11ef-be59-7085c2976f67" "7a4be4f4-ca1d-11ef-be59-7085c2976f67" "7a6b128e-ca1d-11ef-be59-7085c2976f67" ];
      autohide = "none";
      dock-mode = false;
      enable-shadow = true;
      location = "bottom";
      size = 36;
      spacing = 2;
      transparency = "always";
    };

    "system/locale/com/solus-project/budgie-raven" = {
      allow-volume-overdrive = false;
    };

    "system/locale/com/solus-project/budgie-wm" = {
      attach-modal-dialogs = true;
      button-layout = "appmenu:minimize,maximize,close";
      button-style = "traditional";
      caffeine-mode = false;
      center-windows = false;
      focus-mode = false;
      pause-notifications-on-fullscreen = true;
    };

    "system/locale/io/missioncenter/MissionCenter" = {
      performance-selected-page = "cpu";
      window-height = 576;
      window-selected-page = "performance-page";
      window-width = 1024;
    };

    "system/locale/org/buddiesofbudgie/budgie-desktop-view" = {
      terminal = "ghostty";
    };

    "system/locale/org/buddiesofbudgie/budgie-desktop/raven/widgets" = {
      initialized = true;
      uuids = [ "517891e8-916d-4260-a9d5-c19d38d13cdf" "ee410402-7380-4935-9923-51b7fc2be93c" "5e464e5f-36fb-488a-91c8-3b14161d513e" "02a42472-3085-4eb9-86a8-3d25abbe22be" "04e3685e-de2e-47fc-9bdb-f6c18fd7ac17" ];
    };

    "system/locale/org/buddiesofbudgie/budgie-desktop/raven/widgets/instance-info/02a42472-3085-4eb9-86a8-3d25abbe22be" = {
      module = "org.buddiesofbudgie.budgie-desktop.raven.widget.SoundInput.so";
    };

    "system/locale/org/buddiesofbudgie/budgie-desktop/raven/widgets/instance-info/04e3685e-de2e-47fc-9bdb-f6c18fd7ac17" = {
      module = "org.buddiesofbudgie.budgie-desktop.raven.widget.MediaControls.so";
    };

    "system/locale/org/buddiesofbudgie/budgie-desktop/raven/widgets/instance-info/517891e8-916d-4260-a9d5-c19d38d13cdf" = {
      module = "org.buddiesofbudgie.budgie-desktop.raven.widget.Calendar.so";
    };

    "system/locale/org/buddiesofbudgie/budgie-desktop/raven/widgets/instance-info/5e464e5f-36fb-488a-91c8-3b14161d513e" = {
      module = "org.buddiesofbudgie.budgie-desktop.raven.widget.SoundOutput.so";
    };

    "system/locale/org/buddiesofbudgie/budgie-desktop/raven/widgets/instance-info/ee410402-7380-4935-9923-51b7fc2be93c" = {
      module = "org.buddiesofbudgie.budgie-desktop.raven.widget.UsageMonitor.so";
    };

    "system/locale/org/buddiesofbudgie/budgie-desktop/raven/widgets/instance-settings/517891e8-916d-4260-a9d5-c19d38d13cdf" = {
      show-week-numbers = false;
    };

    "system/locale/org/buddiesofbudgie/budgie-desktop/raven/widgets/instance-settings/5e464e5f-36fb-488a-91c8-3b14161d513e" = {
      allow-volume-overdrive = true;
    };

    "system/locale/org/buddiesofbudgie/control-center" = {
      last-panel = "color";
      window-state = mkTuple [ 980 640 false ];
    };

    "system/locale/org/gnome/desktop/input-sources" = {
      current = mkUint32 0;
      per-window = false;
      sources = [ (mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "system/locale/org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Adwaita";
      font-antialiasing = "rgba";
      font-hinting = "full";
      gtk-theme = "catppuccin-mocha-mauve-compact+default";
      icon-theme = "Papirus-Dark";
    };

    "system/locale/org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = mkDouble "1.0";
    };

    "system/locale/org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "system/locale/org/gnome/desktop/screensaver" = {
      lock-delay = mkUint32 30;
    };

    "system/locale/org/gnome/desktop/session" = {
      idle-delay = mkUint32 600;
    };

    "system/locale/org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = false;
    };

    "system/locale/org/gnome/desktop/wm/preferences" = {
      auto-raise = false;
      auto-raise-delay = 250;
      button-layout = "appmenu:minimize,maximize,close";
      focus-mode = "click";
    };

    "system/locale/org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "system/locale/org/gnome/mutter" = {
      attach-modal-dialogs = true;
    };

    "system/locale/org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" ];
    };

    "system/locale/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Primary><Shift>Escape";
      command = "missioncenter";
      name = "Launch Mission Center";
    };

    "system/locale/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Alt><Super>space";
      command = "emote";
      name = "Emoji Picker";
    };

    "system/locale/org/gnome/settings-daemon/plugins/power" = {
      idle-dim = true;
      sleep-inactive-ac-timeout = 900;
      sleep-inactive-battery-timeout = 900;
    };

    "system/locale/org/gnome/settings-daemon/plugins/xsettings" = {
      overrides = [
        (mkDictionaryEntry ["Gtk/ShellShowsAppMenu" (mkVariant 0)])
        (mkDictionaryEntry ["Gtk/DecorationLayout" (mkVariant "menu:minimize,maximize,close")])
      ];
    };

    "system/locale/org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 148;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 742 161 ];
      window-size = mkTuple [ 1096 822 ];
    };

    "system/locale/org/mate/engrampa/general" = {
      unar-open-zip = false;
    };

    "system/locale/org/mate/engrampa/listing" = {
      list-mode = "as-folder";
      name-column-width = 364;
      show-path = false;
      sort-method = "size";
      sort-type = "ascending";
    };

    "system/locale/org/mate/engrampa/ui" = {
      sidebar-width = 200;
      window-height = 480;
      window-width = 600;
    };

    "system/locale/org/mate/eom/ui" = {
      image-collection = false;
      sidebar = false;
      statusbar = true;
      toolbar = true;
    };

    "system/locale/org/mate/pluma" = {
      bottom-panel-size = 140;
      side-panel-active-page = 827629879;
      side-panel-size = 200;
      size = mkTuple [ 650 500 ];
      state = 87168;
      statusbar-visible = true;
    };

    "system/locale/org/mate/pluma/plugins/filebrowser/on-load" = {
      root = "file:///";
      tree-view = false;
      virtual-root = "file:///run/media/wren/NIXOS-PLASM/conf/ghostty";
    };

    "system/locale/org/nemo/window-state" = {
      geometry = "800x550+50+50";
      maximized = false;
      sidebar-bookmark-breakpoint = 0;
      start-with-sidebar = true;
    };

  };
}
