<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
  <!-- ==========================================  -->
    <!-- ebb: 2023-06-09 This XSLT stylesheet is designed to pull the speeches of each member of the LA and 
      output them in a separate text file. There will be one text file for each
      member of the legislative assembly that holds all of their speeches.
      
      To adapt this stylesheet for use on a collection, write a variable indicating
      a collection() of files by pointing to a file directory. Each file must be formed 
      with the same elements that we can find here: 
      <speech>, <member>, and <dialogue>.
    
    -->
    
  <!-- ==========================================  -->
    <xsl:output method="text"/>
    
    <xsl:template match="/">
        <xsl:variable name="members" as="xs:string+" select="//speech/member[not(. eq 'The Chair')] ! normalize-space() => distinct-values()"/>
        
        
        <xsl:for-each select="$members">
            <xsl:variable name="filename" select="current() ! replace(., '[. ’]+', '-') ! concat(., '.txt')"/>
          <xsl:result-document method="text" href="memberSpeeches/{$filename}"> 
              
              <xsl:value-of select="current()"/><xsl:text>&#x0a;&#x0a;</xsl:text>
              
          </xsl:result-document>
            
            
        </xsl:for-each>
       
        
        
        
        
        
        
    </xsl:template>
    
    
    
</xsl:stylesheet>