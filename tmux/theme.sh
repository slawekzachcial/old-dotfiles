#### COLOUR

tm_icon="♟"
tm_color_active=colour213
tm_color_inactive=colour241
tm_color_feature=colour4
tm_color_music=colour203

# separators
tm_separator_left_bold="◀"
tm_separator_left_thin="❮"
tm_separator_right_bold="▶"
tm_separator_right_thin="❯"

set-option -g status-left-length 32
set-option -g status-right-length 150
set-option -g status-interval 5


# default statusbar colors
# set-option -g status-bg colour0
set-option -g status-fg $tm_color_active
set-option -g status-bg default
set-option -g status-attr default

# default window title colors
set-window-option -g window-status-fg $tm_color_inactive
set-window-option -g window-status-bg default
set-option -g window-status-format "#I #{?window_zoomed_flag,(,}#W#{?window_zoomed_flag,),}"

# active window title colors
set-window-option -g window-status-current-fg $tm_color_active
set-window-option -g window-status-current-bg default
set-window-option -g window-status-current-format "#[bold]#I #{?window_zoomed_flag,(,}#W#{?window_zoomed_flag,),}"

# pane border
set-option -g pane-border-fg $tm_color_inactive
set-option -g pane-active-border-fg $tm_color_active

# message text
set-option -g message-bg default
set-option -g message-fg $tm_color_active

# pane number display
set-option -g display-panes-active-colour $tm_color_active
set-option -g display-panes-colour $tm_color_inactive

# clock
set-window-option -g clock-mode-colour $tm_color_active

tm_date="#[fg=$tm_color_inactive] %R %d %b"
tm_host="#[fg=$tm_color_feature,bold]#h"
tm_session_name="#[fg=$tm_color_feature,bold]$tm_icon #S"

set-option -g status-left $tm_session_name' '
#set -g status-right $tm_itunes' '$tm_rdio' '$tm_spotify' '$tm_date' '$tm_host
