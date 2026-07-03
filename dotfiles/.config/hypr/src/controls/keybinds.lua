local mainMod = "SUPER"

-- Applications & Actions
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -show drun -show-icons -matching fuzzy"))

-- Screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + CTRL + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --raw | satty --filename -"))

-- Requires :D
require("src.controls.keybinds.window_workspace")
require("src.controls.keybinds.fn_keys")
