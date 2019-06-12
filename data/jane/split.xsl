<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0" version="3.0">
    <xsl:template match="/">
        <xsl:apply-templates select="//body/div"/>
    </xsl:template>
    <xsl:template match="div">
        <xsl:result-document href="{@xml:id/string()}.xml">
            <TEI>
                <xsl:copy-of select="root()//teiHeader"/>
                <text>
                    <body>
                        <xsl:copy-of select="."/>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
