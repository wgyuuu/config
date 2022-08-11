# function pwdx {
#   sudo lsof -a -d cwd -p $1 -n -Fn | awk '/^n/ {print substr($0,2)}'
# }

function pwdx {
  sudo lsof -a -p $1 -d cwd -n | tail -1 | awk '{print $NF}'
}
