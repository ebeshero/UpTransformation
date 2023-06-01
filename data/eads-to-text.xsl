<?xml version="1.0" encoding="UTF-8"?>
<!--
    What it does: Transform collection of EAD documents to consolidated XHTML report
    Date, author, license: 2019-06-12 djb, CC-0
    
    Inside the root <xsl:stylesheet> element:
    
    Set @xpath-default-namespace to namespace of input documents (EAD): urn:isbn:1-931666-22-9
    Reset @exclude-result-prefixes to "#all"
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="urn:isbn:1-931666-22-9"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <!-- 
        Global variables:

        $ads points to subdirectory called UU_SPC_AV_EADs, which contains EAD files
    -->
    <xsl:variable name="eads" as="document-node()+" select="collection('UU_SPC_AV_EADs')"/>
    <!-- end of global variables -->
    <xsl:template match="/">
        <!-- plain-text list of subjects -->
        <xsl:result-document href="subjects.txt" method="text">
            <xsl:for-each select="sort(distinct-values($eads//controlaccess/subject))">
                <xsl:value-of select="concat(., '&#x0a;')"/>
            </xsl:for-each>
        </xsl:result-document>
        <!-- tsv output of subjects with sources -->
        <xsl:result-document href="subjects.tsv" method="text">
            <xsl:for-each-group select="$eads//controlaccess/subject" group-by="concat(., @source)">
                <xsl:sort select="current-grouping-key()"/>
                <xsl:value-of select="string-join((., @source), '&#x009;') || '&#x0a;'"/>
            </xsl:for-each-group>
        </xsl:result-document>
        <!-- plain text list of bioghist values -->
        <xsl:result-document href="bioghists.txt" method="text">
            <xsl:for-each select="$eads//bioghist">
                <xsl:value-of select="concat(normalize-space(.), '&#x0a;')"/>
            </xsl:for-each>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
