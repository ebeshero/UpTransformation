<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs math" version="3.0">

    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:mode name="unflatten" on-no-match="shallow-copy"/>

    <xsl:template match="/">
        <xsl:variable name="removed-hi">
            <xsl:apply-templates/>
        </xsl:variable>
        <xsl:apply-templates select="$removed-hi" mode="unflatten"/>
    </xsl:template>

    <xsl:template match="hi[@rend = 'bold']">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="p" mode="unflatten">
        <xsl:analyze-string select="." regex="&lt;(pb) (n)=(\S+)/&gt;" flags="s">
            <xsl:matching-substring>
                <xsl:element name="{regex-group(1)}">
                    <xsl:attribute name="{regex-group(2)}">
                        <xsl:value-of select='regex-group(3) ! replace(., """", "")'/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:analyze-string select="." regex="">
                    <xsl:matching-substring>
                        
                    </xsl:matching-substring> 
                    <xsl:non-matching-substring>
                        <xsl:value-of select="."/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>

</xsl:stylesheet>
