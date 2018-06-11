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

        There are four entries in the <back>, two <person> and two <bibl>. 
        
        The following  rules are the same for the preceding example:
        
        * The named entity types above should point to the correct type (@sortKey) in si.xml
        * If any of the seven types above lacks @ref, raise an error     
        
        The following are new:
        
        * If a @ref points only to <back>, but not si.xml, raise "info"
        * If a @ref points to both <back> and si.xml, raise "warning"
        * If a @ref points to neither <back> nor si.xml, raise an error
    -->
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <sch:let name="si"
        value="doc('https://raw.githubusercontent.com/ebeshero/UpTransformation/master/data/si.xml')"/>
    <sch:pattern>
        <sch:rule
            context="(tei:author | tei:editor | tei:persName | tei:placeName | tei:repository | (tei:sourceDesc | tei:publicationStmt)//tei:orgname | tei:body//tei:title)">
            <sch:report test="not(ancestor::tei:back) and not(@ref)">&lt;<sch:value-of
                    select="name()"/>&gt; is missing @ref attribute</sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <sch:p>Seven types of named entities with @ref attributes point to correct site index types
            and not to &lt;back&gt; </sch:p>
        <sch:rule
            context="(tei:author | tei:editor | tei:persName)[@ref[not(substring(., 2) = //tei:back//@xml:id)]]">
            <sch:assert test="substring(@ref, 2) = $si//tei:person/@xml:id">Should point to a
                &lt;person&gt; element in the site index</sch:assert>
        </sch:rule>
        <sch:rule
            context="((tei:sourceDesc | tei:publicationStmt)//tei:orgName | tei:repository)[@ref[not(substring(., 2) = //tei:back//@xml:id)]]">
            <sch:assert test="substring(@ref, 2) = $si//tei:org/@xml:id">Should point to an
                &lt;org&gt; element in the site index</sch:assert>
        </sch:rule>
        <sch:rule context="tei:placeName[@ref[not(substring(., 2) = //tei:back//@xml:id)]]">
            <sch:assert test="substring(@ref, 2) = $si//tei:place/@xml:id">Should point to a
                &lt;place&gt; element in the site index</sch:assert>
        </sch:rule>
        <sch:rule context="tei:body//tei:title[@ref[not(substring(., 2) = //tei:back//@xml:id)]]">
            <sch:assert test="substring(@ref, 2) = $si//tei:bibl/@xml:id">Should point to a
                &lt;place&gt; element in the site index</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <sch:p>Points to &lt;back&gt;</sch:p>
        <sch:rule context="@ref[substring(., 2) = //tei:back//@xml:id]">
            <sch:report role="info" test="not(substring(., 2) = $si//@xml:id)"><sch:value-of
                    select="."/> points to &lt;back&gt; but not site index</sch:report>
            <sch:report role="warning" test="substring(., 2) = $si//@xml:id"><sch:value-of
                    select="."/> points to &lt;back&gt; and site index</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>
