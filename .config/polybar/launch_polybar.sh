
# terminate polybar
killall -q polybar

# wait until all processes shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

desktop=$(echo $DESKTOP_SESSION)

count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)

case $desktop in i3|/usr/share/xsessions/i3.desktop)
  if type "xrandr" > /dev/null; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$m polybar --reload toph &
    done
  else
    polybar --reload toph &
  fi
esac
