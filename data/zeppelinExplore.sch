<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:pattern>
        <sch:rule role="warning" context="chordLine">
            <sch:report test="count(child::chord) lt 3">Warning! The count of chords in the line is less than three. Is this correct?</sch:report>
        </sch:rule>
        
        <sch:rule role="info" context="chord[@num='4/6']">
            <sch:assert test="text() ! normalize-space() = 'A/C#'">Are chords marked with 4/6 always displayed as A/C#?
            If not, the value is <sch:value-of select="text()"/>.</sch:assert>
        </sch:rule>
        
        
    </sch:pattern>
    
</sch:schema>