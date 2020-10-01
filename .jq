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
    else
    .
    end
);
