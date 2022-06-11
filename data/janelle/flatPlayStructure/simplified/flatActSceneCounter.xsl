<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  version="3.0">

  <xsl:output method="xml" indent="yes"/>
  <xsl:mode on-no-match="shallow-copy"/>

 <xsl:template match="milestone[@unit='act']">
   <milestone unit="act" n="{count(preceding-sibling::milestone[@unit='act']) + 1}"/>
   
 </xsl:template>
  
  <xsl:template match="milestone[@unit='scene']">
    <xsl:variable name="myNearestAct" as="element(milestone)" select="current()/preceding-sibling::milestone[@unit='act'][1]"/>
   
   <milestone unit="scene" nearestActID="{$myNearestAct/@xml:id}"/>
  
  <milestone unit="scene" n="{preceding-sibling::milestone[@unit='scene' and count(preceding-sibling::milestone[@unit='act']) eq count(current()/preceding-sibling::milestone[@unit='act'])] => count() + 1}"/>
   
  </xsl:template>
  

</xsl:stylesheet>
