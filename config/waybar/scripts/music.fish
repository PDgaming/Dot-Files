#!/usr/bin/fish

# Handle mouse interactions
switch "$argv[1]"
    case toggle
        mpc -q toggle
    case next
        mpc -q next
    case prev
        mpc -q prev
end

# Check if MPD is reachable
set status_output (mpc status 2>/dev/null)
if test $status -ne 0
    echo '{"text": "Offline", "class": "disconnected"}'
    exit
end

# Extract song info
set song (mpc current)
if test -z "$song"
    echo '{"text": "Stopped", "class": "stopped"}'
    exit
end

# Extract progress details
# Line 2 of 'mpc status' usually looks like: [playing] #1/10  0:45/3:20 (22%)
set status_line $status_output[2]
set time (echo $status_line | awk '{print $3}')
set percent (echo $status_line | awk '{print $4}' | tr -d '()%')

# Determine CSS class and menu label
set class paused
if string match -rq '\[playing\]' "$status_line"
    set class playing
end

# Final Output: Song Title | Time
echo "{\"text\": \"$song\", \"tooltip\": \"Progress: $time ($percent%)\", \"class\": \"$class\"}"

# Generate GTK Menu XML
set menu_file "/home/prodeh/.config/waybar/music_menu.xml"
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<interface>
  <object class=\"GtkMenu\" id=\"menu\">
    <child>
      <object class=\"GtkMenuItem\" id=\"toggle\">
        <property name=\"label\">⏯ Toggle Playback</property>
      </object>
    </child>
    <child>
      <object class=\"GtkMenuItem\" id=\"prev\">
        <property name=\"label\">󰒮 Previous Track</property>
      </object>
    </child>
    <child>
      <object class=\"GtkMenuItem\" id=\"next\">
        <property name=\"label\">󰒭 Next Track</property>
      </object>
    </child>
  </object>
</interface>" >$menu_file
