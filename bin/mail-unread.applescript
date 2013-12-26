tell application "System Events" to set mailisrunning to (name of processes) contains "Mail"
if mailisrunning then
    tell application "Mail"
        set x to unread count of inbox
        if x is equal to 0 then
            return ""
        else
            return "Unread mail: " & x & " |"
        end if
    end tell
else 
    return ""
end if
