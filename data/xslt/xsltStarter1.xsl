<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xhtml" indent="yes" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>

<!--ebb: We will write templates rules here. -->
<xsl:template match="/">
    <html>
        <head><title><xsl:apply-templates select="descendant::meta/title"/></title>
        </head>
        <body>
            <h1><xsl:apply-templates select="descendant::meta/title"/></h1>
         <h2>by <xsl:apply-templates select="descendant::author"/></h2>  
            <p>Published in <xsl:apply-templates select="descendant::publication"/></p>
            <xsl:apply-templates select="descendant::poem"/>
        </body>       
    </html>
</xsl:template>
   <xsl:template match="publication">
       <i><xsl:apply-templates select="child::title"/></i><xsl:text>, </xsl:text><xsl:apply-templates select="pubPlace"/><xsl:text>: </xsl:text><xsl:value-of select="format-date(date, '[D1o] [MNn], [Y]', 'en', (), ())"/>
   </xsl:template>
    
</xsl:stylesheet>