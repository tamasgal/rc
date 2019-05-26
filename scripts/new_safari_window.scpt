on run argv
    tell application "Safari"
        if (count argv) = 0 then
            -- If you dont want to open a new window for an empty list, replace the
            -- following line with just "return"
            set {first_url, rest_urls} to {"", {}}
        else
            -- `item 1 of ...` gets the first item of a list, `rest of ...` gets
            -- everything after the first item of a list.  We treat the two
            -- differently because the first item must be placed in a new window, but
            -- everything else must be placed in a new tab.
            set {first_url, rest_urls} to {item 1 of argv, the rest of argv}
        end if

        make new document at end of documents with properties {URL:first_url}
        tell window 1
            repeat with the_url in rest_urls
                make new tab at end of tabs with properties {URL:the_url}
            end repeat
        end tell
        activate
    end tell
end run
