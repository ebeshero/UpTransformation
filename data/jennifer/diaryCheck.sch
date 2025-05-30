<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <!-- 2025-05-30 ebb: Remember, we need the TEI namespace. -->
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>

    <sch:pattern>
        <sch:rule context="tei:dateline/tei:date" role="error">
            <sch:assert
                test="not(preceding::tei:dateline/tei:date) or xs:date(@when) gt xs:date(preceding::tei:dateline[1]/tei:date/@when)"
                > Every date must be later than the previous date. Current date here is
                    <sch:value-of select="xs:date(@when)"/>. Immediately preceding date is
                    <sch:value-of select="xs:date(preceding::tei:dateline/tei:date/@when)[1]"/>. </sch:assert>


        </sch:rule>


    </sch:pattern>



</sch:schema>
