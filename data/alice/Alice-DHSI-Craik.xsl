<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:schema="https://schema.org/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c/ns/1.0"
    xmlns:owl="http://www.w3.org/TR/2004/REC-owl-guide-20040210/"
    xmlns:fa="http://www.w3.org/2005/xpath-functions"
    xmlns:cwrc="http://sparql.cwrc.ca/ontologies/cwrc.html"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    exclude-result-prefixes="cwrc xsl schema rdf tei fa owl xs"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="3.0">
    <xsl:output method="xml" encoding="UTF-16" indent="yes"/>
    <xsl:key name="personById" match="person" use="@xml:id"/>
    <xsl:key name="relationById" match="relation" use="tokenize(@mutual) ! substring-after(., '#')"/>
    <xsl:variable name="occupationPrefix"
        select="'http://www.wikidata.org/wiki/Special:EntityData/Q'"/>
    <xsl:variable name="occupations" as="map(xs:string, xs:string)">
        <xsl:map>
            <!-- add more entries for other occupations -->
            <xsl:map-entry key="'Writer'" select="'36180'"/>
            <xsl:map-entry key="'Actor'" select="'33999'"/>
            <xsl:map-entry key="'Musician'" select="'639669'"/>
            <xsl:map-entry key="'Photographer'" select="'33231'"/>
            <xsl:map-entry key="'Poet'" select="'49757'"/>
        </xsl:map>
    </xsl:variable>

    <xsl:template match="/">
        <rdf:RDF xml:lang="en" xmlns:cwrc="http://sparql.cwrc.ca/ontologies/cwrc.html"
            xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:schema="http://schema.org/"
            xmlns:owl="http://www.w3.org/2002/07/owl#">
            <xsl:apply-templates select="descendant::div[4]/listPerson"/>
        </rdf:RDF>
    </xsl:template>

    <xsl:template match="listPerson">
        <xsl:apply-templates select="person"/>
    </xsl:template>

    <xsl:template match="person">
        <xsl:variable name="myId" select="@xml:id"/>
        <schema:Person rdf:about="{concat('http://example.org/tei#',@xml:id)}">
            <owl:sameAs xml:lang="en"
                rdf:resource="{concat('https://www.wikidata.org/wiki/Special:EntityData/','Q')}"/>
            <xsl:apply-templates select="@sex"/>
            <xsl:apply-templates/>
            <xsl:variable name="relations" as="element(relation)*"
                select="key('relationById', @xml:id)"/>
            <xsl:for-each select="$relations">
                <xsl:variable name="relationshipType" as="xs:string" select="@name"/>
                <xsl:for-each select="tokenize(@mutual, ' ')[substring-after(., '#') != $myId]">
                    <xsl:element name="{concat('schema:', $relationshipType)}">
                        <xsl:attribute name="rdf:about" select="concat('http://example.org/tei', .)"
                        />
                    </xsl:element>
                </xsl:for-each>
                <!-- interim diagnostic information
                    <xsl:variable name="who" as="xs:string+"
                        select="tokenize(@mutual, ' ') ! substring-after(., '#')[. != $myId]"/>
                    <xsl:variable name="relationship" select="@name" as="xs:string"/>
                    <stuff><xsl:value-of select="$who"/> is in a <xsl:value-of
                            select="$relationship"/> relationship with <xsl:value-of select="$myId"
                        /></stuff>-->
            </xsl:for-each>
        </schema:Person>
    </xsl:template>

    <xsl:template match="@sex">
        <xsl:variable name="gender" as="xs:string">
            <xsl:choose>
                <xsl:when test=". eq '1'">man</xsl:when>
                <xsl:when test=". eq '2'">woman</xsl:when>
                <xsl:otherwise>ERROR</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <cwrc:hasGender rdf:resource="{concat('http://sparql.cwrc.ca/testing/cwrc#', $gender)}"/>
    </xsl:template>

    <!-- prevent the output of <label> and <desc> content -->
    <xsl:template match="label | desc"/>

    <xsl:template match="forename">
        <schema:givenName>
            <xsl:value-of select="."/>
        </schema:givenName>
    </xsl:template>

    <xsl:template match="addName">
        <schema:additionalName>
            <xsl:value-of select="."/>
        </schema:additionalName>
    </xsl:template>

    <xsl:template match="genName">
        <schema:additionalName>
            <xsl:value-of select="."/>
        </schema:additionalName>
    </xsl:template>
    <!-- FIND PROPER SCHEMA TAG -->

    <xsl:template match="surname[@type = 'married']">
        <schema:familyName>
            <xsl:value-of select="."/>
        </schema:familyName>
    </xsl:template>

    <xsl:template match="surname[@type = 'maiden']">
        <schema:additionalName>
            <xsl:value-of select="."/>
        </schema:additionalName>
    </xsl:template>

    <xsl:template match="surname[not(@type)]">
        <schema:additionalName>
            <xsl:value-of select="."/>
        </schema:additionalName>
    </xsl:template>

    <xsl:template match="roleName">
        <schema:rolename>
            <xsl:value-of select="."/>
        </schema:rolename>
    </xsl:template>
    <!-- FIND PROPER SCHEMA TAG -->

    <xsl:template match="birth">
        <schema:birthDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">
            <xsl:value-of select="@when"/>
        </schema:birthDate>
    </xsl:template>

    <xsl:template match="death">
        <schema:deathDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">
            <xsl:value-of select="@when"/>
        </schema:deathDate>
    </xsl:template>

    <xsl:template match="note[@type = 'bio']">
        <schema:description>
            <xsl:value-of select="."/>
        </schema:description>
    </xsl:template>

    <xsl:template match="occupation">
        <xsl:choose>
            <xsl:when test="map:contains($occupations, current())">
                <cwrc:Occupation
                    rdf:resource="{concat($occupationPrefix, $occupations(current()), '.rdf')}"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:comment>No URI for occupation <xsl:value-of select="current()"/></xsl:comment>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--    <xsl:template match="occupation">
        <cwrc:Occupation/>
        <cwrc:hasOccupation/>
    </xsl:template>
-->
    <!-- <xsl:template match="occupation[text() = 'Writer']">
        <cwrc:Occupation rdf:resource="http://sparql.cwrc.ca/testing/cwrc#writer"/>
        <cwrc:hasOccupation rdf:resource="http://www.wikidata.org/wiki/Special:EntityData/Q36180.rdf"/>
    </xsl:template>-->

    <!-- To do : 
        finish to process all occupations' URIs -->

    <xsl:template match="nationality">
        <cwrc:NationalIdentity/>
        <cwrc:hasNationality/>
    </xsl:template>

    <!-- <xsl:template match="nationality[text()='English']">
        <cwrc:NationalIdentity rdf:resource="http://sparql.cwrc.ca/testing/cwrc#EnglishNationalIdentity"/>
    </xsl:template>-->

    <!-- To do : 
        finish to process all nationalities' URIs-->



    <!-- RELATIONSHIPS -->

    <!-- 
        
        CONNIE's Tryouts
        
    <xsl:key name="personByAssociate" match="relation" use="tokenize(@mutual, '\s+')"/>
    <xsl:variable name="root" select="/"/>
    <xsl:variable name="persons"
        select="distinct-values(tokenize(string-join(//@mutual, ' '), '\s+'))"/>

    <xsl:template match="/">
        <stuff>
            <xsl:for-each select="$persons">
                <xsl:sort/>
                <xsl:variable name="relationships" select=""/>
    <person>
        <me>I am <xsl:value-of select="."/></me>
        <friends>
            <friends>
                <xsl:sequence select="distinct-values(tokenize(string-join(key('personByAssociate', ., $root)/@mutual, ' '), '\s+'))[. != current()]"/>
            </friends>
        </friends>
    </person>
    </xsl:for-each>
    </stuff>
    </xsl:template> 
    -->

</xsl:stylesheet>
