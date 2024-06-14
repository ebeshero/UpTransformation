<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:let name="ancillary"
        value="doc('letter_schematron_ancillary.xml')"/>
    
   
    <sch:pattern id="X-context">
        <sch:rule context="salutation | p | valediction | signature">
            <sch:report test="not(*) and string-length(normalize-space(.)) eq 0">Element of
                type "<sch:value-of select="name()"/>" cannot be empty</sch:report>
        </sch:rule>
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
    <sch:pattern>
        <sch:title>All rules dealing with X </sch:title>
        
    </sch:pattern>
   
</sch:schema>
