declare namespace NVS = "http://www.mla.org/NVSns";
<xml>
    {
        let $names := ((//NVS:author | //NVS:editor | //NVS:translator)
        [not(ancestor::bibl[2])]
        [not(preceding-sibling::*)]! normalize-space(.)
        => distinct-values()
        => sort())[not(contains(., ","))]
        for $name at $pos in $names
        
        return
            <name
                xml:id="author-{$pos}">{$name}</name>
    }
</xml>