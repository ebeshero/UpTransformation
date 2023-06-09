<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
  <!-- ==========================================  -->
    <!-- ebb: 2023-06-09 This new XSLT stylesheet is designed to pull the speeches of each member of the LA and 
      output them in a separate XML file. There will be one XML file for each
      member of the legislative assembly that holds all of their speeches.
      
      To adapt this stylesheet for use on a collection, write a variable indicating
      a collection() of files by pointing to a file directory. Each file must be formed 
      with the same elements that we can find here: 
      <speech>, <member>, and <dialogue>.
    
    -->
    
  <!-- ==========================================  -->
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
       <xsl:variable name="document" as="document-node()" select="."/>
        <xsl:variable name="members" as="xs:string+" select="//speech/member[not(. eq 'The Chair')] ! normalize-space() => distinct-values()"/>
        
        
        <xsl:for-each select="$members">
            <xsl:variable name="filename" select="current() ! replace(., '[. ’]+', '-') ! concat(., '.xml')"/>
          <xsl:result-document method="xml" indent="yes" href="memberSpeeches-XML/{$filename}"> 
         <member>     
             <header level="main"> 
                 <name><xsl:value-of select="current()"/></name>
                 <speechCount n="{count($document//speech[member ! normalize-space() = current()])}"/>
                 
             </header>
              
             <speeches> 
                 <xsl:apply-templates select="$document//speech[member ! normalize-space() = current()]"/>
             
             </speeches>
         </member>
                             
          </xsl:result-document>
            
            
        </xsl:for-each>
       
    </xsl:template>
    
    <xsl:template match="speech">
        <proceedings fk="{ancestor::proceedings/@fk}">
            <xsl:apply-templates select="ancestor::proceedings/@type"/>
        </proceedings>
       

        <xsl:if test="parent::procedure/@type">
        <procedure><xsl:value-of select="parent::procedure/@type ! string()"/></procedure>
    
        </xsl:if>
  
  
        
  <speech> 
      <xsl:apply-templates select="dialogue"/>    
  </speech>
        
       
    </xsl:template>
    
    <xsl:template match="dialogue">
    
         <p><xsl:value-of select="normalize-space()"/></p>
      
    </xsl:template>

</xsl:stylesheet>