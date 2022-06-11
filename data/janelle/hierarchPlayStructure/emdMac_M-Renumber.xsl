<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  version="3.0">

  <xsl:output method="xml" indent="yes"/>

  <xsl:mode on-no-match="shallow-copy"/>
  
  <xsl:template match="div[@type='act']">
    <div type="act" xml:id="{//TEI/@xml:id}_a{count(preceding-sibling::div) + 1}">
      <xsl:apply-templates/>
      
    </div>
    
  </xsl:template>
  
  <xsl:template match="div[@type='scene']">
    <div type="scene" xml:id="{//TEI/@xml:id}_a{parent::div[@type='act']/preceding-sibling::div => count() + 1}_s{preceding-sibling::div[@type='scene'] => count() + 1}">
      <xsl:apply-templates/>
    </div>
    
  </xsl:template>
  
  
  <xsl:template match="anchor">
    <!-- 2022-06-10 ebb: These are numbered consecutively from start to end of document. -->
    <anchor xml:id="{//TEI/@xml:id}_a{ancestor::div[@type='act']/preceding-sibling::div => count() + 1}_s{ancestor::div[@type='scene']/preceding-sibling::div[@type='scene'] => count() + 1}_anc{preceding::anchor => count() + 1}">
      <xsl:apply-templates/>
    </anchor>
  </xsl:template>
  
  <xsl:template match="sp">
    <!-- 2022-06-10 ebb: These numbers start from 1 with each new scene. -->
    <sp who="{@who}" xml:id="{//TEI/@xml:id}_a{ancestor::div[@type='act']/preceding-sibling::div => count() + 1}_s{ancestor::div[@type='scene']/preceding-sibling::div[@type='scene'] => count()}_sp{preceding-sibling::sp => count() + 1}">
      <xsl:apply-templates/>
      
    </sp>
      
      
    
  </xsl:template>
 

</xsl:stylesheet>
