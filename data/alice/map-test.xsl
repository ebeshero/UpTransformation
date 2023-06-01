<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="3.0">
    <!-- Example of using maps to retrieve occupation values-->
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="occupationPrefix"
        select="'http://www.wikidata.org/wiki/Special:EntityData/Q'"/>
    <xsl:variable name="testing" as="map(xs:string, xs:string)">
        <xsl:map>
            <xsl:map-entry key="'Writer'" select="'36180'"/>
            <xsl:map-entry key="'Actor'" select="'33999'"/>
            <xsl:map-entry key="'Musician'" select="'639669'"/>
            <xsl:map-entry key="'Photographer'" select="'33231'"/>
            <xsl:map-entry key="'Poet'" select="'49757'"/>
        </xsl:map>
    </xsl:variable>
    <xsl:template match="/">
        <output>
            <xsl:for-each select="('Writer', 'Poet')">
                <result>
                    <xsl:sequence select="concat(current(), ': ', $occupationPrefix, $testing(current()), '.rdf')"/>
                </result>
            </xsl:for-each>
        </output>
    </xsl:template>
</xsl:stylesheet>
