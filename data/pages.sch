<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="end">
            <sch:report test=". lt preceding-sibling::start">The end page number cannot be less than
                the start page number</sch:report>
        </sch:rule>
        <sch:rule context="text()">
            <sch:report test="matches(., '[&quot;'']')">Text contains straight
                apostrophe or quotation mark</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>
