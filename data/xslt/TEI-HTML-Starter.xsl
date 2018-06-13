<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
     xmlns="http://www.w3.org/1999/xhtml">
    
    <xsl:output method="xhtml" indent="yes" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <!--2018-06-12 ebb: Starter file for a a TEI to HTML transformation.  -->
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:apply-templates select="descendant::titleStmt[1]/title"/>
                </title>
            </head>
            <body> 
                <h1><xsl:apply-templates select="descendant::titleStmt[1]/title"/></h1>
                <h2><xsl:apply-templates select="descendant::titleStmt[1]/author"/></h2>
            
         <xsl:apply-templates select="descendant::publicationStmt[1]"/>  
                <xsl:apply-templates select="descendant::sourceDesc[1]"/>
                <div id="poems">                  
                   <xsl:apply-templates select="descendant::TEI"/>            
                </div>
            </body>

        </html>
    </xsl:template>

<xsl:template match="p">
    <p><xsl:apply-templates/></p>
</xsl:template>
    
    <xsl:template match="ref">
        <a href="{@target}"><xsl:apply-templates select="@target"/></a>
    </xsl:template>


</xsl:stylesheet>
