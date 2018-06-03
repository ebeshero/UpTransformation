<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:djb="http://www.obdurodon.org"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:function name="djb:format-time" as="xs:string">
        <xsl:param name="input" as="xs:time" required="yes"/>
        <xsl:value-of select="format-time($input, '[h]:[m01] [Pn]')"/>
    </xsl:function>
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
                select="concat(., ' (', djb:format-time(../@time), '–', djb:format-time($duration), ')')"
            />
        </h3>
    </xsl:template>
    <xsl:template match="act">
        <xsl:variable name="session_start" as="xs:time" select="xs:time(../@time)"/>
        <!-- add PT0M to force type in cases where total is 0 -->
        <xsl:variable name="act_start" as="xs:time"
            select="$session_start + sum(preceding-sibling::act/@time/xs:dayTimeDuration(.), xs:dayTimeDuration('PT0M'))"/>
        <xsl:variable name="act_end" as="xs:time" select="$act_start + xs:dayTimeDuration(@time)"/>
        <li>
            <xsl:apply-templates select="image"/>
            <xsl:apply-templates select="desc"/>
            <xsl:value-of
                select="
                    concat(' (', xs:dayTimeDuration(@time) div xs:dayTimeDuration('PT1M'), ' minutes; ',
                    djb:format-time($act_start), '–', djb:format-time($act_end), ')')"/>
            <xsl:text> </xsl:text>
            <xsl:if test="details">
                <span class="buttons">
                    <button class="localExpand">Expand</button>
                    <xsl:text>&#xa0;|&#xa0;</xsl:text>
                    <button class="localCollapse">Collapse</button>
                </span>
                <xsl:apply-templates select="details"/>
            </xsl:if>
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
    <xsl:template match="answer">
        <!-- ensure at least one space between the question and the button -->
        <xsl:text> </xsl:text>
        <button class="answer">Answer</button>
        <!-- ensure at least one space between the button and the answer-->
        <xsl:text> </xsl:text>
        <span class="answer">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>
