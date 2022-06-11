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
  
    <xsl:variable name="countPrecedingActs" as="xs:integer" select="count(preceding-sibling::milestone[@unit='act'])"/>
   <!--2022-06-11 ebb: This $countPrecedingActs variable delivers an integer that will change depending on which scene milestones are being processed, and it turns out to be a reliable way to test for which scenes belong to specific acts.  --> 
    
    <milestone unit="scene" n="{preceding-sibling::milestone[@unit='scene' and count(preceding-sibling::milestone[@unit='act']) eq $countPrecedingActs] => count() + 1}"/>
    <!--ebb: We finally succeeded in numbering scenes only within the acts, by making it very clear to XSLT how to determine *which nodes* to count. The expression above says, only count the preceding-sibling SCENE if it's true that, from its position, the count of precediing-sibling acts is EQUAL TO the count of those acts at the xsl:template match node.
    We failed previously to make the predicate precise enough, because I wrongly thought I could simply make sure that the scene's nearest preceding ACT NODE was equal to the nearest preceding ACT NODE at the template match. The node test wasn't precise enough, but applying a function helped to definitively isolate the scenes that share the same preceding act and count ONLY those. 
    -->
  </xsl:template>
  
</xsl:stylesheet>
