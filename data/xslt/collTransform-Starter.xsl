<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xhtml" indent="yes" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
   
   <xsl:variable name="dickinsonColl" as="element()+" select="collection('http://newtfire.org:8338/exist/rest/db/Dickinson-DHSI/*')"/>
    
    <xsl:template match="/">
        <html>
            <head><title>Dickinson Collection</title></head>
            <body>
          <xsl:apply-templates select="$dickinsonColl/*"/>                   
            </body>
        </html>      
    </xsl:template>
    <xsl:template match="titleStmt/title">
        <h2><xsl:apply-templates/></h2> 
    </xsl:template>
    
    
</xsl:stylesheet>