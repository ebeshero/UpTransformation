<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="results">
            <sch:assert test="sum(stooge/number()) eq 100">Total percentages must equal
                100. (The sum of the percentages here is <sch:value-of select="sum(stooge/number())"/>.</sch:assert>
            <sch:assert test="count(stooge) eq 3">There are exactly three stooges!</sch:assert>
            <sch:assert test="count(stooge) eq count(distinct-values(stooge/@name))">No duplicate
                stooges allowed!</sch:assert>
        </sch:rule>
        <sch:rule context="stooge">
            <sch:report test="string-length(.) eq 0">Percentage required for all
                stooges</sch:report>
            <sch:report test="number(.) lt 0">Percentage must be positive</sch:report>
            <sch:report test="number(.) gt 100">Percentage cannot exceed 100</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>
