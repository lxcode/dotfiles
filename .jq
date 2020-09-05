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
