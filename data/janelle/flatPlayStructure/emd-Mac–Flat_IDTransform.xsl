<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  version="3.0">

  <xsl:output method="xml" indent="yes"/>

  <xsl:mode on-no-match="shallow-copy"/>
  <xsl:variable name="playID" as="xs:string" select="//TEI/@xml:id"/>
  <!--2022-06-11 ebb: Above is a **global variable** that we can call on in any template rules in the document.  -->
  
  <xsl:template match="sp">
    
    <sp xml:id="emdMac-sp_{count(preceding::sp) + 1}">
      <xsl:apply-templates/>
      
    </sp>
    
  </xsl:template>
  
  <xsl:template match="lb">  
    <lb xml:id="{$playID}_{count(preceding::lb) + 1}"/>
  </xsl:template>
  
  
<xsl:template match="milestone[@unit='act']">

  <milestone unit='act' xml:id="{$playID}_a{count(preceding-sibling::milestone[@unit='act']) + 1}"/>

</xsl:template>
 
  <xsl:template match="milestone[@unit='scene']">
    <!-- 2022-06-11 ebb: We finally succeeded in numbering scenes only within the acts, by making it very clear to XSLT how to determine *which nodes* to count. 
      To help make the code easier to read, we're storing values in local variables. 
      These variables change in value depending on the milestone element currently being matched in this template rule. 
      The variable below calculates a count of the preceding acts from the point of view of the scene milestone currently being processed.
      This $countPrecedingActs variable delivers an integer that will change depending on which scene milestones are being processed, 
      and it turns out to be a reliable way to test for which scenes belong to specific acts.
    -->  
    <xsl:variable name="countPrecedingActs" as="xs:integer" select="count(preceding-sibling::milestone[@unit='act'])"/>
   
   
    <!--ebb: The next variable determines the scene count, counting *only* from the nearest preceding act. 
    Notice how we're working with the $countPrecedingActs variable here.
    (To test our variables in developing this XSLT, we previously included <xsl:value-of select="$countPrecedingActs"/> to read their output.)
    We only count the preceding-sibling SCENE if it's true that, from its position, the count of precediing-sibling acts is EQUAL TO 
    the count of those acts at the xsl:template match node.
    We failed previously to make the predicate precise enough, because I mistakenly thought I could check that the scene's nearest preceding ACT NODE 
    was equal to the nearest preceding ACT NODE at the template match. The node test wasn't precise enough, 
    but applying a function helped to definitively isolate the scenes that share the same preceding act and count ONLY those. 
    Based on this, we're able to construct a full xml:id that includes the play, act, and scene info.
    --> 
    
    <xsl:variable name="countScenesInThisAct" as="xs:integer" 
      select="preceding-sibling::milestone[@unit='scene' and count(preceding-sibling::milestone[@unit='act']) eq $countPrecedingActs] => count()"/>
    
    
    <milestone unit="scene" xml:id="{$playID}_a{$countPrecedingActs}_s{$countScenesInThisAct + 1}"/>
   
  </xsl:template>
  
</xsl:stylesheet>
