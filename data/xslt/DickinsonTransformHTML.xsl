<?xml version="1.0" encoding="UTF-8"?>
    <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
        xmlns="http://www.w3.org/1999/xhtml"       xpath-default-namespace="http://www.tei-c.org/ns/1.0">
        
        <xsl:output method="xhtml" indent="yes" doctype-system="about:legacy-compat"
            omit-xml-declaration="yes"/>
<xsl:template match="/">
  <html>
      <head><title><xsl:apply-templates select="(descendant::titleStmt/title)[1]"/></title>
          <style type="text/css">
              body {padding:2em;}
              h1, h2, p, div {padding:.5em;}
              span.lineNum {font-size:smaller; color:maroon; padding-left:1em;}
              
          </style>
      </head>
      <body>
          <h1><xsl:apply-templates select="(descendant::titleStmt/title)[1]"/></h1>
          <h2><xsl:apply-templates select="(descendant::titleStmt/author)[1]"/></h2>
          <xsl:apply-templates select="descendant::TEI"/>
          
          
      </body>
  </html>  
</xsl:template>   
 
<xsl:template match="TEI">
   <div id="p{descendant::idno}">
    
    <xsl:apply-templates select="text"/>
   </div> 
</xsl:template>
        <xsl:template match="text//title">
            <h3><xsl:apply-templates/></h3>           
        </xsl:template>
        
      <xsl:template match="lg">
          <p><xsl:apply-templates/></p> 
      </xsl:template>
        <xsl:template match="l">
           <span class="lineNum"><xsl:value-of select="count(preceding::l[ancestor::TEI = current()/ancestor::TEI]) + 1"/><xsl:text>    </xsl:text></span><xsl:apply-templates/><br/>
        </xsl:template>
    
<xsl:template match="app">
 <span class="app">
        <xsl:apply-templates/>
 </span>                                              
</xsl:template>
<xsl:template match="rdg">
    <span class="{@wit}">
        <xsl:apply-templates/>
    </span>
</xsl:template>
    </xsl:stylesheet>