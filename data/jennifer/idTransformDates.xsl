<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">

    <xsl:output method="xml" indent="yes"/>

    <xsl:mode on-no-match="shallow-copy"/>

    <!-- 2025-05-30 This is an identity transformation to apply <date> elements  with the 
        @when attribute holding an ISO encoded date in the TEI encoding of the MVM diary
        inside the dateline. 
    -->
    <xsl:variable name="monthLookup" as="map(*)" select="
            map {
                'January': '01',
                'February': '02',
                'March': '03',
                'April': '04',
                'May': '05',
                'June': '06',
                'July': '07',
                'August': '08',
                'September': '09',
                'October': '10',
                'November': '11',
                'December': '12'
            }"/>

    <xsl:template match="dateline">
        <xsl:variable name="dateTokens" as="xs:string+"
            select="normalize-space() ! tokenize(., '[ ,.]+') ! translate(., '[]', '')"/>
        

        <xsl:copy>
            <date
                when="{$dateTokens[4]}-{$monthLookup($dateTokens[2])}-{replace($dateTokens[3], '[A-Za-z]', '') ! xs:integer(.) ! format-integer(., '00')}">
                <xsl:apply-templates/>
            </date>
        </xsl:copy>
    </xsl:template>



</xsl:stylesheet>
