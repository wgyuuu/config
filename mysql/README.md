# mysql client 支持 Ctrl+W  需要在用户目录下配置
1. vi ~/.editrc
2. 内容如下
bind "^W" ed-delete-prev-word
bind "^U" vi-kill-line-prev
#bind "OF" ed-move-to-end # some problem with shift+insert
#bind "OH" ed-move-to-beg
bind "[C" ed-next-char
bind "[D" ed-prev-char
