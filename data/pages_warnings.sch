<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="end">
            <sch:let name="start" value="preceding-sibling::start"/>
            <sch:report test=". lt $start">The end page (<sch:value-of select="."/>) cannot be less
                than the start page (<sch:value-of select="$start"/>)</sch:report>
        </sch:rule>
        <sch:rule context="text()" role="warning">
            <sch:report test="matches(., '[&quot;'']')" role="warning">Text contains straight
                apostrophe or quotation mark</sch:report>
        </sch:rule>
        <sch:rule context="bibItem">
            <sch:report test="not(issue)" role="warning">Issue number is missing</sch:report>
        </sch:rule>
        <sch:rule context="initial">
            <sch:report test="string-length(.) gt 1" role="warning">Author has a middle initial of
                length greater than 1</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>
