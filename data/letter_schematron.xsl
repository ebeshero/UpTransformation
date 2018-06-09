<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"/>
    <xsl:variable name="ancillary" as="document-node()"
        select="doc('https://raw.githubusercontent.com/ebeshero/UpTransformation/master/data/letter_schematron_ancillary.xml')"/>
    <xsl:key name="refByPointer" match="person | event" use="@xml:id"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:apply-templates select="//header/title"/>
                </title>
                <link rel="stylesheet" type="text/css" href="../style.css"/>
                <style type="text/css">
                    p.center {
                        text-align: center;
                    }
                    span {
                        border: 1px blue dotted;
                        padding: 1px;
                    }</style>
            </head>
            <body>
                <xsl:apply-templates select="//text"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="date">
        <p class="center">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="salutation">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="valediction">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="signature">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="persName">
        <span>
            <xsl:attribute name="title"
                select="string-join((key('refByPointer', substring(@ref, 2), $ancillary)/name, key('refByPointer', substring(@ref, 2), $ancillary)/affiliation), '&#x0a;')"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="eventName">
        <span>
            <xsl:attribute name="title"
                select="string-join((key('refByPointer', substring(@ref, 2), $ancillary)/title, key('refByPointer', substring(@ref, 2), $ancillary)/location), '&#x0a;')"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>
