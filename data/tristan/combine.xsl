<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xmlns="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <!--
        Author, date, license: djb, 2019-0-6-15, CC-0
        Input is TEI file with <rs type="object"> tags around text originally in upper case
            These <rs> elements are guaranteed to have only a single text node as aa child
        Task is to unify <rs> elements with following <rs>, <lb>, and <pb> elements as a single <rs>
            (including any intervening whitespace text nodes)
    -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:mode name="embedded" on-no-match="shallow-copy"/>

    <!-- first <rs> -->
    <xsl:template match="*/rs[@type eq 'object']">
        <xsl:copy>
            <xsl:copy-of select="@*, node()"/>
            <xsl:apply-templates mode="embedded" select="following-sibling::node()[1]"/>
        </xsl:copy>
    </xsl:template>

    <!-- embedded rs -->
    
    <!-- embedded non-rs -->
    
    <!-- erroneous embedded -->

</xsl:stylesheet>
