<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="3.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xhtml" indent="no" omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <section title="schedule">
            <h1>Schedule</h1>
            <p><button id="expand">Expand all</button> | <button id="collapse">Collapse
                all</button></p>
            <xsl:apply-templates/>
        </section>
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
        <xsl:variable name="session_start" as="xs:time" select="xs:time(../@time)"/>
        <!--        <xsl:variable name="act_start" as="xs:time"
            select="$session_start + xs:dayTimeDuration(sum(preceding-sibling::act/@time/xs:dayTimeDuration(.)))"/>
        <xsl:variable name="act_end" as="xs:time" select="$act_start + xs:dayTimeDuration(@time)"/>
-->
        <li>
            <xsl:apply-templates select="image"/>
            <xsl:apply-templates select="desc"/>
            <xsl:value-of
                select="concat(' (', xs:dayTimeDuration(@time) div xs:dayTimeDuration('PT1M'), ' minutes)')"/>
            <xsl:text> </xsl:text>
            <button class="localExpand">Expand</button>
            <xsl:text> | </xsl:text>
            <button class="localCollapse">Collapse</button>
            <xsl:apply-templates select="details"/>
        </li>
    </xsl:template>
    <xsl:template match="code">
        <code>
            <xsl:apply-templates/>
        </code>
        <xsl:if test="@url">
            <xsl:call-template name="pointer"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="pointer">
        <a href="{@url}">
            <sup>⬀</sup>
        </a>
    </xsl:template>
    <xsl:template match="details">
        <ol>
            <xsl:apply-templates/>
        </ol>
    </xsl:template>
    <xsl:template match="item | example">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="emph">
        <em>
            <xsl:apply-templates/>
        </em>
        <xsl:if test="@url">
            <xsl:call-template name="pointer"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="examples">
        <ol>
            <xsl:apply-templates/>
        </ol>
    </xsl:template>
    <xsl:template match="link">
        <a href="{.}">
            <xsl:value-of select="."/>
        </a>
    </xsl:template>
    <xsl:template match="image">
        <img src="images/{.}" alt="{@alt}" title="{@alt}" class="{@size}"/>
    </xsl:template>
    <xsl:template match="q">
        <q>
            <xsl:apply-templates/>
        </q>
    </xsl:template>
</xsl:stylesheet>
