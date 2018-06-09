<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="salutation | p | valediction | signature">
            <sch:report test="empty(node()) and string-length(normalize-space(.)) eq 0">Element of
                type "<sch:value-of select="name()"/>" cannot be empty</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>
