<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <!-- 
        editor points to person (done)
        orgName points to org
        persName points to person
        placeName points to place
        repository points to org
        title points to bibl
    -->
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <sch:let name="si"
        value="doc('https://raw.githubusercontent.com/ebeshero/UpTransformation/master/data/si.xml')"/>
    <sch:pattern>
        <sch:rule context="tei:editor">
            <sch:assert test="substring(@ref, 2) = $si//tei:person/@xml:id">Should point to a
                &lt;person&gt; element in the site index</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
