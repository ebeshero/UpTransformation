<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs math" version="3.0">

    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:mode name="unflatten" on-no-match="shallow-copy"/>
<!-- 2023-06-09 ebb with mmt and djb: 
        Run this XSLT stylesheet after converting a Word document marked by a Wesley specialist editor.
        The conversion process was accomplished by running a built-in transformation of docx to TEI in oXygen version 25 (or later).
        
        First this stylesheets removes the bolding of the markup.
        Then, it "raises" the flattened tags left by the bold-marking process from the Word document, using xsl:analyze-string.
    
    -->
    <xsl:template match="/">
        <xsl:variable name="removed-hi">
            <xsl:apply-templates/>
        </xsl:variable>
        <xsl:apply-templates select="$removed-hi" mode="unflatten"/>
    </xsl:template>

    <xsl:template match="hi[@rend = 'bold']">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="p" mode="unflatten">
       <p> 
           <xsl:analyze-string select="." regex="&lt;(\w+) (\w+)=(\S+)/&gt;" flags="s">
            <!-- Matches self-closing elements -->
            <xsl:matching-substring>
                <xsl:element name="{regex-group(1)}">
                    <xsl:attribute name="{regex-group(2)}">
                        <xsl:value-of select='regex-group(3) ! replace(., """", "")'/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:matching-substring>
    
            <xsl:non-matching-substring>
   
             <!--   <xsl:analyze-string select="." regex="&lt;(l).*?&gt;(.+?)&lt;/l&gt;" flags="s" >
                 <!-\- Match the <l> elements now b/c they're inside <lg>. -\->
                 <xsl:matching-substring>
                     <l><xsl:value-of select="regex-group(2)"/></l>
                 </xsl:matching-substring>
                 <xsl:non-matching-substring>  
                     <xsl:analyze-string select="." regex="&lt;(lg).*?&gt;(.+?)&lt;/lg&gt;" flags="s">
                        <!-\- Now match the <lg> elements. -\->
                         <xsl:matching-substring>
                             <lg><xsl:value-of select="regex-group(2)"/></lg>
                             
                         </xsl:matching-substring>
                         <xsl:non-matching-substring>
                             -->
                             <xsl:analyze-string select="." regex="&lt;(hi) .+?(rend)=(\S+)&gt;(.+?)&lt;/hi&gt;" flags="s"> 
                  <!-- Matches the infernal hi elements -->
                  <xsl:matching-substring>
                      <hi rend='{regex-group(3) ! replace(., """", "")}'>
                          <xsl:value-of select="regex-group(4)"/>
                      </hi>
                  </xsl:matching-substring>
                  
                  <xsl:non-matching-substring> <xsl:analyze-string select="." regex="&lt;(note) .+?(n)=(\S+)&gt;(.+?)&lt;/note&gt;" flags="s">
                    <!-- matching note elements  -->
                    <xsl:matching-substring>
                        <note n='{regex-group(3) ! replace(., """", "")}'>
                            <xsl:value-of select="regex-group(4)"/>
                        </note>
                    </xsl:matching-substring> 
                    <xsl:non-matching-substring>
                      <xsl:value-of select="."/>    
                    </xsl:non-matching-substring>
                </xsl:analyze-string></xsl:non-matching-substring></xsl:analyze-string>
                 <!-- </xsl:non-matching-substring>
         
      
        </xsl:analyze-string>--><!--</xsl:non-matching-substring></xsl:analyze-string>-->
            </xsl:non-matching-substring>
           </xsl:analyze-string>
       
       </p>
    </xsl:template>

</xsl:stylesheet>
