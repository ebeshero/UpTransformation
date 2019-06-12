<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xhtml" indent="yes" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>
   
    
 <!-- <xsl:template match="author">
        <xsl:apply-templates/>, 
    </xsl:template> -->

<xsl:template match="/">
     <html>
        <head><title><xsl:apply-templates select="descendant::title[1]"/></title>
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
    <div class="poem"> 
        
        <h1><xsl:apply-templates select="descendant::title[1]"/></h1>
       <!-- <h2>by <xsl:apply-templates select="descendant::author"/></h2>-->
     <h2><xsl:value-of select="concat('by ', string-join(descendant::author, ', '))"/></h2>
        
      
        
     <xsl:apply-templates select="descendant::poem"/>
    </div>
        <section class="pubInfo">  <p>Published in <i><xsl:apply-templates select="descendant::publication//title"/></i>, <xsl:apply-templates select="descendant::pubPlace"/> on <xsl:apply-templates select="descendant::date"/>.
        </p>     </section>
    </body>   
     </html> 
</xsl:template>
<xsl:template match="line">
  <xsl:apply-templates/><xsl:text> </xsl:text> 
<xsl:if test="(count(preceding-sibling::line) + 1) mod 5 eq 0">    
    <span class="lineNum"><xsl:value-of select="count(preceding-sibling::line) + 1"/></span>

</xsl:if>
    <br/>
    
</xsl:template>
    

</xsl:stylesheet>