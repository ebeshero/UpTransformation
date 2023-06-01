<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  version="3.0">

  <xsl:output method="xml" indent="yes"/>

 <xsl:template match="/">
   <xml>
     <xsl:apply-templates select="//milestone"/>
     
   </xml> 
 </xsl:template>
  
  
  
  
<xsl:template match="milestone">

  <xsl:element name="{local-name()}">
    <xsl:copy-of select="@*"/>
  </xsl:element>

</xsl:template>
 
 

</xsl:stylesheet>
