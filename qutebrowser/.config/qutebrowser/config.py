# ==== RAHHHHH ====
config.load_autoconfig()

# ====== COLOR THEME (DARK, TRANSPARENT) ======
background = "#1e1e2e"
foreground = "#cdd6f4"
color0 = "#313244"  # Tab fg
color12 = "#89b4fa"  # Hover link
color13 = "#f5c2e7"  # HTTPS link
color14 = "#94e2d5"  # Active tab, statusbar
color6 = "#74c7ec"  # Completion match
color8 = "#f38ba8"  # Stop indicator
color10 = "#a6e3a1"  # Start indicator

# Transparent areas
c.colors.statusbar.normal.bg = "#00000000"
c.colors.statusbar.command.bg = "#00000000"
c.colors.statusbar.command.fg = foreground
c.colors.statusbar.normal.fg = color14
c.colors.statusbar.passthrough.fg = color14
c.colors.statusbar.url.fg = color13
c.colors.statusbar.url.success.https.fg = color13
c.colors.statusbar.url.hover.fg = color12

c.colors.tabs.bar.bg = "#00000000"
c.colors.tabs.even.bg = "#00000000"
c.colors.tabs.odd.bg = "#00000000"
c.colors.tabs.even.fg = color12
c.colors.tabs.odd.fg = color12
c.colors.tabs.selected.even.bg = color0
c.colors.tabs.selected.odd.bg = color0
c.colors.tabs.selected.even.fg = color14
c.colors.tabs.selected.odd.fg = color14
c.colors.hints.bg = background
c.colors.hints.fg = foreground

c.colors.completion.item.selected.match.fg = color6
c.colors.completion.match.fg = color6
c.colors.tabs.indicator.start = color10
c.colors.tabs.indicator.stop = color8
c.colors.completion.odd.bg = background
c.colors.completion.even.bg = background
c.colors.completion.fg = foreground
c.colors.completion.category.bg = background
c.colors.completion.category.fg = foreground
c.colors.completion.item.selected.bg = background
c.colors.completion.item.selected.fg = foreground

c.colors.messages.info.bg = background
c.colors.messages.info.fg = foreground
c.colors.messages.error.bg = background
c.colors.messages.error.fg = foreground
c.colors.downloads.error.bg = background
c.colors.downloads.error.fg = foreground

c.colors.downloads.bar.bg = background
c.colors.downloads.start.bg = color10
c.colors.downloads.start.fg = foreground
c.colors.downloads.stop.bg = color8
c.colors.downloads.stop.fg = foreground

c.colors.tooltip.bg = background
c.colors.webpage.bg = background
c.hints.border = foreground

# ====== TABS ======
c.tabs.show = "multiple"
c.tabs.padding = {"top": 5, "bottom": 5, "left": 9, "right": 9}
c.tabs.indicator.width = 0
c.tabs.width = "7%"

# ====== SEARCH ENGINES ======
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "!aw": "https://wiki.archlinux.org/?search={}",
    "!apkg": "https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=",
    "!gh": "https://github.com/search?o=desc&q={}&s=stars",
    "!yt": "https://www.youtube.com/results?search_query={}",
    "!cal": "https://calendar.google.com/calendar/u/{}",
}
c.completion.open_categories = [
    "searchengines",
    "quickmarks",
    "bookmarks",
    "history",
    "filesystem",
]


# ====== SESSION ======
c.auto_save.session = True

# ====== KEYBINDINGS ======
config.bind("=", "cmd-set-text -s :open")
config.bind("h", "history")
config.bind("cs", "cmd-set-text -s :config-source")
config.bind("tH", "config-cycle tabs.show multiple never")
config.bind("sH", "config-cycle statusbar.show always never")
config.bind("T", "hint links tab")
config.bind("pP", "open -- {primary}")
config.bind("pp", "open -- {clipboard}")
config.bind("pt", "open -t -- {clipboard}")
config.bind("qm", "macro-record")
config.bind("<ctrl-y>", "spawn --userscript ytdl.sh")
config.bind("tT", "config-cycle tabs.position top left")
config.bind("gJ", "tab-move +")
config.bind("gK", "tab-move -")
config.bind("gm", "tab-move")

# ====== DARK MODE ======
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.policy.images = "never"
config.set("colors.webpage.darkmode.enabled", False, "file://*")

# ====== FONTS ======
c.fonts.web.size.default = 20
c.fonts.default_family = []
c.fonts.default_size = "13pt"
c.fonts.web.family.fixed = "monospace"
c.fonts.web.family.sans_serif = "monospace"
c.fonts.web.family.serif = "monospace"
c.fonts.web.family.standard = "monospace"

# ====== PRIVACY ======
config.set("content.webgl", False, "*")
config.set("content.canvas_reading", False)
config.set("content.geolocation", False)
config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")
config.set("content.cookies.accept", "all")
config.set("content.cookies.store", True)
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36",
)


# ====== ADBLOCKING ======
c.content.blocking.enabled = True
# Uncomment below if using `python-adblock`
# c.content.blocking.method = 'adblock'
# c.content.blocking.adblock.lists = [ ... ]
