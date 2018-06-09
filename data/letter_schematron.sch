<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:let name="ancillary"
        value="doc('https://raw.githubusercontent.com/ebeshero/UpTransformation/master/data/letter_schematron_ancillary.xml')"/>
    <sch:pattern>
        <sch:rule context="persName/@ref">
            <sch:let name="ref" value="substring(., 2)"/>
            <sch:assert test="$ref = $ancillary//person/@xml:id">Person reference <sch:value-of
                    select="$ref"/> is not in the ancillary reference list: (<sch:value-of
                    select="string-join($ancillary//person/@xml:id, ', ')"/>)</sch:assert>
        </sch:rule>
        <sch:rule context="eventName/@ref">
            <sch:let name="ref" value="substring(., 2)"/>
            <sch:assert test="$ref = $ancillary//event/@xml:id">Event reference <sch:value-of
                    select="$ref"/> is not in the ancillary reference list</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
