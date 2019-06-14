<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="/">
        <xsl:variable name="tagged" as="element(TEI)">
            <TEI>
                <xsl:copy-of select="//teiHeader"/>
                <xsl:apply-templates select="//text"/>
            </TEI>
        </xsl:variable>
        <xsl:sequence select="$tagged"/>
    </xsl:template>
    <xsl:template match="app">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="rdg">
        <xsl:if test="contains(@wit, '#ed1')">
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="note"/>
    <xsl:template match="choice">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="(orig | reg | sic | corr)">
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>
