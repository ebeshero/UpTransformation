<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="sentence">
            <sch:assert
                test="count(distinct-values((count(tokenize(orth, ' ')), count(tokenize(translit, ' ')), count(tokenize(ilg, ' '))))) eq 1"
                >Space counts disagree</sch:assert>
            <sch:assert
                test="count(distinct-values((count(tokenize(orth, '-')), count(tokenize(translit, '-')), count(tokenize(ilg, '-'))))) eq 1"
                >Hyphen counts disagree</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
