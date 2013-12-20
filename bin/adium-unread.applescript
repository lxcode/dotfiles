tell application "System Events" to set adiumisrunning to (name of processes) contains "Adium"
if adiumisrunning then
	tell application "Adium"
		set tabs to count of chats
		set unreads to 0
		repeat with loopi from 1 to tabs
			set unreads to unreads + (unread message count of chat loopi)
		end repeat
		if unreads is equal to 0 then
			return ""
		else
			return "Unread IM: " & unreads & " |"
		end if
	end tell
else
	return ""
end if
