-- Extra autostart processes.
-- o.launch_on_start("my-service")

o.launch_on_start("hyprsunset")

-- Preload Zen hidden on special:zen so Super+Shift+B is instant
o.exec_on_start(os.getenv("HOME") .. "/.local/bin/zen-summon --preload")
