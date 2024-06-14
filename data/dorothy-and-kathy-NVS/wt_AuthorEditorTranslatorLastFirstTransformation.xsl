<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.mla.org/NVSns"
    xmlns="http://www.mla.org/NVSns" exclude-result-prefixes="xs" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template
        match='(bibl[not(ancestor::bibl)]/author | bibl[not(ancestor::bibl)]/editor | bibl[not(ancestor::bibl)]/translator)
        [not(*)][not(contains(., ","))][contains(., " ")]'>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:variable name="namePieces" as="xs:string+" select="tokenize(normalize-space(.))"/>
            <xsl:value-of
                select="concat($namePieces[last()], ', ', string-join($namePieces[not(last())]), ' ')"
            />
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
