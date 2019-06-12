<?xml version="1.0" encoding="UTF-8"?>
<!--
    What it does: Transform collection of EAD documents to consolidated XHTML report
    Date, author, license: 2019-06-12 djb, CC-0
    
    Inside the root <xsl:stylesheet element:
    
    Set @xpath-default-namespace to namespace of input documents (EAD): urn:isbn:1-931666-22-9
    Set @xmlns to namespace of output document (HTML): http://www.w3.org/1999/xhtml
    Reset @exclude-result-prefixes to "#all"
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="urn:isbn:1-931666-22-9"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    <!-- 
        Global variables:

        $ads points to subdirectory called UU_SPC_AV_EADs, which contains EAD files
    -->
    <xsl:variable name="eads" as="document-node()+" select="collection('UU_SPC_AV_EADs')"/>
    <xsl:variable name="subject_headings" as="xs:string*"
        select="distinct-values($eads//controlaccess/subject)"/>
    <!-- end of global variables -->
    <xsl:template match="/">
        <html>
            <head>
                <title>EAD report</title>
            </head>
            <body>
                <h1>EAD report</h1>
                <h2>Subject headings</h2>
                <ul>
                    <xsl:for-each select="$subject_headings">
                        <xsl:sort/>
                        <li>
                            <xsl:sequence select="."/>
                        </li>
                    </xsl:for-each>
                </ul>
                <h2>Biographical notes</h2>
                <xsl:apply-templates select="$eads//bioghist">
                    <xsl:sort select="head"/>
                </xsl:apply-templates>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="bioghist">
        <h3>
            <xsl:choose>
                <xsl:when test="head">
                    <xsl:apply-templates select="head"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>[No head]</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </h3>
        <p>
            <xsl:apply-templates select="node() except head"/>
        </p>
    </xsl:template>
</xsl:stylesheet>
