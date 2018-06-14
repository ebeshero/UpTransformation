<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:djb="http://www.obdurodon.org"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math" version="3.0" xmlns="http://www.w3.org/1999/xhtml">
    <!--
        exist-collection-test.xsl
        imports exist-colleciton.xsl from the same directory
        access the documents in an eXist collection
    -->
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"/>
    <xsl:import href="exist-collection.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="poems" as="document-node()*"
            select="djb:exist-collection('http://newtfire.org:8338/exist/rest/db/dickinson/f6')"/>
        <html>
            <head>
                <title>Hi, Mom!</title>
            </head>
            <body>
                <h1>Some Dickinsoniana</h1>
                <p/>
                <ul>
                    <xsl:apply-templates select="$poems//tei:titleStmt/tei:title"/>
                </ul>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:title">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
</xsl:stylesheet>
