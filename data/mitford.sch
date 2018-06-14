<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <!-- 
        author points to person
        editor points to person
        orgName (in <publicationStmt> and <sourceDesc>, but not elsewhere) points to org
        persName points to person
        placeName points to place
        repository points to org
        title (in <body>, but not elsehwere) points to bibl


        Write (and test) the following  rules:
        
        * The named entity types above should point to the correct type ]in si.xml
        * If any of the seven types above lacks @ref, raise an error        
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
