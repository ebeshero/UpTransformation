<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  version="3.0">

  <xsl:output method="xml" indent="yes"/>

  <xsl:mode on-no-match="shallow-copy"/>
  
  <xsl:template match="sp">
    
    <sp xml:id="emdMac-sp_{count(preceding::sp) + 1}">
      <xsl:apply-templates/>
      
    </sp>
    
  </xsl:template>
  
  <xsl:template match="lb">  
    <lb xml:id="emd-Mac-lb_{count(preceding::lb) + 1}"/>
  </xsl:template>
  
  
<xsl:template match="milestone[@unit='act']">

  <milestone unit='act' n="{count(preceding-sibling::milestone[@unit='act']) + 1}"/>

</xsl:template>
 
  <xsl:template match="milestone[@unit='scene']">
<xsl:variable name="currentAct" as="element(milestone)" select="preceding-sibling::milestone[@unit='act'][1]"/>
    <!--<xsl:variable name="count" as="xs:integer" select="$currentAct/following-sibling::milestone[@unit='scene'][following-sibling::milestone = current()] => count() + 1"/>-->
    <xsl:variable as="xs:string" name="count">
      
      <xsl:number value="(current()/preceding-sibling::milestone[@unit='act'])[1] => count()" />
    </xsl:variable>
    <milestone unit="scene" n="{$count}"/>
    <!-- 2022-06-10 ebb my attempt to retrieve the count of each scene starting over after each act using xsl:number is not working properly, yet! 
    I'm seeing really interesting but wrong things happening: I'm seeing the same number being output for every scene. 
    -->
  </xsl:template>
  

</xsl:stylesheet>
