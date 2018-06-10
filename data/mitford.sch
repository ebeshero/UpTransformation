<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <sch:let name="si"
        value="doc('https://raw.githubusercontent.com/ebeshero/UpTransformation/master/data/si.xml')"/>
    <sch:pattern>
        <sch:rule context="(tei:editor | tei:respStmt/tei:persName)/@ref">
            <sch:p>Editors and responsible persons are members of either 'Mitford_Team' or
                'Past_Assistants'</sch:p>
            <sch:assert
                test="substring(., 2) = $si//tei:listPerson[@sortKey = ('Mitford_Team', 'Past_Assistants')]/tei:person/@xml:id"
                    >&lt;<sch:value-of select="name(..)"/>&gt; elements must point to &lt;person&gt;
                children of &lt;listPerson sortKey = ('Mitford_Team',
                'Past_Assistants')&gt;</sch:assert>
        </sch:rule>
        <sch:rule context="tei:publicationStmt//tei:orgName/@ref">
            <sch:p>Organizations in the publicationStmt are members of listOrg[@sortKey eq
                'archives']</sch:p>
            <sch:assert
                test="substring(., 2) = $si//tei:listOrg[@sortKey = 'archives']/tei:org/@xml:id"
                >&lt;orgName&gt; descendants of &lt;publicationStmt&gt; must point to &lt;org&gt;
                elements inside &lt;listOrg @sortKey='archives'&gt;</sch:assert>
        </sch:rule>
        <!--
            rs[@type='person'] is equivalent to persName
            
            titleStmt/title/persName -> histPersons
            body//persName -> histPersons
            
            repository -> archives
        
        -->
    </sch:pattern>
</sch:schema>
