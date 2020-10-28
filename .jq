def yamlify:
(objects | to_entries[] | (.value | type) as $type |
    if $type == "array" then
    "\(.key):", (.value | yamlify)
    elif $type == "object" then
    "\(.key):", "    \(.value | yamlify)"
    else
    "\(.key):\t\(.value)"
    end
)
// (arrays | select(length > 0)[] | [yamlify] |
"  - \(.[0])", "    \(.[1:][])"
)
// .
;

def rmnulls:
walk(
    if type == "array" then
    map(select(. != null))
    elif type == "object" then
    with_entries(
        select(
            .value != null and
            .value != "" and
            .value != [] and
            .value != {}
        )
    )
    else
    .
    end
);

def rmidx:
walk(
    if type == "object" and has("indices") then
    del(.indices)
    elif type == "object" and has("display_text_range") then
    del(.display_text_range)
    else
    .
    end
);

def rmjunk:
del(.display_text_range, 
    .truncated, 
    .id, 
    .in_reply_to_status_id,
    .in_reply_to_user_id,
    .contributors,
    .favorited,
    .retweeted,
    .retweeted_status.id,
    .quoted_status_id,
    .quoted_status.id,
    .quoted_status.quoted_status_id,
    .quoted_status.conversation_id,
    .conversation_id,
    .user.user_id,
    .user_id
);

