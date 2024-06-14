<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="http://www.mla.org/NVSns" prefix="NVS"/>
    <sch:pattern>
        <sch:rule context="NVS:author | NVS:editor | NVS:translator">
            <sch:assert role="information" test="contains(., ',')">every author, translator, and
                editor in the bibliography should be listed as "last name, first name"</sch:assert>
            <sch:report test="normalize-space() ! string-length(.) eq 0">
                <sch:value-of select="name()"/> cannot be empty </sch:report>
        </sch:rule>

        <sch:rule context="NVS:bibl[not(ancestor::NVS:bibl)]">
            <sch:assert
                test="descendant::NVS:author | descendant::NVS:editor | descendant::NVS:translator"
                >Each bibliographic entry must have either an author or an editor or a
                translator</sch:assert>
        </sch:rule>


    </sch:pattern>

</sch:schema>
