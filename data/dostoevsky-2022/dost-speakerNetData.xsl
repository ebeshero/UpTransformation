<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  version="3.0">

  <xsl:output method="text"/>

 <xsl:variable as="element()+" name="spokenPassages" select="//said[@direct='true']"/>
  
  <xsl:variable name="speakers" as="xs:string+" select="$spokenPassages/@who ! tokenize(., '\s+') ! substring-after(., '#') => distinct-values()"/>
  <!-- 2022-06-10 ebb: These are atomized bits of text pulled from the XML tree. -->
  
  <xsl:variable name="tab" as="xs:string" select="'&#x9;'"/>
  <xsl:variable name="return" as="xs:string" select="'&#10;'"/>
  
  <xsl:template match="/">
    <xsl:variable name="text" as="element()" select="//text"/>

     <xsl:for-each select="$speakers">
       <xsl:variable name="currentSpeaker" as="xs:string" select="current()"/>
       
       <xsl:variable name="spokenPassages" as="element()+" select="$text//said[@direct='true'][contains(@who, $currentSpeaker)]"/>
       
     <xsl:for-each select="$spokenPassages">
       <xsl:variable name="toWhoms" as="xs:string*" select="./@toWhom ! tokenize(., '\s+') ! substring-after(., '#') => distinct-values()"/>
       <!--ebb: Currently this is preparing a line of network data only when a @toWhom attribute is present. -->
       
     <xsl:for-each select="$toWhoms">
       
       <xsl:variable name="count" as="xs:integer" select="$text//said[contains(@who, $currentSpeaker) and contains(@toWhom, current())] => count()"/>
       
       <xsl:value-of select="concat($currentSpeaker, $tab, 'speaks this many times to', $tab, $count, $tab, current(), $return)"/>
     </xsl:for-each>
       
  </xsl:for-each>
 </xsl:for-each>
 
  </xsl:template>
  
  

</xsl:stylesheet>
