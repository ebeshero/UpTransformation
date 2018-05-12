<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="3.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Schedule</title>
                <link rel="stylesheet" type="text/css" href="http://www.obdurodon.org/css/style.css"/>
            </head>
            <body>
                <h1>Schedule</h1>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="day">
        <section>
            <xsl:apply-templates/>
        </section>
    </xsl:template>
    <xsl:template match="day/title">
        <h2>
            <xsl:apply-templates select="concat(../@d, ': ', .)"/>
        </h2>
    </xsl:template>
    <xsl:template match="slot">
        <section>
            <xsl:apply-templates select="title"/>
            <ul>
                <xsl:apply-templates select="act"/>
            </ul>
        </section>
    </xsl:template>
    <xsl:template match="slot/title">
        <xsl:variable name="duration"
            select="xs:time(../@time) + sum(following-sibling::act/@time/xs:dayTimeDuration(.))"/>
        <h3>
            <xsl:value-of
                select="concat(., ' (', format-time(xs:time(../@time), '[h]:[m01] [Pn]'), '–', format-time($duration, '[h]:[m01] [Pn]'), ')')"
            />
        </h3>
    </xsl:template>
    <xsl:template match="act">
        <li>
            <xsl:apply-templates select="desc"/>
            <xsl:value-of select="concat(' (', xs:dayTimeDuration(@time) div xs:dayTimeDuration('PT1M'), ' minutes)')"/>
        </li>
    </xsl:template>
    <xsl:template match="code">
        <code>
            <xsl:apply-templates/>
        </code>
    </xsl:template>
</xsl:stylesheet>
