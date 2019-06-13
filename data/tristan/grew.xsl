<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <!--
        matches 2 or more UC characters, optionally followed by one or more
        sequences of white space and UC characters (that is, multiple words) 
    -->
    <xsl:variable name="uc" as="xs:string" select="'[A-ZÆ]{2,}(\s+([A-ZÆ]{2,}))*'"/>
    <xsl:template match="/">
        <xsl:variable name="capitalized" as="document-node()">
            <xsl:document>
                <xsl:apply-templates/>
            </xsl:document>
        </xsl:variable>
        <xsl:sequence select="$capitalized"/>
    </xsl:template>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="text()">
        <xsl:analyze-string select="." regex="{$uc}">
            <xsl:matching-substring>
                <rs type="object">
                    <xsl:value-of select="."/>
                </rs>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
</xsl:stylesheet>
