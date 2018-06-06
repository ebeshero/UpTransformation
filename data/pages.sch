<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="end">
            <sch:report test=". lt preceding-sibling::start">The end page cannot be less than the
                start page</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>
