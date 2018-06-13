<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  
    version="3.0">
    <!--2018-06-13 ebb: XSLT-Identity Transformation Starter (non-namespaced XML)--> 
  
  <xsl:output method="xml" indent="yes"/>

    <xsl:mode on-no-match="shallow-copy"/>
    
  <xsl:template match="line">
    <xsl:apply-templates/><lb n="{count(preceding::line) + 1}"/>
  
  </xsl:template>

</xsl:stylesheet>