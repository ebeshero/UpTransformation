<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="sentence">
            <sch:let name="orth_spaces" value="count(tokenize(orth, '\s+'))"/>
            <sch:let name="translit_spaces" value="count(tokenize(translit, '\s+'))"/>
            <sch:let name="ilg_spaces" value="count(tokenize(ilg, '\s+'))"/>
            <sch:let name="orth_hyphens" value="count(tokenize(orth, '-'))"/>
            <sch:let name="translit_hyphens" value="count(tokenize(translit, '-'))"/>
            <sch:let name="ilg_hyphens" value="count(tokenize(ilg, '-'))"/>
            <sch:assert
                test="count(distinct-values(($orth_spaces, $translit_spaces, $ilg_spaces))) eq 1"
                >Space counts disagree: orth = <sch:value-of select="$orth_spaces"/>, translit =
                    <sch:value-of select="$translit_spaces"/>, ilg = <sch:value-of
                    select="$ilg_spaces"/></sch:assert>
            <sch:assert
                test="count(distinct-values(($orth_hyphens, $translit_hyphens, $ilg_hyphens))) eq 1"
                >Hyphen counts disagree: orth = <sch:value-of select="$orth_hyphens"/>, translit =
                    <sch:value-of select="$translit_hyphens"/>, ilg = <sch:value-of
                    select="$ilg_hyphens"/></sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
