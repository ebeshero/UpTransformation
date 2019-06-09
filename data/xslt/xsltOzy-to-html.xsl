<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"/>
    <!--ebb: We will write templates rules here. -->
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:apply-templates select="descendant::meta/title"/>
                </title>
                <style type="text/css">
                    body {
                        padding: 2em;
                    }
                    h1,
                    h2,
                    p,
                    div {
                        padding: .5em;
                    }
                    span.lineNum {
                        font-size: smaller;
                        color: maroon;
                        padding-left: 1em;
                    }</style>
            </head>
            <body>
                <h1>
                    <xsl:apply-templates select="descendant::meta/title"/>
                </h1>
                <h2>by <xsl:apply-templates select="descendant::author"/></h2>
                <p>Published in <xsl:apply-templates select="descendant::publication"/></p>
                <xsl:apply-templates select="descendant::poem"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="publication">
        <i>
            <xsl:apply-templates select="child::title"/>
        </i>
        <xsl:text>, </xsl:text>
        <xsl:apply-templates select="pubPlace"/>
        <xsl:text>: </xsl:text>
        <xsl:value-of select="format-date(date/@when, '[D1o] [MNn], [Y]', 'en', (), ())"/>
        <!--ebb: For the picture string on format-date() see https://www.w3.org/TR/xpath-functions-31/#date-time-examples -->
    </xsl:template>
    <xsl:template match="poem">
        <div class="poem">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="line">
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
        <span class="lineNum">
            <xsl:value-of select="count(preceding::line) + 1"/>
        </span>
        <br/>
    </xsl:template>

</xsl:stylesheet>
