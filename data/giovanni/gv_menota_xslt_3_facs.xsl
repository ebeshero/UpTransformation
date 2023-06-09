<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY aelig "&#230;">
<!ENTITY oslash "&#248;">
<!ENTITY aring "&#229;">
<!ENTITY AElig "&#198;">
<!ENTITY Oslash "&#216;">
<!ENTITY Aring "&#197;">
<!ENTITY dash "&#45;">
<!ENTITY lquo "&#171;">
<!ENTITY rquo "&#187;">
<!ENTITY nbsp "&#x0020;">
<!ENTITY carr "&#x0D;">
<!ENTITY lsquo  "&#x2018;">
<!ENTITY ldquo  "&#x201C;">
<!ENTITY rsquo  "&#x2019;">
<!ENTITY rdquo  "&#x201D;">
]>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:me="http://www.menota.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:gv="temporary_namespace_Giovanni_Verri"
    >
    
    <!-- Version of stylesheet: January 2021 -->
    
    <!-- The authors of this stylesheet have agreed on the 15th August 2017 to make it available under a CC BY 4.O license. -->
    
<!-- This stylesheet was originally written by Vemund Olstad, Aksis, University of Bergen, for the Menota TVB project, http://www.hit.uib.no/menota/TVB. 
        First version made for the research group Editing Medieval Manuscripts, Centre for Advanced Study, Oslo, 2000-2001.  IT has subsequently been expanded ad adjusted
        by Tone Merete Bruvik, Aksis, University of Bergen, Haraldur Bernharðsson, University of Iceland, and Beeke Stegmann, University of Copenhagen/Stofnun Árna 
        Magnússonar í íslenskum fræðum, Reykjavik -->
    
    <!-- 2005.12.14 tmb: Updated in December 2005 to cover TEI P5, version 0.3. -->    
    <!-- 2006.12.21 tmb: Updated in December 2006 to match the Menota 2.0 beta and TEI P5, version 0.5  -->
    <!-- 2008.01.09 tmb: Updated in January 2008 to match the Menota 2.0 and TEI P5, version 1.0  -->
    <!-- 2008.01.21 tmb: Updated in January 2008 to match the Menota 2.0 and TEI P5, version 1.0  -->
    <!-- 2009.07.03 tmb: Updated in July 2009 to show additions in margin and initials  -->
    <!-- 2014.03.25 HB: Some minor changes; see HB below -->
   <!-- 2017.02-2017.07 BS: Introduced changes to code in facs-visning in order to have discontinuous rubrics be displayed as they are in the manuscript. -->
    <!-- 2017.03-2017.08 BS: Updated and adjusted stylesheet to match Menota handbook v.3 -->
    <!-- 2017.10.14 BS: Fixed display of meta information drawn from respStmt -->
    <!-- 2017.10.15 BS: Incorporated and adjusted code from Robert Kristof Paulsson for display of initials. Some of it is not working in all browsers (yet). See comments below. -->
    <!-- 2017.10.28 BS: Made the stylesheet xslt 3.0 and fixed bugs related to that. Added exceptions for display of notes. -->
    <!-- 2017.11.17 BS: Added font-feature-settings to CSS rules  -->
    <!-- 2017.12.19 BS:  Udates for quotations inside of quotations, removed superfluous white space in front of closing quotations, changed display of hyphens in front of line break: 
    no hyphen displayed on norm or dipl if immediately followed by lb-->
    <!-- 2019.11.29 BS: Fixed some buggs regarding white spaces after <seg> and <add>, transformation errors for markup of initials and creating multiple paragraphs within chapters. -->
    <!-- 2019.12 BS: Adjusted display for <unclear>, <note>, <del>, <space>, <gap>, <supplied> and <surplus> (except for rendition=first/middle/last) according to Menota v. 3.0 -->
    <!-- 2020.01 BS: Updated display for <sic> and <corr>, added rendition=first/middle/last for <del>, <supplied> <me:surpressed> and <surplus> (and corrected white spaces for them)-->
    <!-- 2020.02 BS: Added display of middot for supplied hyphens at line breaks in facs and totally remade processing of <add> elements. Added templates for transposition-->
    <!-- 2020.12 BS: Adjusted display of <pc> within words/numbers according to latest changes in Menota handbook chapt. 5 (version 3.1), also works in discontinuous headings -->
     <!-- 2021.1 BS:  Corrected display of missing dots for number on dipl encoded as <pc>.</pc> within <num> or <w> (as of Menota 3.1) and adjusted display of rubrics on dipl -->
    <!-- 2021.1: BS: adjusted code to prevent double display of older encoding for marginal additions -->
    
<!-- The entities defined above are needed for text generation in the style sheet, e.g. if you want to generate a header or multiple space. -->    
    
<xsl:output method="html" doctype-public="-//W3C/DTD XHTML 1.0 STRICT//EN" doctype-system="http:://www.w3.org/TR/xhtml1-strict.dtd" encoding="ASCII"></xsl:output>

<!-- The xsl:strip-space element is used to prevent superflous spaces in the xml encoding from being displayed in the output HTML file -->    
<!-- Since necessary spaces are stripped from the file, some of the templates below contain functions that add spaces in relevant places (see templates for w, punct, unclear and supplied) -->    
<xsl:strip-space elements="*"/>

<!-- This global parameter below is used to decide which of the three text-levels is displayed, i.e the facsimile level, the diplomatic level or the normalised level. See the Menota handbook v. 1.1, ch. 3 for further details on these levels.The parameter has three values: 'facs', 'dipl' and 'norm'. -->
    
    <!-- Due to problems with parametres in Oxygen, we have inserted an extra select attribute in the parametre. For facs display, the value has to be 'facs' and for dipl display the value has to be 'dipl'. -->
    <xsl:param name="visning" select="'facs'"/>
  <!-- <xsl:param name="visning" select="'dipl'"/>-->
    <!--   <xsl:param name="visning" select="'norm'"/>-->
    
    
<!-- This template writes the entire document into an HTML page -->

<xsl:template match="/">
    <xsl:element name="HTML">
        <xsl:element name="HEAD">
            <xsl:element name="TITLE">
                <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
            </xsl:element>
            <xsl:element name="META">
            <xsl:attribute name="http-equiv">Expires</xsl:attribute>
            <xsl:attribute name="content">0</xsl:attribute>
            </xsl:element>
            
<!-- This is a complete CSS definition for Menota styles, included in the present XSLT style sheet. Thus it is possible to use this style sheet off line. -->          
<!-- We recommend using MUFI compliant fonts, which are listed in a prefential sequence as values for the font-framily. These fonts are available from http://www.hit.uib.no/mufi/fonts.html -->
<!-- However, structural elements may use another font, like Verdana. -->
<!-- HB 2014.03.25: Added Palemonas MUFI and Cardo to font specification -->
            

            <xsl:element name="STYLE">
            <xsl:attribute name="type">text/css</xsl:attribute>
                BODY {
                line-height: 200%;
                }
                .pagebreak                   {font-family:             Verdana;
                                                         font-size:                12pt;
                                                         font-weight:            normal;
                                                         color:                       #BEBEBE;
                                                         vertical-align:         middle;}
                .linecount                      {font-family:             Verdana;
                                                         font-size:                10pt;
                                                         font-weight:            normal;
                                                         color:                       #BEBEBE;
                                                         padding-right:        15px;
                                                         float:                         left;
                                                         text-align:                right;
                                                         width:                      25px;}
                .head1			{font-family: 	'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
                                                        font-feature-settings: 'ss01', 'ss10', 'ss15', 'kern';
			                font-weight:	normal;
			                font-size:	28pt;
			                color:		#0000FF;
			                text-align:	left;
			                margin-bottom:  10px;}
      .head			{font-family: 	'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
                                                         font-feature-settings: 'ss01', 'ss10', 'ss15', 'kern';
			                font-weight:	normal;
			                font-size:	28pt;
			                color:		Red;
			                text-align:	left;
			                margin-bottom:  10px;}
       .head2			{font-family: 	'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
                                                              font-feature-settings: 'ss01', 'ss10', 'ss15', 'kern';
                                                              font-weight:	normal;
			                font-size:	24pt;
			                color:		#0000FF;
			                text-align:	left;
			                margin-bottom:  10px;}
	 .head3			{font-family: 	'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
	                                            font-feature-settings: 'ss01', 'ss10', 'ss15', 'kern';
			                font-weight:	normal;
			                font-size:	18pt;
			                color:		#0000FF;
			                text-align:	left;
			                margin-bottom:  10px;}
	   .head4		{font-family: 	'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
	                                             font-feature-settings: 'ss01', 'ss10', 'ss15', 'kern';
		                	 font-weight:	normal;
			                font-size:	14pt;
			                color:		Red;
			                text-align:	left;
			                margin-bottom:  10px;}
   .divwork                                    {font-family:             'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
                                                     font-feature-settings: 'ss01', 'ss10', 'ss15', 'kern';
                                                         font-size:                18pt;
                                                         font-weight:           normal;
                                                         color:                      Red;
                                                         margin-top:           10px;
                                                         margin-bottom:    10px;
                                                         text-align:               left;}
      .divchapter                       {font-family:             'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
                                                          font-feature-settings: 'ss01', 'ss10', 'ss15', 'kern';
                                                         font-size:                16pt;
                                                         font-weight:            normal;
                                                         color:                       Red;
                                                         margin-top:           20px;
                                                         margin-bottom:    10px;
                                                         text-align:                left;}
        .divchapter_norm                       {font-family:             'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
                                                     font-feature-settings: 'ss01', 'ss10', 'ss15', 'kern';
                                                        font-size:                16pt;
                                                         font-weight:            normal;
                                                         color:                       Black;
                                                         margin-top:           20px;
                                                         margin-bottom:    10px;
                                                         text-align:                left;}
             .paragraph                    {font-family:            'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
                                                 font-feature-settings: 'ss01', 'ss10', 'ss15', 'kern';
                                                        font-size:                14pt;
                                                         font-weight:           normal;
                                                         color:                      #000000;
                                                         line-height:            1.5em;}
       
             .linegroup                     {font-family:            'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
                                                  font-feature-settings: 'ss01', 'ss10', 'ss15', 'kern';
                                                         font-size:                14pt;
                                                         font-weight:           normal;
                                                         color:                      #000000;
                                                         line-height:            140%;
                                                         margin-left:            25px;}                                                         
                .lglines                          {font-family:             Verdana;
                                                         font-size:                10pt;
                                                         font-weight:            normal;
                                                         color:                       #BEBEBE;
                                                         padding-right:        5px;
                                                         float:                         left;
                                                         text-align:                right;
                                                         width:                      25px;}
                .note                               {font-family:             Junicode;
                                                         font-size:                 8pt;
                                                         font-weight:             normal;
                                                         color:                        #0000FF;
                                                         text-decoration:      none;
                                                         vertical-align:          super;}
                .foot                               {font-family:              Junicode;
                                                         font-size:                 8pt;
                                                         font-weight:             normal;
                                                         color:                        #0000FF;
                                                         text-decoration:      none;
                                                         float:                         left;
                                                         width:                        15px;
                                                         padding-right:            5px;
                                                         text-align:                  right;}
                .footnote                        {font-family:              Junicode;
                                                         font-size:                 10pt;
                                                         font-weight:             normal;
                                                         color:                        #000000;}                                                          
           .expan                          {font-family:          'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
                                                         font-feature-settings: 'ss01', 'ss10', 'ss15', 'kern';
                                                        font-style:             italic;
                                                         font-weight:         normal;}


                .notecritical		{font-size:	80%;
			                color:		#0076AE}
                .noteplain		{font-size:	80%;
	                		 color:		#008080}
           <!--     .gap			{font-size:	80%;
	                		 color:		#0076AE} -->
                .add			{color:		#008000}
                .emph			{color:		#0000FF}
            </xsl:element>
            
        </xsl:element>
        <xsl:element name="BODY">
        <xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
        <xsl:attribute name="class">paragraph</xsl:attribute>
            <xsl:for-each select="tei:TEI">
                <xsl:element name="BR"></xsl:element>
                <xsl:element name="BR"></xsl:element>
                
<!-- This apply-template writes the teiHeader into the top of the document -->         
                
                <xsl:apply-templates select="tei:teiHeader"/>
                <xsl:element name="HR"></xsl:element>
                
<!-- This apply-template writes the text itself into the document, after the header. --> 
         
                <xsl:apply-templates select="tei:text/*"/>
                <xsl:element name="HR"></xsl:element>
                <!--<xsl:element name="A">
                <xsl:attribute name="name">topp</xsl:attribute>
                    <xsl:text>For en beskrivelse av fargekodingen</xsl:text>
                </xsl:element>
                    <xsl:text>, trykk&nbsp;</xsl:text>
                <xsl:element name="A">
                <xsl:attribute name="href">#bunn</xsl:attribute>
                    <xsl:text>her</xsl:text>
                </xsl:element>-->

<!-- This apply-template writes the notes into the document as foot notes, after the text itself. -->  
                <xsl:if test="descendant::tei:note">
                    <xsl:element name="DIV">
                    <xsl:attribute name="style">font-family: Verdana; font-size: 12pt; text-align: left</xsl:attribute>
                        <xsl:text>Notes:</xsl:text>
                        <xsl:apply-templates select="//tei:note" mode="footer"/>
                    </xsl:element>
                    <xsl:element name="BR"></xsl:element>
                </xsl:if>
<!-- The following rules add an explanation of the colour encoding -->            
                
                <!--<xsl:element name="A">
                <xsl:attribute name="name">bunn</xsl:attribute>
                    <xsl:text>Fargekoding:</xsl:text>
                </xsl:element>-->
                <!--<xsl:element name="BR"></xsl:element>-->
                    <!--<xsl:element name="UL">
                        <xsl:element name="LI">
                            <xsl:text>Alle &lt;supplied&gt; elementer er kodet&nbsp;</xsl:text>
                            <xsl:element name="SPAN">
                            <xsl:attribute name="class">supplied</xsl:attribute>
                            <xsl:text>&lt;p&aring; denne m&aring;ten&gt;.</xsl:text>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="LI">
                            <xsl:element name="SPAN">
                            <xsl:attribute name="class">notecritical</xsl:attribute>
                            <xsl:text>(Tekstkritiske noter ser slik ut).</xsl:text>
                            </xsl:element>                        
                        </xsl:element>
                        <xsl:element name="LI">
                            <xsl:element name="SPAN">
                            <xsl:attribute name="class">noteplain</xsl:attribute>
                            <xsl:text>(Ordin&aelig;re noter ser slik ut).</xsl:text>
                            </xsl:element>                        
                        </xsl:element>
                        <xsl:element name="LI">
                            <xsl:element name="SPAN">
                            <xsl:attribute name="class">add</xsl:attribute>
                            <xsl:text>Alle &lt;add&gt; elementer er kodet med denne fargen.</xsl:text>
                            </xsl:element>                        
                        </xsl:element>
                        <xsl:element name="LI">
                            <xsl:element name="SPAN">
                            <xsl:attribute name="class">emph</xsl:attribute>
                            <xsl:text>Uthevinger (emph) er kodet med denne fargen.</xsl:text>
                            </xsl:element>                        
                        </xsl:element>
                        <xsl:element name="LI">
                            <xsl:text>&lt;gap&gt; elementer blir vist som tekstkritiske noter, med verdien av extent-attributtet i klammeparenteser. Slik:&nbsp;</xsl:text>
                            <xsl:element name="SPAN">
                            <xsl:attribute name="class">gap</xsl:attribute>
                            <xsl:text>[00..00]</xsl:text>
                            </xsl:element>                        
                        </xsl:element>
                    </xsl:element>-->
                <!--<xsl:element name="BR"></xsl:element>-->
                <!--<xsl:element name="A">
                <xsl:attribute name="href">#topp</xsl:attribute>
                    <xsl:text>Tilbake til toppen</xsl:text>
                </xsl:element>-->
            </xsl:for-each>
        </xsl:element>
    </xsl:element>
</xsl:template>


<!-- The following templates format the TEI Header, i.e. it decides which part(s) of the header that is going to be displayed (i.e. title from titleStmt)  or suppressed (i.e. publicationStmt from fileDesc). -->

<!-- Note that if a top element is suppressed, the descendent elements will also be suppressed. -->
    
    <xsl:template match="tei:fileDesc/tei:titleStmt">
        <xsl:apply-templates select="child::tei:title"/>
        <xsl:apply-templates select="child::tei:respStmt"/>
</xsl:template>    

    <xsl:template match="tei:fileDesc/tei:titleStmt/tei:title">
    <xsl:element name="DIV">
    <xsl:attribute name="class">head2</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

    <xsl:template match="tei:fileDesc/tei:titleStmt/tei:respStmt">
    <xsl:element name="DIV">
    <xsl:attribute name="class">paragraph</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

    <xsl:template match="tei:fileDesc/tei:sourceDesc"/>    
    
<!--Display mini editing info correctly-->
    <xsl:template match="tei:resp">
        <xsl:apply-templates/>
        <xsl:text>: </xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:forename">
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:surname">
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:extent">
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>
    

    <xsl:template match="tei:fileDesc/tei:publicationStmt"/>

    <xsl:template match="tei:encodingDesc"/>

    <xsl:template match="tei:profileDesc"/>

    <xsl:template match="tei:revisionDesc"/>

<!-- Templates for common milestone-elements (pagebreaks, linebreaks and columnbreaks) -->

<xsl:template match="tei:pb">
    <xsl:variable name="currentpb">
        <xsl:value-of select="attribute::n"/>
    </xsl:variable>
    <xsl:variable name="previouspb">
        <xsl:value-of select="preceding::tei:pb[1]/attribute::n"/>
    </xsl:variable>
<!-- The display of page breaks depends on the text level. The value of the global parameter "visning" is used to control how page breaks are formatted. -->
<!-- In facs, page break is displayed with page number and a line separator. -->
    
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs')">	
        <xsl:if test="preceding::tei:add[attribute::place='margin-bottom'][preceding::tei:pb[1][attribute::n=$previouspb]]">
            <xsl:element name="TABLE">
                <xsl:attribute name="border">0</xsl:attribute>
                <xsl:attribute name="width">650px</xsl:attribute>
                <xsl:element name="TR">
                    <xsl:element name="TD">
                        <xsl:attribute name="width">135</xsl:attribute>
                        <xsl:text>&#xA0;</xsl:text>
                    </xsl:element>
                    <xsl:element name="TD">
                        <xsl:attribute name="width">600px</xsl:attribute>
                        <xsl:for-each select="preceding::tei:add[attribute::place='margin-bottom'][preceding::tei:pb[1][attribute::n=$previouspb]]">
                            <xsl:apply-templates select="self::tei:add" mode="margin"/>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:if>
    <xsl:element name="BR"></xsl:element>
    <xsl:element name="BR"></xsl:element>
    <xsl:element name="TABLE">
    <xsl:attribute name="border">0</xsl:attribute>
    <xsl:attribute name="width">650px</xsl:attribute>
        <xsl:element name="TR">
            <xsl:element name="TD">
            <xsl:attribute name="width">35</xsl:attribute>
                <xsl:element name="SPAN">
                <xsl:attribute name="class">pagebreak</xsl:attribute>
                    <xsl:value-of select="attribute::n"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="TD">
            <xsl:attribute name="width">600px</xsl:attribute>
                <!-- <xsl:element name="IMG">
                <xsl:attribute name="style">vertical-align: middle</xsl:attribute>
                <xsl:attribute name="src">http://gandalf.hit.uib.no/~vemund/menota/pagebreak.gif</xsl:attribute>
                </xsl:element> -->
                <xsl:text>&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;</xsl:text>
            </xsl:element>
        </xsl:element>
    </xsl:element>
        <xsl:if test="following::tei:add[attribute::place='margin-top'][preceding::tei:pb[1][attribute::n=$currentpb]]">
            <xsl:element name="TABLE">
                <xsl:attribute name="border">0</xsl:attribute>
                <xsl:attribute name="width">650px</xsl:attribute>
                <xsl:element name="TR">
                    <xsl:element name="TD">
                        <xsl:attribute name="width">135</xsl:attribute>
                        <xsl:text>&#xA0;</xsl:text>
                    </xsl:element>
                    <xsl:element name="TD">
                        <xsl:attribute name="width">600px</xsl:attribute>
                        <xsl:for-each select="following::tei:add[attribute::place='margin-top'][preceding::tei:pb[1][attribute::n=$currentpb]]">
                            <xsl:apply-templates select="self::tei:add" mode="margin"/>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:if>    
        
    </xsl:when>
   
<!-- In dipl, page break is displayed inline with page number within double vertical lines. -->

        <xsl:when test="contains($visning, 'facs')">	
<xsl:text>
&nbsp;&#x007C;&#x007C;&nbsp;
</xsl:text>
                    <xsl:value-of select="attribute::n"/>
<xsl:text>
&nbsp;&#x007C;&#x007C;&nbsp;
</xsl:text>
</xsl:when>

<!-- In other levels (e.g. norm) no page number is displayed. -->

<xsl:otherwise>
    <xsl:if test="preceding::tei:add[attribute::type='external'][attribute::place='margin-bottom'][preceding::tei:pb[1][attribute::n=$previouspb]]">
        <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="width">650px</xsl:attribute>
            <xsl:element name="TR">
                <xsl:element name="TD">
                    <xsl:attribute name="width">135</xsl:attribute>
                    <xsl:text>&#xA0;</xsl:text>
                </xsl:element>
                <xsl:element name="TD">
                    <xsl:attribute name="width">600px</xsl:attribute>
                    <xsl:for-each select="preceding::tei:add[attribute::type='external'][attribute::place='margin-bottom'][preceding::tei:pb[1][attribute::n=$previouspb]]">
                        <xsl:apply-templates select="self::tei:add" mode="margin"/>
                    </xsl:for-each>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:if>
    <xsl:if test="following::tei:add[attribute::type='external'][attribute::place='margin-top'][preceding::tei:pb[1][attribute::n=$currentpb]]">
        <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="width">650px</xsl:attribute>
            <xsl:element name="TR">
                <xsl:element name="TD">
                    <xsl:attribute name="width">135</xsl:attribute>
                    <xsl:text>&#xA0;</xsl:text>
                </xsl:element>
                <xsl:element name="TD">
                    <xsl:attribute name="width">600px</xsl:attribute>
                    <xsl:for-each select="following::tei:add[attribute::type='external'][attribute::place='margin-top'][preceding::tei:pb[1][attribute::n=$currentpb]]">
                        <xsl:apply-templates select="self::tei:add" mode="margin"/>
                    </xsl:for-each>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:if>
</xsl:otherwise>
  </xsl:choose>

</xsl:template>

<!-- The display of column breaks also depends on the text level. The value of the global parameter "visning" is used to control how column breaks are formatted. -->
<!-- In facs, column break is displayed with a dotted line separator. -->

<xsl:template match="tei:cb">
<xsl:choose>
    <xsl:when test="contains($visning, 'facs')">
    <xsl:if test="not(attribute::n='a')">
        <xsl:element name="BR"></xsl:element>
            <!-- <xsl:element name="IMG">
            <xsl:attribute name="src">http://gandalf.hit.uib.no/~vemund/menota/columnbreak.gif</xsl:attribute>
            </xsl:element> -->
            <xsl:text>&#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7;</xsl:text>
    </xsl:if>
    </xsl:when>
    
<!-- In dipl, column break is displayed inline with column identifier (a,b,...) within single vertical lines. -->

    <xsl:when test="contains($visning, 'dipl')">	
    <xsl:if test="not(attribute::n='a')">

<xsl:text>
&nbsp;&#x007C;&nbsp;col.&nbsp;
</xsl:text>
                    <xsl:value-of select="attribute::n"/>
<xsl:text>
&nbsp;&#x007C;&nbsp;
</xsl:text>
</xsl:if>
</xsl:when>

<!-- In other levels (e.g. norm) no column identifier is displayed. -->

<xsl:otherwise>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!-- The display of line breaks also depends on the text level. The value of the global parameter "visning" is used to control how line breaks are formatted. -->
<!-- In facs, line break is displayed with line breaks (i.e. as physical lines) and, if encoded, with line numbers in left margin. -->

<xsl:template match="tei:lb|lb"> 
    
    <xsl:choose>
        <!-- In dipl, line break is not displayed. If the line break is contained within a word element, i.e. when words are divided over two lines,
            nothing as added, but if the line break occurs outside the word element, a space will be added. --> <!-- BS: is that space needed? -->
        
        <xsl:when test="contains($visning, 'dipl')">
            <xsl:if test="not(ancestor::tei:w)">
                <xsl:text>&nbsp;</xsl:text>
            </xsl:if>
         
        </xsl:when>
        
        <xsl:when test="contains($visning, 'norm')"> 
        </xsl:when>
        
        
        <xsl:when test="contains($visning, 'facs') and not(attribute::n)">                          
          <xsl:element name="SPAN">
                <xsl:attribute name="class">linecount</xsl:attribute>
                <xsl:text>&nbsp;</xsl:text>
            </xsl:element>
        </xsl:when>
        
       
        <xsl:otherwise>
    
    <xsl:variable name="line">
     <xsl:value-of select="attribute::n"/>
 </xsl:variable>
 <xsl:variable name="nextline">
     <xsl:value-of select="$line+1"/>
 </xsl:variable>
            <xsl:variable name="preceding-line">
                <xsl:value-of select="$nextline - $line"/>
            </xsl:variable>
 <xsl:variable name="linegroup">
     <xsl:value-of select="ancestor::tei:lg/attribute::xml:id"/>
 </xsl:variable>
    <xsl:variable name="preceding-pb" select="preceding::tei:pb[1]/attribute::n"/> <!-- new: BS 9/2-2017 -->
    <xsl:variable name="preceding-cb" select="preceding::tei:cb[1]/attribute::n"/> <!-- new: BS 12/2-2017 -->
            
            <xsl:choose>     <!-- if the display is facs then these extra rules apply --> 
 
     <xsl:when test="contains($visning, 'facs')"> 
    <xsl:choose>
          <xsl:when test="attribute::n and not(attribute::rend > 1)"> <!-- BS: new by 9/2-2017: do this only if this is a normal lb (without @rend) or if the @rend="1" -->
       <xsl:element name="BR"></xsl:element>
        <xsl:element name="SPAN">
            <xsl:attribute name="style">width: 100px; float: left;</xsl:attribute>
            <xsl:choose>
                <xsl:when test="following::tei:add[1][attribute::place='margin-left'][following::tei:lb[1][attribute::n=$nextline]]">
                    <xsl:apply-templates select="following::tei:add[1][attribute::place='margin-left'][following::tei:lb[1][attribute::n=$nextline]]" mode="margin"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>&#xA0;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
        <xsl:element name="SPAN">
        <xsl:attribute name="class">linecount</xsl:attribute>
        
<!-- This test decides that only every 3rd line number is going to be displayed, starting with line number 1, i.e. 1, 4, 7, 10, etc. -->

        <xsl:if test="attribute::n mod 3 = 0 +1">
            <xsl:value-of select="attribute::n"/>
        </xsl:if>
        
<!-- This test supresses line numbers that are not going to be displayed, but generates a no-breaking space, so that text lines are displayed with the same margin. -->

        <xsl:if test="not(attribute::n mod 3 = 0 +1)">
            <xsl:text>&#xA0;</xsl:text>
<!--            <xsl:element name="SPAN">
            <xsl:attribute name="style">color: #FFFFFF; bgcolor: #FFFFFF;</xsl:attribute>
                <xsl:text>lb</xsl:text>
            </xsl:element>-->
        </xsl:if>
        
<!-- If you want all line numbers displayed, add the following "xsl:value-of test" to the style sheet, and comment out the two preceding if tests: -->
<!-- <xsl:value-of test="attribute::n"/> -->
       </xsl:element>
        
        <!-- New by BS: rearrange order of w, num, pc and me:punct in lines with @rend -->
          <xsl:if test="attribute::rend">       
              <!-- create separate variables which contain all the texts of the individual parts of the line in question (which can then be ordered) -->
              <xsl:choose>
                  <xsl:when test="not(//tei:cb)"> <!--  for manuscripts with one column -->
              
              <xsl:variable name="line-seg-1"> <!--  variable for first part of the line -->
                  <xsl:text></xsl:text>
                  <!-- if the beginning lb is inside a word, get the last part of that word -->
                  <xsl:if test="//tei:lb[attribute::n=$line][attribute::rend='1'][preceding::tei:pb[1]/attribute::n=$preceding-pb]/ancestor::tei:w">
                      
                      <xsl:choose>  <!-- if the word is part of a header wrap it in <head> -->
                          <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='1'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/ancestor::tei:head"> 
                              <xsl:element name="tei:head">
                                  <xsl:attribute name="type">rend_variable</xsl:attribute>
                                  <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                      <xsl:choose> <!-- if there are multiple levels, only consider lb in me:facs -->
                                          <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='1'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]][descendant::me:facs]"> 
                                              <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='1'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                          </xsl:when>
                                          <xsl:otherwise>
                                              <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='1'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> <!-- get the snippet before the lb -->
                                          </xsl:otherwise>
                                      </xsl:choose>
                                  </xsl:element>
                              </xsl:element>
                          </xsl:when>
                          <xsl:otherwise> <!-- if not part of the header, get snippet before lb -->
                              <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                  <xsl:choose>      <!-- if there are multiple levels, only consider me:facs -->
                                      <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='1'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]][descendant::me:facs]"> 
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='1'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                      </xsl:when>
                                      <xsl:otherwise>  <!-- otherwise get the snippet -->
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='1'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                      </xsl:otherwise>
                                  </xsl:choose>
                              </xsl:element>
                          </xsl:otherwise>
                      </xsl:choose> 
                  </xsl:if>
                  
                  <!-- get the complete words (w, num, me:punct and pc not within w) new by dec 2020 -->
                  
                  <xsl:for-each select="//tei:w[preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='1'][not(descendant::tei:lb[attribute::rend])][not(parent::tei:num)]|//tei:num[preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='1']|//me:punct[preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='1']|//tei:pc[not(ancestor::tei:w or ancestor::tei:num)][preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='1']">
                      <xsl:choose> <!-- if part of header than wrap in <head> markup -->
                          <xsl:when test="ancestor::tei:head">
                              <xsl:element name="tei:head">
                                  <xsl:attribute name="type">rend_variable</xsl:attribute>
                                  <xsl:copy-of select="."></xsl:copy-of>
                              </xsl:element>
                          </xsl:when> <!-- otherwise just get the words -->
                          <xsl:otherwise> <xsl:copy-of select="."></xsl:copy-of></xsl:otherwise>
                      </xsl:choose>
                  </xsl:for-each>
                  
                  <!-- if the following lb is inside a word, get the first part of that word -->
                  <xsl:if test="//tei:lb[attribute::n=$nextline][preceding::tei:lb[1][attribute::rend='1'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]/ancestor::tei:w"> 
                      <xsl:choose>  <!-- if part of header, wrap in <head> -->
                          <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='1'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/ancestor::tei:head"> 
                              <xsl:element name="tei:head">
                                  <xsl:attribute name="type">rend_variable</xsl:attribute>
                                  <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly --> 
                                      <xsl:choose> <!-- if there are multiple levels, only consider me:facs -->
                                          <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='1'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]][descendant::me:facs]"> 
                                              <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='1'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                          </xsl:when>
                                          <xsl:otherwise> <!-- otherwise just get the snippet -->
                                              <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='1'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                                          </xsl:otherwise>
                                      </xsl:choose>
                                  </xsl:element>
                              </xsl:element>
                          </xsl:when>
                          <xsl:otherwise>
                              <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                  <xsl:choose>  <!-- if there are multiple levels, only consider me:facs -->
                                      <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='1'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]][descendant::me:facs]"> 
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='1'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                      </xsl:when>
                                      <xsl:otherwise> <!-- otherwise just get the snippet -->
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='1'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/>
                                      </xsl:otherwise>
                                  </xsl:choose>
                              </xsl:element>
                          </xsl:otherwise>
                      </xsl:choose>
                  </xsl:if>
                  <xsl:text></xsl:text>
              </xsl:variable>
              
              <xsl:variable name="line-seg-2">
                  <xsl:text></xsl:text>
                  <!-- if the beginning lb is inside a word, get the last part of that word --> 
                  <xsl:if test="//tei:lb[attribute::n=$line][attribute::rend='2'][preceding::tei:pb[1]/attribute::n=$preceding-pb]/ancestor::tei:w">
                      
                      <xsl:choose> 
                          <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='2'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/ancestor::tei:head"> 
                              <xsl:element name="tei:head">
                                  <xsl:attribute name="type">rend_variable</xsl:attribute>
                                  <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                      <xsl:choose> 
                                          <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='2'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]][descendant::me:facs]"> 
                                              <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='2'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                          </xsl:when>
                                          <xsl:otherwise>
                                              <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='2'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                          </xsl:otherwise>
                                      </xsl:choose>
                                  </xsl:element>
                              </xsl:element>
                          </xsl:when>
                          <xsl:otherwise>
                              <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                  <xsl:choose> 
                                      <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='2'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]][descendant::me:facs]"> 
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='2'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                      </xsl:when>
                                      <xsl:otherwise>
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='2'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                      </xsl:otherwise>
                                  </xsl:choose>
                              </xsl:element>
                          </xsl:otherwise>
                      </xsl:choose> 
                      <xsl:text></xsl:text>
                  </xsl:if>
                  
                  
                  <!-- get the complete words etc.--> <!-- new by BS Dec 2020 -->
                  <xsl:for-each select="//tei:w[preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='2'][not(descendant::tei:lb[attribute::rend])][not(parent::tei:num)]|//tei:num[preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='2']|//me:punct[preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='2']|//tei:pc[not(ancestor::tei:w or ancestor::tei:num)][preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='2']">
                      <xsl:choose>
                          <xsl:when test="ancestor::tei:head">
                              <xsl:element name="tei:head">
                                  <xsl:attribute name="type">rend_variable</xsl:attribute>
                                  <xsl:copy-of select="."></xsl:copy-of>
                                  
                              </xsl:element>
                          </xsl:when>
                          <xsl:otherwise> <xsl:copy-of select="."></xsl:copy-of></xsl:otherwise>
                      </xsl:choose>
                  </xsl:for-each>
                 
                  <!-- if the following lb is inside a word, get the first part of that word -->   
                  <xsl:if test="//tei:lb[attribute::n=$nextline][preceding::tei:lb[1][attribute::rend='2'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]/ancestor::tei:w"> 
                     
                      <xsl:choose> <!-- BS: new by march 2019: add red display if part of head --> 
                          <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='2'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/ancestor::tei:head"> 
                              
                              <xsl:element name="tei:head"> 
                              <xsl:attribute name="type">rend_variable</xsl:attribute>
                      <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                          <xsl:choose> 
                              <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='2'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]][descendant::me:facs]"> 
                                 
                                  <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='2'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                              </xsl:when>
                              <xsl:otherwise>
                                  <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='2'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                              </xsl:otherwise>
                          </xsl:choose>
                           </xsl:element>
                          </xsl:element>
                      </xsl:when>
                          <xsl:otherwise>
                              <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                         
                                  <xsl:choose> 
                                      <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='2'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]][descendant::me:facs]"> 
                                          
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='2'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                      </xsl:when>
                                      <xsl:otherwise>
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='2'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                                      </xsl:otherwise>
                                  </xsl:choose> 
                              </xsl:element>
                          </xsl:otherwise>
                      </xsl:choose>
                      
                  </xsl:if>
                  
                  <xsl:text></xsl:text>
              </xsl:variable>
              
              <xsl:variable name="line-seg-3">
                  <xsl:text></xsl:text>
                  <!-- if the beginning lb is inside a word, get the last part of that word -->
                  <xsl:if test="//tei:lb[attribute::n=$line][attribute::rend='3'][preceding::tei:pb[1]/attribute::n=$preceding-pb]/ancestor::tei:w">
                      
                      <xsl:choose> 
                          <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='3'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/ancestor::tei:head"> 
                              <xsl:element name="tei:head">
                                  <xsl:attribute name="type">rend_variable</xsl:attribute>
                                  <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                      <xsl:choose> 
                                          <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='3'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]][descendant::me:facs]"> 
                                              <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='3'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                          </xsl:when>
                                          <xsl:otherwise>
                                              <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='3'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                          </xsl:otherwise>
                                      </xsl:choose>
                                  </xsl:element>
                              </xsl:element>
                          </xsl:when>
                          <xsl:otherwise>
                              <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                  <xsl:choose> 
                                      <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='3'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]][descendant::me:facs]"> 
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='3'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                      </xsl:when>
                                      <xsl:otherwise>
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='3'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                      </xsl:otherwise>
                                  </xsl:choose>
                              </xsl:element>
                          </xsl:otherwise>
                      </xsl:choose> 
                  </xsl:if>
                 
                  <!-- get the complete words etc. --> <!-- new by Dec 2020 -->
                  <!--  if part of header than wrap in <head> markup -->
                  <xsl:for-each select="//tei:w[preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='3'][not(descendant::tei:lb[attribute::rend])][not(parent::tei:num)]|//tei:num[preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='3']|//me:punct[preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='3']|//tei:pc[not(ancestor::tei:w or ancestor::tei:num)][preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='3']">
                      <xsl:choose>
                          <xsl:when test="ancestor::tei:head">
                              <xsl:element name="tei:head">
                                  <xsl:attribute name="type">rend_variable</xsl:attribute>
                                  <xsl:copy-of select="."></xsl:copy-of>
                              </xsl:element>
                          </xsl:when>
                          <xsl:otherwise> <xsl:copy-of select="."></xsl:copy-of></xsl:otherwise>
                      </xsl:choose>
                  </xsl:for-each>
                  
                  <!-- if the following lb is inside a word, get the first part of that word -->
                  <xsl:if test="//tei:lb[attribute::n=$nextline][preceding::tei:lb[1][attribute::rend][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]/ancestor::tei:w"> 
                      <xsl:choose> <!-- BS: new by 2/3: add red display if part of head --> 
                          <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='3'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/ancestor::tei:head"> 
                              <xsl:element name="tei:head">
                                  <xsl:attribute name="type">rend_variable</xsl:attribute>
                                  <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                      <xsl:choose> 
                                          <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='3'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]][descendant::me:facs]"> 
                                              <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='3'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                          </xsl:when>
                                          <xsl:otherwise>
                                              <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='3'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                                          </xsl:otherwise>
                                      </xsl:choose>
                                  </xsl:element>
                              </xsl:element>
                          </xsl:when>
                          <xsl:otherwise>
                              <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                  <xsl:choose>
                                      <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='3'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]][descendant::me:facs]"> 
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='3'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                      </xsl:when>
                                      <xsl:otherwise>
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='3'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                                      </xsl:otherwise>
                                  </xsl:choose>
                              </xsl:element>
                          </xsl:otherwise>
                      </xsl:choose>
                  </xsl:if>
              <xsl:text></xsl:text>
              </xsl:variable>
              
              <xsl:variable name="line-seg-4">
                  <!-- if the beginning lb is inside a word, get the last part of that word -->
                  <xsl:if test="//tei:lb[attribute::n=$line][attribute::rend='4'][preceding::tei:pb[1]/attribute::n=$preceding-pb]/ancestor::tei:w">
                      
                      <xsl:choose> 
                          <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='4'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/ancestor::tei:head"> 
                              <xsl:element name="tei:head">
                                  <xsl:attribute name="type">rend_variable</xsl:attribute>
                                  <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                      <xsl:choose> 
                                          <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='4'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]][descendant::me:facs]"> 
                                              <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='4'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                          </xsl:when>
                                          <xsl:otherwise>
                                              <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='4'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                          </xsl:otherwise>
                                      </xsl:choose>
                                  </xsl:element>
                              </xsl:element>
                          </xsl:when>
                          <xsl:otherwise>
                              <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                  <xsl:choose> 
                                      <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='4'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]][descendant::me:facs]"> 
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='4'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                      </xsl:when>
                                      <xsl:otherwise>
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='4'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-pb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                      </xsl:otherwise>
                                  </xsl:choose>
                              </xsl:element>
                          </xsl:otherwise>
                      </xsl:choose> 
                  </xsl:if>
                 
                  <!-- get the complete words --> <!-- new by Dec 2020 -->
                  <!--  if part of header than wrap in <head> markup -->
                  <xsl:for-each select="//tei:w[preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='4'][not(descendant::tei:lb[attribute::rend])][not(parent::tei:num)]|//tei:num[preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='4']|//me:punct[preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='4']|//tei:pc[not(ancestor::tei:w or ancestor::tei:num)][preceding::tei:pb[1][attribute::n=$preceding-pb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='4']">
                      <xsl:choose>
                          <xsl:when test="ancestor::tei:head">
                              <xsl:element name="tei:head">
                                  <xsl:attribute name="type">rend_variable</xsl:attribute>
                                  <xsl:copy-of select="."></xsl:copy-of>
                              </xsl:element>
                          </xsl:when>
                          <xsl:otherwise> <xsl:copy-of select="."></xsl:copy-of></xsl:otherwise>
                      </xsl:choose>
                  </xsl:for-each>
                  
                  <!-- if the following lb is inside a word, get the first part of that word -->
                  <xsl:if test="//tei:lb[attribute::n=$nextline][preceding::tei:lb[1][attribute::rend='4'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]/ancestor::tei:w"> 
                      <xsl:choose> 
                          <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='4'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/ancestor::tei:head"> 
                              <xsl:element name="tei:head">
                                  <xsl:attribute name="type">rend_variable</xsl:attribute>
                                  <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                      <xsl:choose> 
                                          <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='4'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]][descendant::me:facs]"> 
                                              <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='4'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                          </xsl:when>
                                          <xsl:otherwise>
                                              <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='4'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                                          </xsl:otherwise>
                                      </xsl:choose>
                                  </xsl:element>
                              </xsl:element>
                          </xsl:when>
                          <xsl:otherwise>
                              <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                  <xsl:choose> 
                                      <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='4'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]][descendant::me:facs]"> 
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='4'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                      </xsl:when>
                                      <xsl:otherwise>
                                          <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='4'][preceding::tei:pb[1][attribute::n=$preceding-pb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                                      </xsl:otherwise>
                                  </xsl:choose>
                              </xsl:element>
                          </xsl:otherwise>
                      </xsl:choose>
                  </xsl:if>
              </xsl:variable>
              
              <xsl:apply-templates select="$line-seg-1" mode="rend"/>
              <xsl:apply-templates select="$line-seg-2" mode="rend"/>
              <xsl:apply-templates select="$line-seg-3" mode="rend"/>
              <xsl:apply-templates select="$line-seg-4" mode="rend"/>
              
                  </xsl:when>
                  <xsl:otherwise>  <!-- for multi-column manuscripts -->
                      
                      <xsl:variable name="line-seg-A">
                          <xsl:text></xsl:text>
                          <!-- if the beginning lb is inside a word, get the last part of that word -->
                          <xsl:if test="//tei:lb[attribute::n=$line][attribute::rend='1'][preceding::tei:cb[1]/attribute::n=$preceding-cb]/ancestor::tei:w">
                              
                              <xsl:choose> 
                                  <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='1'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/ancestor::tei:head"> 
                                      <xsl:element name="tei:head">
                                          <xsl:attribute name="type">rend_variable</xsl:attribute>
                                          <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                              <xsl:choose> 
                                                  <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='1'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]][descendant::me:facs]"> 
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='1'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='1'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                                  </xsl:otherwise>
                                              </xsl:choose>
                                          </xsl:element>
                                      </xsl:element>
                                  </xsl:when>
                                  <xsl:otherwise>
                                      <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                          <xsl:choose> 
                                              <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='1'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]][descendant::me:facs]"> 
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='1'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                              </xsl:when>
                                              <xsl:otherwise>
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='1'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                              </xsl:otherwise>
                                          </xsl:choose>
                                      </xsl:element>
                                  </xsl:otherwise>
                              </xsl:choose> 
                          </xsl:if>
                          
                          <!-- get the complete words -->
                          <!-- if part of header than wrap in <head> markup -->
                          <xsl:for-each select="//tei:w[preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='1'][not(descendant::tei:lb[attribute::rend])][not(parent::tei:num)]|//tei:num[preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='1']|//me:punct[preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='1']|//tei:pc[not(ancestor::tei:w or ancestor::tei:num)][preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='1']">
                              <xsl:choose>
                                  <xsl:when test="ancestor::tei:head">
                                      <xsl:element name="tei:head">
                                          <xsl:attribute name="type">rend_variable</xsl:attribute>
                                          <xsl:copy-of select="."></xsl:copy-of>
                                      </xsl:element>
                                  </xsl:when>
                                  <xsl:otherwise> <xsl:copy-of select="."></xsl:copy-of></xsl:otherwise>
                              </xsl:choose>
                          </xsl:for-each>
                          
                          <!-- if the following lb is inside a word, get the first part of that word -->
                          <xsl:if test="//tei:lb[attribute::n=$nextline][preceding::tei:lb[1][attribute::rend='1'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]/ancestor::tei:w"> 
                              <xsl:choose> <!-- BS: new by 2/3: add red display if part of head --> 
                                  <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='1'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/ancestor::tei:head"> 
                                      <xsl:element name="tei:head">
                                          <xsl:attribute name="type">rend_variable</xsl:attribute>
                                          <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                              <xsl:choose> 
                                                  <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='1'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]][descendant::me:facs]"> 
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='1'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='1'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                                                  </xsl:otherwise>
                                              </xsl:choose>
                                          </xsl:element>
                                      </xsl:element>
                                  </xsl:when>
                                  <xsl:otherwise>
                                      <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                          <xsl:choose> 
                                              <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='1'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]][descendant::me:facs]"> 
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='1'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                              </xsl:when>
                                              <xsl:otherwise>
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='1'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                                              </xsl:otherwise>
                                          </xsl:choose>
                                      </xsl:element>
                                  </xsl:otherwise>
                              </xsl:choose>
                          </xsl:if>
                          <xsl:text></xsl:text>
                      </xsl:variable>
                      
                      <xsl:variable name="line-seg-B">
                          <xsl:text></xsl:text>
                          <!-- if the beginning lb is inside a word, get the last part of that word --> 
                          <xsl:if test="//tei:lb[attribute::n=$line][attribute::rend='2'][preceding::tei:cb[1]/attribute::n=$preceding-cb]/ancestor::tei:w">
                              
                              <xsl:choose> 
                                  <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='2'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/ancestor::tei:head"> 
                                      <xsl:element name="tei:head">
                                          <xsl:attribute name="type">rend_variable</xsl:attribute>
                                          <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                              <xsl:choose> 
                                                  <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='2'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]][descendant::me:facs]"> 
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='2'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='2'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                                  </xsl:otherwise>
                                              </xsl:choose>
                                          </xsl:element>
                                      </xsl:element>
                                  </xsl:when>
                                  <xsl:otherwise>
                                      <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                          <xsl:choose> 
                                              <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='2'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]][descendant::me:facs]"> 
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='2'][attribute::n=$line][preceding::tei:pb[1][attribute::n=$preceding-cb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                              </xsl:when>
                                              <xsl:otherwise>
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='2'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                              </xsl:otherwise>
                                          </xsl:choose>
                                      </xsl:element>
                                  </xsl:otherwise>
                              </xsl:choose> 
                          </xsl:if>
                          <!-- get the complete words -->
                          <!-- if part of header than wrap in <head> markup -->
                          <xsl:for-each select="//tei:w[preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='2'][not(descendant::tei:lb[attribute::rend])][not(parent::tei:num)]|//tei:num[preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='2']|//me:punct[preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='2']|//tei:pc[not(ancestor::tei:w or ancestor::tei:num)][preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='2']">
                              <xsl:choose>
                                  <xsl:when test="ancestor::tei:head">
                                      <xsl:element name="tei:head">
                                          <xsl:attribute name="type">rend_variable</xsl:attribute>
                                          <xsl:copy-of select="."></xsl:copy-of>
                                      </xsl:element>
                                  </xsl:when>
                                  <xsl:otherwise> <xsl:copy-of select="."></xsl:copy-of></xsl:otherwise>
                              </xsl:choose>
                          </xsl:for-each>
                          
                          <!-- if the following lb is inside a word, get the first part of that word -->
                          <xsl:if test="//tei:lb[attribute::n=$nextline][preceding::tei:lb[1][attribute::rend='2'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]/ancestor::tei:w"> 
                              <xsl:choose> <!-- BS: new by 2/3: add red display if part of head --> 
                                  <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='2'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/ancestor::tei:head"> 
                                      <xsl:element name="tei:head">
                                          <xsl:attribute name="type">rend_variable</xsl:attribute>
                                          <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                              <xsl:choose> 
                                                  <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='2'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]][descendant::me:facs]"> 
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='2'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='2'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                                                  </xsl:otherwise>
                                              </xsl:choose>
                                          </xsl:element>
                                      </xsl:element>
                                  </xsl:when>
                                  <xsl:otherwise>
                                      <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                          <xsl:choose> 
                                              <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='2'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]][descendant::me:facs]"> 
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='2'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                              </xsl:when>
                                              <xsl:otherwise>
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='2'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                                              </xsl:otherwise>
                                          </xsl:choose>
                                      </xsl:element>
                                  </xsl:otherwise>
                              </xsl:choose>
                          </xsl:if>
                          <xsl:text></xsl:text>
                      </xsl:variable>
                      
                      <xsl:variable name="line-seg-C">
                          <xsl:text></xsl:text>
                          <!-- if the beginning lb is inside a word, get the last part of that word -->
                          <xsl:if test="//tei:lb[attribute::n=$line][attribute::rend='3'][preceding::tei:cb[1]/attribute::n=$preceding-cb]/ancestor::tei:w">
                              
                              <xsl:choose> 
                                  <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='3'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/ancestor::tei:head"> 
                                      <xsl:element name="tei:head">
                                          <xsl:attribute name="type">rend_variable</xsl:attribute>
                                          <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                              <xsl:choose> 
                                                  <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='3'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]][descendant::me:facs]"> 
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='3'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='3'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                                  </xsl:otherwise>
                                              </xsl:choose>
                                          </xsl:element>
                                      </xsl:element>
                                  </xsl:when>
                                  <xsl:otherwise>
                                      <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                          <xsl:choose> 
                                              <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='3'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]][descendant::me:facs]"> 
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='3'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                              </xsl:when>
                                              <xsl:otherwise>
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='3'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                              </xsl:otherwise>
                                          </xsl:choose>
                                      </xsl:element>
                                  </xsl:otherwise>
                              </xsl:choose> 
                          </xsl:if>
                          
                          <!-- get the complete words -->
                          <!-- if part of header than wrap in <head> markup -->
                          <xsl:for-each select="//tei:w[preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='3'][not(descendant::tei:lb[attribute::rend])][not(parent::tei:num)]|//tei:num[preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='3']|//me:punct[preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='3']|//tei:pc[not(ancestor::tei:w or ancestor::tei:num)][preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='3']">
                              <xsl:choose>
                                  <xsl:when test="ancestor::tei:head">
                                      <xsl:element name="tei:head">
                                          <xsl:attribute name="type">rend_variable</xsl:attribute>
                                          <xsl:copy-of select="."></xsl:copy-of>
                                      </xsl:element>
                                  </xsl:when>
                                  <xsl:otherwise> <xsl:copy-of select="."></xsl:copy-of></xsl:otherwise>
                              </xsl:choose>
                          </xsl:for-each>
                          
                          <!-- if the following lb is inside a word, get the first part of that word -->
                          <xsl:if test="//tei:lb[attribute::n=$nextline][preceding::tei:lb[1][attribute::rend][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]/ancestor::tei:w"> 
                              <xsl:choose> <!-- BS: new by 2/3: add red display if part of head --> 
                                  <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='3'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/ancestor::tei:head"> 
                                      <xsl:element name="tei:head">
                                          <xsl:attribute name="type">rend_variable</xsl:attribute>
                                          <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                              <xsl:choose> 
                                                  <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='3'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]][descendant::me:facs]"> 
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='3'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='3'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                                                  </xsl:otherwise>
                                              </xsl:choose>
                                          </xsl:element>
                                      </xsl:element>
                                  </xsl:when>
                                  <xsl:otherwise>
                                      <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                          <xsl:choose> 
                                              <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][attribute::rend='3'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]][descendant::me:facs]"> 
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][attribute::rend='3'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                              </xsl:when>
                                              <xsl:otherwise>
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][attribute::rend='3'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                                              </xsl:otherwise>
                                          </xsl:choose>
                                      </xsl:element>
                                  </xsl:otherwise>
                              </xsl:choose>
                          </xsl:if>
                          <xsl:text></xsl:text>
                      </xsl:variable>
                      
                      <xsl:variable name="line-seg-D">
                          <!-- if the beginning lb is inside a word, get the last part of that word -->
                          <xsl:if test="//tei:lb[attribute::n=$line][attribute::rend='4'][preceding::tei:cb[1]/attribute::n=$preceding-cb]/ancestor::tei:w">
                              
                              <xsl:choose> 
                                  <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='4'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/ancestor::tei:head"> 
                                      <xsl:element name="tei:head">
                                          <xsl:attribute name="type">rend_variable</xsl:attribute>
                                          <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                              <xsl:choose> 
                                                  <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='4'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]][descendant::me:facs]"> 
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='4'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='4'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                                  </xsl:otherwise>
                                              </xsl:choose>
                                          </xsl:element>
                                      </xsl:element>
                                  </xsl:when>
                                  <xsl:otherwise>
                                      <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                          <xsl:choose> 
                                              <xsl:when test="//tei:w[descendant::tei:lb[attribute::rend='4'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]][descendant::me:facs]"> 
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='4'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/descendant::me:facs/node()[not(position()=1)][preceding::tei:lb[1][ancestor::me:facs]]"/>
                                              </xsl:when>
                                              <xsl:otherwise>
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[attribute::rend='4'][attribute::n=$line][preceding::tei:cb[1][attribute::n=$preceding-cb]]]/node()[not(position()=1)][preceding::tei:lb[1][ancestor::tei:w]]"/> 
                                              </xsl:otherwise>
                                          </xsl:choose>
                                      </xsl:element>
                                  </xsl:otherwise>
                              </xsl:choose> 
                          </xsl:if>
                          
                          <!-- get the complete words -->
                          <!-- if part of header than wrap in <head> markup -->
                          <xsl:for-each select="//tei:w[preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='4'][not(descendant::tei:lb[attribute::rend])][not(parent::tei:num)]|//tei:num[preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='4']|//me:punct[preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='4']|//tei:pc[not(ancestor::tei:w or ancestor::tei:num)][preceding::tei:cb[1][attribute::n=$preceding-cb]][preceding::tei:lb[1]/attribute::n=$line][preceding::tei:lb[1]/attribute::rend='4']">
                              <xsl:choose>
                                  <xsl:when test="ancestor::tei:head">
                                      <xsl:element name="tei:head">
                                          <xsl:attribute name="type">rend_variable</xsl:attribute>
                                          <xsl:copy-of select="."></xsl:copy-of>
                                      </xsl:element>
                                  </xsl:when>
                                  <xsl:otherwise> <xsl:copy-of select="."></xsl:copy-of></xsl:otherwise>
                              </xsl:choose>
                          </xsl:for-each>
                          
                          <!-- if the following lb is inside a word, get the first part of that word -->
                          <xsl:if test="//tei:lb[attribute::n=$nextline][preceding::tei:lb[1][attribute::rend='4'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]/ancestor::tei:w"> 
                              <xsl:choose> <!-- BS: new by 2/3: add red display if part of head --> 
                                  <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='4'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/ancestor::tei:head"> 
                                      <xsl:element name="tei:head">
                                          <xsl:attribute name="type">rend_variable</xsl:attribute>
                                          <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                              <xsl:choose> 
                                                  <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='4'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]][descendant::me:facs]"> 
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='4'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                      <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='4'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                                                  </xsl:otherwise>
                                              </xsl:choose>
                                          </xsl:element>
                                      </xsl:element>
                                  </xsl:when>
                                  <xsl:otherwise>
                                      <xsl:element name="tei:w"><!-- wrap the part in a w, so that the white spaces are displayed correctly -->
                                          <xsl:choose> 
                                              <xsl:when test="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='4'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]][descendant::me:facs]"> 
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='4'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/descendant::me:facs/node()[following::tei:lb[1][ancestor::me:facs]]"/>
                                              </xsl:when>
                                              <xsl:otherwise>
                                                  <xsl:value-of select="//tei:w[descendant::tei:lb[preceding::tei:lb[1][not(ancestor::me:dipl or ancestor::me:norm)][attribute::rend='4'][preceding::tei:cb[1][attribute::n=$preceding-cb]][attribute::n=$line]]]/node()[following::tei:lb[1][ancestor::tei:w]]"/> 
                                              </xsl:otherwise>
                                          </xsl:choose>
                                      </xsl:element>
                                  </xsl:otherwise>
                              </xsl:choose>
                          </xsl:if>
                      </xsl:variable>
                      
                      <xsl:apply-templates select="$line-seg-A" mode="rend"/>
                      <xsl:apply-templates select="$line-seg-B" mode="rend"/>
                      <xsl:apply-templates select="$line-seg-C" mode="rend"/>
                      <xsl:apply-templates select="$line-seg-D" mode="rend"/>
                      
                  </xsl:otherwise>
              </xsl:choose>
              
          </xsl:if>
        <!-- end of new code -->
        </xsl:when>
        
<!-- The "otherwise" condition specifies that if line numbers are not encoded in the XML file, lines will be displayed with the same kind of formatting (hanging indents) as above, but with no line numbers. -->

        <xsl:otherwise>
        <xsl:element name="SPAN">
        <xsl:attribute name="class">linecount</xsl:attribute>
                    <xsl:text>&nbsp;</xsl:text>
		</xsl:element>
		</xsl:otherwise>
		</xsl:choose>
    </xsl:when>
   
    
<xsl:otherwise>
 </xsl:otherwise>   
    </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>
    
</xsl:template>

<!-- Template for headings -->
    

<!-- This template specifies that in a facs rendering, the head is displayed inline (and in red). 
        In other renderings (such as dipl and norm) the head is displayed as a block element. -->

<xsl:template match="tei:head">
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs')">  
           
            <xsl:choose>  
                <xsl:when test="preceding::tei:lb[1][attribute::rend]"><xsl:apply-templates/>
                </xsl:when>
               
                               <xsl:otherwise>
                  <xsl:element name="SPAN">
                       <xsl:attribute name="style">
                           <xsl:text>display: inline; </xsl:text>
                           <xsl:text>color: red;</xsl:text>
                       </xsl:attribute>
                       <xsl:apply-templates/>
                  </xsl:element>
                
            </xsl:otherwise>
            </xsl:choose> 
            
        </xsl:when>
        <xsl:otherwise>
            <xsl:element name="DIV">
                <xsl:if test="parent::tei:div/attribute::type='work'">
                    <xsl:attribute name="class">divwork</xsl:attribute>
                </xsl:if>
                <xsl:if test="parent::tei:div/attribute::type='chapter'">
                            <xsl:if test="contains($visning, 'norm')"><xsl:attribute name="class">divchapter_norm</xsl:attribute></xsl:if>
                    <xsl:if test="contains($visning, 'dipl')"><xsl:attribute name="class">divchapter</xsl:attribute></xsl:if>
                    <xsl:if test="contains($visning, 'facs')"><xsl:attribute name="class">divchapter</xsl:attribute></xsl:if>
                    
                </xsl:if>
                <xsl:if test="parent::tei:div[not(attribute::type='chapter')]">
                    <xsl:if test="contains($visning, 'norm')"><xsl:attribute name="class">divchapter_norm</xsl:attribute></xsl:if>
                    <xsl:if test="contains($visning, 'dipl')"><xsl:attribute name="class">divchapter</xsl:attribute></xsl:if>
                    <xsl:if test="contains($visning, 'facs')"><xsl:attribute name="class">divchapter</xsl:attribute></xsl:if>
                    
                </xsl:if>
                    <xsl:apply-templates/>
            </xsl:element>        
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>
    
    <!-- new by BS: display headers in reorganised lines in red -->
    <xsl:template match="tei:head" mode="rend">
        <xsl:element name="SPAN">
            <xsl:attribute name="style">
                <xsl:text>display: inline;</xsl:text>
                <xsl:text> color: red;</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates mode="rend"/>
        </xsl:element>
    </xsl:template>


<!-- Templates for displaying the text itself -->

<!-- This template refers to the body element, but does not have any formatting associated with it. -->

<xsl:template match="tei:body">
    <xsl:apply-templates/>
</xsl:template>

<!-- This template specifies the width of the text blocks. In facs, the block is 650 px wide; in other renderings (such as dipl or norm) there are no specification for the width.-->

<xsl:template match="tei:div">
    <xsl:choose>
        <xsl:when test="attribute::type='work'">
            <xsl:element name="DIV">
            <xsl:attribute name="style">margin-left: 10px</xsl:attribute>
                <xsl:if test="contains($visning, 'facs')">
            <xsl:attribute name="style">width: 650px</xsl:attribute>
            </xsl:if>
                <xsl:apply-templates/>
            </xsl:element>        
        </xsl:when>
        <xsl:otherwise>
            <xsl:choose>
                <xsl:when test="contains($visning, 'facs')">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="DIV">
                        <xsl:apply-templates/>
                    </xsl:element>                
                </xsl:otherwise>
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- This template wraps the p elements in SPAN tags with an associated style class.-->
<xsl:template match="tei:p">
 
        <xsl:if test="./preceding-sibling::tei:p"> <!-- new condition BS Nov 2019 -->
            <xsl:choose>
                <xsl:when test="contains($visning, 'facs')"></xsl:when>
                <xsl:otherwise><BR/></xsl:otherwise>
            </xsl:choose>
        </xsl:if>
            <xsl:element name="SPAN">
            <xsl:attribute name="class">paragraph</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
</xsl:template>
    

<!-- This template specifies that in facs, line groups (typically stanzas) are displayed inline. In other renderings (such as dipl and norm), the lg elements are wrapped in DIV tags with an associated style class. If line groups (stanzas) have been numbered by the encoder, these numbers will be displayed in the top left corner of the line group. -->

<xsl:template match="tei:lg">
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs')">
            <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:element name="DIV">
                <xsl:attribute name="class">linegroup</xsl:attribute>
               <xsl:if test="attribute::n">
               <xsl:element name="SPAN">
               <xsl:attribute name="STYLE">float: left</xsl:attribute>
               <xsl:value-of select="attribute::n"/>
               </xsl:element>
               </xsl:if>
               <xsl:apply-templates/>
            </xsl:element>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- This template does not affect facs display. In other renderings (such as dipl and norm), lines are numbered automatically within each lg element.-->

<xsl:template match="tei:l">
<xsl:variable name="lgline">
    <xsl:number level="any" from="tei:lg"/>
</xsl:variable>
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs')">
            <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:element name="BR"></xsl:element>
            <xsl:element name="SPAN">
            <xsl:attribute name="class">lglines</xsl:attribute>
                <xsl:value-of select="$lgline"/>
            </xsl:element>
                <xsl:apply-templates/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- This template refers to the word element, but does not have any formatting associated with it. -->
<!-- Since spaces inside p elements are stripped from the file (see general comment at the start of the stylesheet), a function has been created within this template to generate spaces after individual words, but not before punctuation marks. -->    

<xsl:template match="tei:w | tei:num | tei:name[not(ancestor::tei:respStmt)] | tei:persName[not(ancestor::tei:respStmt)] | tei:orgName[not(ancestor::tei:respStmt)]">
    <xsl:choose> 

        <xsl:when test="contains($visning, 'facs')"> 
            <!-- beginning new by BS -->
            <xsl:choose>
                <xsl:when test="preceding::tei:lb[1][attribute::rend][not(descendant::tei:lb/attribute::rend)]">
                    <!-- new by 9/2-2017: do not display elements that are immediately preceeded by a lb with @rend -->                    
                </xsl:when>
                <!-- when there is a lb with @rend inside of the first word (i.e. it is also not preceded by another lb with @rend on the same of previous line), show the first part -->
                <xsl:when test="self::tei:w[descendant::tei:lb[attribute::rend]][preceding::tei:lb[1][not(attribute::rend)]]">
                    <xsl:value-of select="descendant::node()[1][following::tei:lb[1][ancestor::tei:w]]"/>
                    <!-- white space hard coded (possibly needs to be adjusted) -->
                    <xsl:text>&nbsp;</xsl:text>
                </xsl:when> 
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when> 
        <!-- end new by BS -->
        
        <xsl:otherwise> <!-- i.e. $visning does not contain 'facs' --> 
            <xsl:choose>
                <xsl:when test="preceding-sibling::*[1][self::me:punct/ancestor::place='rightlocation']">
                    <!-- If it is a punct with right location, do not add a space (Menota 2.0). -->
                </xsl:when>
                <xsl:when test="preceding-sibling::*[1][self::tei:pc/ancestor::place='rightlocation']">
                    <!-- If it is a punct with right location, do not add a space (Menota 2.0). -->
                </xsl:when>
                <xsl:when test="preceding-sibling::*[1][self::me:punct/ancestor::rend='rightlocation']">
                    <!-- same as above, but for different markup -->
                </xsl:when>
                <xsl:when test="preceding-sibling::*[1][self::tei:pc/ancestor::rend='rightlocation']">
                    <!-- same as above, but for different markup (Menota 3.0) -->
                </xsl:when>
                <xsl:when test="preceding-sibling::*[1][self::me:punct] or preceding-sibling::*[1][self::tei:supplied] or preceding-sibling::*[1][self::tei:quote]"> 
                    <xsl:text>&nbsp;</xsl:text>        
                </xsl:when>
                <xsl:when test="preceding-sibling::*[1][self::tei:pc] or preceding-sibling::*[1][self::tei:seg/@type='enc'] or preceding-sibling::*[1][self::tei:seg/@type='nb'] or preceding-sibling::*[1][self::tei:q]">
                    <xsl:text>&nbsp;</xsl:text>        <!-- new by Nov 2019 BS: added seg and q -->
                </xsl:when>
                <xsl:when test="contains($visning, 'norm') and preceding-sibling::*[1][self::tei:lb] and not(descendant::me:expunged) and not(descendant::me:suppressed)">
                    <xsl:text>&nbsp;</xsl:text> 
                </xsl:when>
                    
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="not(preceding-sibling::*[1]) and ancestor::tei:caption">
                            <xsl:text>&nbsp;</xsl:text> 
                        </xsl:when>
                        <xsl:when test="not(preceding-sibling::*[1]) and ancestor::tei:quote">
                            <xsl:text>&nbsp;</xsl:text> 
                        </xsl:when>   
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
            
            <xsl:apply-templates/>
            
        </xsl:otherwise>
    </xsl:choose>
        
    <!--[<xsl:value-of select="name(.)"/>:<xsl:value-of select="."/> - <xsl:value-of select="name(following-sibling::*[1])"/>:<xsl:value-of select="following-sibling::*[1]"/>]-->
    <xsl:choose>
        <xsl:when test="following-sibling::*[1][self::me:punct]"></xsl:when>
        <xsl:when test="following-sibling::*[1][self::tei:pc]"></xsl:when>
        <xsl:when test="ancestor::tei:corr and not(following-sibling::*[1][self::tei:w]) and following::*[1][self::tei:pc]">
            <!-- new by BS, Jan 2020: no white space if corr is followed by pc -->
        </xsl:when>
        <xsl:when test="ancestor::tei:sic and not(following-sibling::*[1][self::tei:w]) and ancestor::tei:choice/following::*[1][self::tei:pc]">
            <!-- new by BS, Feb 2020: no white space if sic is followed by pc -->
        </xsl:when> 
        <xsl:when test="ancestor::tei:orig and not(following-sibling::*[1][self::tei:w]) and ancestor::tei:choice/following::*[1][self::tei:pc]">
            <!-- new by BS, Feb 2020: no white space if orig is followed by pc -->
        </xsl:when> 
        <xsl:when test="ancestor::tei:reg and not(following-sibling::*[1][self::tei:w]) and following::*[1][self::tei:pc]">
            <!-- new by BS, Feb 2020: no white space if reg is followed by pc -->
        </xsl:when> 
        <xsl:when test="ancestor::tei:del and not(following-sibling::tei:w)">
            <!-- new by BS, Jan 2020: no white space when last word wihtin del -->
        </xsl:when>  
        <xsl:when test="ancestor::tei:surplus and not(following-sibling::tei:w)">
            <!-- new by BS, Jan 2020: no white space when last word wihtin surplus -->
        </xsl:when>
        <xsl:when test="ancestor::me:suppressed and not(following-sibling::tei:w)">
            <!-- new by BS, Jan 2020: no white space when last word wihtin suppressed -->
        </xsl:when> 
        <xsl:when test="following-sibling::*[1][self::tei:anchor[attribute::type='supplied' or attribute::type='seg']] and not(following-sibling::*[2])"></xsl:when>
        <xsl:when test="following-sibling::*[1][self::tei:w][descendant::me:expunged] and contains($visning, 'norm')"></xsl:when>
        <xsl:when test="following-sibling::*[1][self::tei:w][descendant::me:suppressed] and contains($visning, 'norm')"></xsl:when>
        <xsl:when test="following-sibling::*[1][self::tei:w] and ancestor::tei:seg[attribute::type='enc']"></xsl:when>
        <xsl:when test="following-sibling::*[1][self::tei:w] and ancestor::tei:seg[attribute::type='nb'] and contains($visning, 'facs')"></xsl:when><!-- Changed from norm to facs BS Nov 2019-->
        <xsl:when test="not(following-sibling::*[1][self::tei:w]) and following-sibling::*[2][self::tei:w][descendant::me:expunged] and contains($visning, 'norm')"></xsl:when>
        <xsl:when test="not(following-sibling::*[1][self::tei:w]) and following-sibling::*[2][self::tei:w][descendant::me:suppressed] and contains($visning, 'norm')"></xsl:when>
        <xsl:when test="contains($visning, 'norm') and ancestor::tei:q and position()=last()">
            <!-- new by 19/7-2017 BS: do not output a white space after the last element/word within quotation marks-->
        </xsl:when> 
        <!--<xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::tei:seg[attribute::type='nb'][following-sibling::*[1][self::me:punct]]"></xsl:when>-->
        <!--<xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::tei:unclear[following-sibling::*[1][self::me:punct]]"></xsl:when>-->
        <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::node()[following-sibling::*[1][self::me:punct]]"></xsl:when>
        <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::node()[following-sibling::*[1][self::tei:pc]]"></xsl:when>
        <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::node()[following-sibling::*[1][self::tei:anchor[attribute::type='supplied']]]"></xsl:when>
        <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::tei:supplied[following-sibling::*[1][self::tei:w]]"></xsl:when>
        <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::tei:supplied[not(following-sibling::*[1])]"></xsl:when>
        <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::tei:add[following-sibling::*[1][self::tei:w]]"></xsl:when>
        <xsl:when test="not(following-sibling::*[1][self::tei:w]) and following-sibling::*[1][self::tei:anchor] and following-sibling::*[2][self::me:punct]"></xsl:when>
        <xsl:when test="not(following-sibling::*[1][self::tei:w]) and following-sibling::*[1][self::tei:anchor] and following-sibling::*[2][self::tei:pc]"></xsl:when>

        <!-- ADDED BY GIOVANNI VERRI FOR PERSONAL USE HIS IN HIS PALS SAGA PROJECT -->
        <xsl:when test="following-sibling::*[1][(self::tei:w | self::gv:spc)] and ancestor::tei:seg[@type='mis'] and contains($visning, 'facs')"></xsl:when>

        <xsl:otherwise>
            <xsl:text>&nbsp;</xsl:text>                    
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>
    
    
    <!-- new by BS: additional template (in rend-mode) to parse words that have been reorganised (in variables created in template for tei:lb) -->
    <xsl:template match="tei:w | tei:num | tei:name | tei:persName | tei:orgName" mode="rend">
        
       
        
        <xsl:choose>
            
                    <xsl:when test="preceding-sibling::*[1][self::me:punct/ancestor::place='rightlocation']">
                      </xsl:when>
            <xsl:when test="preceding-sibling::*[1][self::tei:pc/ancestor::place='rightlocation']"> <!-- repeated for different markup (backwards compatibility) -->
            </xsl:when>
            <xsl:when test="preceding-sibling::*[1][self::me:punct/ancestor::rend='rightlocation']"> <!-- repeated for different markup (backwards compatibility) -->
            </xsl:when>
            <xsl:when test="preceding-sibling::*[1][self::tei:pc/ancestor::rend='rightlocation']"> <!-- repeated for different markup (backwards compatibility) -->
            </xsl:when>
                    <xsl:when test="preceding-sibling::*[1][self::me:punct] or preceding-sibling::*[1][self::tei:supplied] or preceding-sibling::*[1][self::tei:quote] or preceding-sibling::*[1][self::tei:add]">
                        <xsl:text>&nbsp;</xsl:text>        
                    </xsl:when>
            <xsl:when test="preceding-sibling::*[1][self::tei:pc] or preceding-sibling::*[1][self::tei:seg/@type='enc'] or preceding-sibling::*[1][self::tei:seg/@type='nb']"> <!-- changed Nov 2019 by BS to match regular words -->
                <xsl:text>&nbsp;</xsl:text>        
            </xsl:when>
                   
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="not(preceding-sibling::*[1]) and ancestor::tei:caption">
                                <xsl:text>&nbsp;</xsl:text> 
                            </xsl:when>
                            <xsl:when test="not(preceding-sibling::*[1]) and ancestor::tei:quote">
                                <xsl:text>&nbsp;</xsl:text> 
                            </xsl:when>                
                            <xsl:otherwise></xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>    
                <xsl:apply-templates/>
        
        <xsl:choose>
            <xsl:when test="following-sibling::*[1][self::me:punct]"></xsl:when>
            <xsl:when test="following-sibling::*[1][self::tei:pc]"></xsl:when>
            <xsl:when test="following-sibling::*[1][self::tei:anchor[attribute::type='supplied' or attribute::type='seg']] and not(following-sibling::*[2])"></xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    
                    <xsl:when test="following-sibling::*[1][self::tei:w] and ancestor::tei:seg[attribute::type='enc']"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::node()[following-sibling::*[1][self::me:punct]]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::node()[following-sibling::*[1][self::tei:pc]]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::node()[following-sibling::*[1][self::tei:anchor[attribute::type='supplied']]]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::tei:supplied[following-sibling::*[1][self::tei:w]]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::tei:supplied[not(following-sibling::*[1])]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::tei:add[following-sibling::*[1][self::tei:w]]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and following-sibling::*[1][self::tei:anchor] and following-sibling::*[2][self::me:punct]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and following-sibling::*[1][self::tei:anchor] and following-sibling::*[2][self::tei:pc]"></xsl:when>
                    <xsl:when test="contains($visning, 'norm') and ancestor::tei:q and position()=last()"></xsl:when> 
                    <xsl:otherwise>
                        <xsl:text>&nbsp;</xsl:text>                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
      
    </xsl:template>
    
   

	<!-- Allways add a space after a punct-element, unless it is a right location punct, when the space should be before the punct, or pc is used inside of a word
	    or when the punctuation character is part of a rearranged line  -->
    <xsl:template match="me:punct | tei:pc | punct" mode="#all">  <!-- adjusted by BS 6/3 2017 -->
        <xsl:choose>
            <xsl:when test="attribute::place='rightlocation'">
                <xsl:text>&nbsp;</xsl:text>
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="attribute::rend='rightlocation'"> <!-- repeated for variant markup -->
                <xsl:text>&nbsp;</xsl:text>
                <xsl:apply-templates/>
            </xsl:when>
            
            <xsl:when test="self::tei:pc[ancestor::tei:num]/preceding::tei:lb[1]/attribute::rend"><xsl:apply-templates/></xsl:when> <!-- new by BS Jan 2021 -->
            <xsl:when test="preceding::tei:lb[1]/attribute::rend"></xsl:when> <!-- new by BS 2019-->
            
            <!-- new by BS for Menota 3.1 (Dec 2020/Jan 2021) -->
            <xsl:when test="contains($visning, 'facs') and ancestor::tei:w"><xsl:apply-templates/></xsl:when>
            <xsl:when test="contains($visning, 'dipl') and self::tei:pc[contains(., '.')]/ancestor::tei:w"><xsl:apply-templates/></xsl:when> <!-- display dot wrapped in pc -->
            <xsl:when test="contains($visning, 'dipl') and ancestor::tei:w"></xsl:when> <!-- do not display other pc elements within, i.e. not hyphens -->
            <xsl:when test="contains($visning, 'norm') and ancestor::tei:w"></xsl:when>
            <xsl:when test="ancestor::tei:num"><xsl:apply-templates/></xsl:when>
         
            <xsl:otherwise> 
                
                <xsl:apply-templates/>
                <xsl:choose>
                    <xsl:when test="following-sibling::*[1][self::tei:anchor]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::tei:supplied"></xsl:when>
                    <xsl:when test="ancestor::tei:q and position()=last()"></xsl:when> <!-- no white space if last element within q  -->
                    <xsl:otherwise><xsl:text>&nbsp;</xsl:text></xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
	

<!-- The following three templates specify the display of the three main text levels, facs, dipl and norm.  -->
<!-- If the parameter "visning" contains the value "facs" the contents of the facs elements are output; otherwise the facs elements are suppressed.  -->

	<xsl:template match="tei:facs | facs | me:facs">
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs')">
            <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- If the parameter "visning" contains the value "dipl" the contents of the dipl elements are output; otherwise the dipl elements are suppressed.  -->
<!-- If the dipl element contains the attribute corr, the contents of this attribute are displayed in stead of the element contents.  -->
<!-- If the type-attribute has the value 'out-of-place', the contents of the dipl-element are suppressed -->

<xsl:template match="tei:dipl | dipl | me:dipl">
    
    <xsl:choose>
        <xsl:when test="contains($visning, 'dipl')">
            <xsl:choose>
                <xsl:when test="attribute::corr">
                    <xsl:value-of select="attribute::corr" disable-output-escaping="yes"/>
                </xsl:when>
                <xsl:when test="attribute::type='out-of-place'"></xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- If the parameter "visning" contains the value "norm" the contents of the norm elements are output; otherwise the norm elements are suppressed.  -->
<!-- If the norm element contains the attribute corr, the contents of this attribute are displayed in stead of the element contents.  -->
<!-- If the type-attribute has the value 'out-of-place', the contents of the norm-element are suppressed -->

	<xsl:template match="tei:norm | norm | me:norm">
    <xsl:choose>
        <xsl:when test="contains($visning, 'norm')">
            <xsl:choose>
                <xsl:when test="attribute::corr">
                    <xsl:value-of select="attribute::corr" disable-output-escaping="yes"/>
                </xsl:when>
                <xsl:when test="attribute::type='out-of-place'"></xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
	</xsl:template>
    
    <!-- This template will suppress all occurrences of the m-element. New 2008-10-22, VO -->
    <xsl:template match="tei:m"/>


<!-- This template specifies the display of highlighted text.-->

<xsl:template match="tei:hi">
    <xsl:choose>
        <xsl:when test="attribute::rend/starts-with(., 'italic')"> <!-- added by BS for Menota 3.0 -->
            <xsl:element name="SPAN">
                <xsl:attribute name="style">font-style: italic;</xsl:attribute> 
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:when>
        <xsl:otherwise>
    <xsl:element name="SPAN">
    <xsl:attribute name="style">color: #FF0000<xsl:if test="attribute::rend='stor_minuskel'">; font-size: 120%</xsl:if></xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


<!-- This template specifies the display of text in the expan element. The actual style (typically italic) is specified in the accompanying CSS style sheet. -->

<!-- HB 2014.03.25 removed  | tei:am from the line below -->
    
    <xsl:template match="tei:expan | tei:ex">
        <xsl:choose>
            <xsl:when test="contains($visning, 'dipl')">
			<xsl:element name="SPAN">
				<xsl:attribute name="class">expan</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element></xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<!-- Totally new (and simplified) template for <add>. In facs, the positions margin, supralinear and infralinear are imitated, everything else is displayed within 
        slanted strokes. BS Feb 2020 -->
    
    <xsl:template match="tei:add|add">
        <xsl:choose>
            <xsl:when test="contains($visning, 'facs')">
                
                <xsl:variable name="supra">
                    <xsl:number count="tei:add[contains(attribute::place, 'supra')][not(ancestor::me:dipl or ancestor::me:norm)]" from="/" level="any"/>
                </xsl:variable>
                <xsl:choose>
                <xsl:when test="attribute::place='supralinear'">
                            <xsl:element name="SUP">
                                <xsl:attribute name="style">line-height: 0.1em;</xsl:attribute>
                                <xsl:apply-templates/>
                            </xsl:element>
                </xsl:when>
                <xsl:when test="attribute::place='infralinear'">
                            <xsl:element name="SUB">
                                <xsl:attribute name="style">line-height: 0.1em;</xsl:attribute>
                                <xsl:apply-templates/> 
                            </xsl:element>
                </xsl:when>
                    <xsl:when test="contains(attribute::place, 'margin-left')"></xsl:when> <!-- new by BS Jan 2021: avoid double display in case of more precise (older) encoding -->
                    <xsl:when test="contains(attribute::place, 'margin-top')"></xsl:when>
                    <xsl:when test="contains(attribute::place, 'margin-bottom')"></xsl:when>
                <xsl:when test="contains(attribute::place, 'margin')"> 
                            <xsl:element name="DIV">
                                <xsl:attribute name="style">display: inline; float: right; clear: none; width: 100px; font-size: 12pt; line-height: 135%</xsl:attribute>
                                <xsl:apply-templates/>
                            </xsl:element>
            </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="attribute::rendition='middle'"></xsl:when>
                            <xsl:when test="attribute::rendition='last'"></xsl:when>
                            <xsl:otherwise><xsl:text>&#x2E0C;</xsl:text></xsl:otherwise>
                        </xsl:choose>
                        <xsl:apply-templates/>
                        <xsl:choose>
                            <xsl:when test="attribute::rendition='middle'"></xsl:when>
                            <xsl:when test="attribute::rendition='first'"></xsl:when>
                            <xsl:otherwise><xsl:text>&#x2E0D;</xsl:text></xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            
            <xsl:otherwise> <!-- for display on dipl and norm -->
                <xsl:choose>
                    <xsl:when test="attribute::place/contains(., 'margin')"> <!-- for additions in margins -->
                        <xsl:choose>
                            <xsl:when test="attribute::rendition='middle'"></xsl:when>
                            <xsl:when test="attribute::rendition='last'"></xsl:when>
                            <xsl:otherwise><xsl:text>&#x2E1D;</xsl:text></xsl:otherwise>
                        </xsl:choose>
                        <xsl:apply-templates/>
                        <xsl:choose>
                            <xsl:when test="attribute::rendition='middle'"></xsl:when>
                            <xsl:when test="attribute::rendition='first'"></xsl:when>
                            <xsl:otherwise><xsl:text>&#x2E1C;</xsl:text></xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                <xsl:otherwise> <!-- for additions elsewhere-->
                <xsl:choose>
                    <xsl:when test="attribute::rendition='middle'"></xsl:when>
                    <xsl:when test="attribute::rendition='last'"></xsl:when>
                    <xsl:otherwise><xsl:text>&#x2E0C;</xsl:text></xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates/>
                <xsl:choose>
                    <xsl:when test="attribute::rendition='middle'"></xsl:when>
                    <xsl:when test="attribute::rendition='first'"></xsl:when>
                    <xsl:otherwise><xsl:text>&#x2E0D;</xsl:text></xsl:otherwise>
                </xsl:choose>
                </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        
        <xsl:if test="following-sibling::*[1][self::tei:w]"><xsl:text>&nbsp;</xsl:text></xsl:if>
    </xsl:template>

    
    <xsl:template match="tei:add" mode="margin"> 
            <xsl:variable name="marginal">
                <xsl:number count="tei:add[contains(attribute::place, 'margin')]" from="/" level="any"/>
            </xsl:variable>
        <xsl:element name="SPAN">
            <xsl:attribute name="style">font-size: 12pt; line-height: 135%</xsl:attribute>
         
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:add" mode="supra">
        <xsl:variable name="supra">
            <xsl:number count="tei:add[contains(attribute::place, 'supra')][not(ancestor::me:dipl or ancestor::me:norm)]" from="/" level="any"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="contains($visning, 'facs')">
                <xsl:choose>
                    <xsl:when test="ancestor::me:dipl or ancestor::me:norm"></xsl:when>
                    <xsl:otherwise>
                        <xsl:element name="DIV">
                            <xsl:attribute name="style">font-size: 10pt; line-height: 75%; display: inline; margin-left: 250px</xsl:attribute>
                         
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
        

    </xsl:template>

<!-- This template specifies the display of text in the del element. If the value of the attribute rend is overstrike the text is shown with a line through. Otherwise deleted text are shown within |- and -|. -->

<xsl:template match="tei:del">
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs')"> <!-- seprate display for overstrike in facs -->
            <xsl:choose>
                <xsl:when test="attribute::rend='overstrike'">
                    <xsl:element name="SPAN">
                        <xsl:attribute name="style">text-decoration: line-through</xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="self::tei:del/attribute::rendition"> <!-- BS: new for Menota 3.0: rendition first/middle/last -->
                            <xsl:choose>
                                <xsl:when test="self::tei:del/attribute::rendition='first'"><xsl:text>&#x2E20;</xsl:text><xsl:apply-templates/></xsl:when>
                                <xsl:when test="self::tei:del/attribute::rendition='last'"><xsl:apply-templates/><xsl:text>&#x2E21;</xsl:text></xsl:when>
                                <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise> 
                            <xsl:text>&#x2E20;</xsl:text><xsl:apply-templates/><xsl:text>&#x2E21;</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        
        <xsl:when test="contains($visning, 'dipl')">
            <xsl:choose>
                <xsl:when test="self::tei:del/attribute::rendition">  <!-- BS: new for Menota 3.0: rendition first/middle/last -->
                    <xsl:choose>
                        <xsl:when test="self::tei:del/attribute::rendition='first'"><xsl:text>&#x2E20;</xsl:text><xsl:apply-templates/></xsl:when>
                        <xsl:when test="self::tei:del/attribute::rendition='last'"><xsl:apply-templates/><xsl:text>&#x2E21;</xsl:text></xsl:when>
                        <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise> 
                    <xsl:text>&#x2E20;</xsl:text><xsl:apply-templates/><xsl:text>&#x2E21;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="contains($visning, 'norm')">
            <xsl:apply-templates/>
        </xsl:when>
        
        <xsl:otherwise>    <!-- default (may be changed) -->
            <xsl:choose>
                <xsl:when test="self::tei:del/attribute::rendition">   <!-- BS: new for Menota 3.0: rendition first/middle/last -->
                    <xsl:choose>
                        <xsl:when test="self::tei:del/attribute::rendition='first'"><xsl:text>&#x2E20;</xsl:text><xsl:apply-templates/></xsl:when>
                        <xsl:when test="self::tei:del/attribute::rendition='last'"><xsl:apply-templates/><xsl:text>&#x2E21;</xsl:text></xsl:when>
                        <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise> 
                    <xsl:text>&#x2E20;</xsl:text><xsl:apply-templates/><xsl:text>&#x2E21;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>
    <!-- new by Jan 2020 by BS: add white space if a word follows -->
    <xsl:if test="following-sibling::*[1][self::tei:w]"><xsl:text>&nbsp;</xsl:text></xsl:if>
</xsl:template>

<!-- This template specifies the display of text in the emph element. The actual style (typically bold) is specified in the accompanying CSS style sheet. The emph element is not used in the Menota handbook v. 1.0. -->

<xsl:template match="tei:emph">
    <xsl:element name="SPAN">
    <xsl:attribute name="class">emph</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<!-- This template specifies the display of text in the seg element. Text in this element does not receive any special formatting. Cf. The Menota handbook v. 1.0 ch. 6.4.6. -->
<!-- templates reworked by Alessandro Gnasso 15 feb 2022, the original used a single template with <xsl:choose> -->
<xsl:template match="tei:seg[@type='ligature']"> <!-- perhaps this template can be removed? -->
    <xsl:apply-templates/>
</xsl:template>
<xsl:template match="tei:seg">
    <xsl:apply-templates/>
</xsl:template>  
<!-- original templates (before 15 feb 2022): 
    <xsl:template match="tei:seg">  
        <xsl:choose>
            <xsl:when test="attribute::type='ligature'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
-->
   


<!-- Display supplied text inline - but surrounded by brackets -->
<!-- Retained from menota 2.0 : If the type-attribute has the value 'head', the contents of the element are displayed as a block heading with slightly more space above than below -->    
   
    <xsl:template match="tei:supplied">
        <xsl:choose>
            <xsl:when test="contains($visning, 'facs')"> 
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="attribute::type='head'">
                        <xsl:element name="DIV">
                            <xsl:attribute name="style">margin-top: 15px; margin-bottom: 10px;</xsl:attribute>
                            <xsl:if test="attribute::type='start' or attribute::type='repetition' or not(attribute::type)"> <xsl:text>&#x005B;</xsl:text></xsl:if>
                          <xsl:apply-templates/>
                            <xsl:if test="attribute::type='end' or attribute::type='repetition' or not(attribute::type)"> <xsl:text>&#x005D;</xsl:text></xsl:if>                        
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise> <!-- New  by BS for Menota 3.0-->
                        <xsl:choose>
                            <xsl:when test="attribute::rendition='middle'"></xsl:when>
                            <xsl:when test="attribute::rendition='last'"></xsl:when>
                            <xsl:when test="attribute::reason/contains(., 'restoration')"><xsl:text>&#x005B;</xsl:text></xsl:when>
                            <xsl:when test="attribute::reason/contains(., 'emendation')"><xsl:text>&#x27E8;</xsl:text></xsl:when>
                            <xsl:otherwise><xsl:text>&#x005B;</xsl:text></xsl:otherwise>
                        </xsl:choose>
                        
                        <xsl:apply-templates/>
                        
                        <xsl:choose>
                            <xsl:when test="attribute::rendition='first'"></xsl:when>
                            <xsl:when test="attribute::rendition='middle'"></xsl:when>
                            <xsl:when test="attribute::reason/contains(., 'restoration')"><xsl:text>&#x005D;</xsl:text></xsl:when>
                            <xsl:when test="attribute::reason/contains(., 'emendation')"><xsl:text>&#x27E9;</xsl:text></xsl:when>
                            <xsl:otherwise><xsl:text>&#x005D;</xsl:text></xsl:otherwise>
                        </xsl:choose>
                     <!--  old   <xsl:if test="attribute::type='end' or attribute::type='repetition' or not(attribute::type)"><xsl:text>&#x27E9;</xsl:text></xsl:if>    -->            
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose> 
    </xsl:template>

<!-- This template specifies that text in the unclear element is displayed in grey (new for Menota 3.0), except in norm - where it is show without any specific style. -->
<xsl:template match="tei:unclear">
    <!-- changed from choose/when -->
        <xsl:if test="preceding-sibling::*[1][self::me:punct]">
            <xsl:text>&nbsp;</xsl:text>        
        </xsl:if>
        <xsl:if test="preceding-sibling::*[1][self::tei:pc]">
            <xsl:text>&nbsp;</xsl:text>        
        </xsl:if>
    
    <xsl:choose>
        <xsl:when test="contains($visning, 'norm')">
            <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:element name="SPAN">
                <xsl:attribute name="style">color: Grey;</xsl:attribute>  <!-- new for Menota 3.0 by BS 2019 -->
            <!-- Old  (Menota v.2) display  <xsl:attribute name="style">border-width: thin; border-bottom-style: dotted; padding: 0px; margin: 0px;</xsl:attribute> -->
                <xsl:apply-templates/>
            </xsl:element>        
        </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
        <xsl:when test="ancestor::tei:w"></xsl:when>
        <xsl:otherwise>
            <xsl:choose>
                <xsl:when test="following-sibling::*[1][self::me:punct]"></xsl:when>
                <xsl:when test="following-sibling::*[1][self::tei:pc]"></xsl:when>
                <xsl:otherwise>
                    <xsl:text>&nbsp;</xsl:text>        
                </xsl:otherwise>                
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>        
</xsl:template>
    
    <!-- This template is used to output an asterisk in front of sic/corr-elements. Adjusted for Menota 3.0 by BS, but display different from corpuscle: *-->
    
    <xsl:template match="tei:corr">
        <xsl:choose>
            <xsl:when test="contains($visning, 'facs')"/>
            <xsl:otherwise>
                <xsl:if test="ancestor::tei:w"><xsl:text>&nbsp;</xsl:text></xsl:if>
                <xsl:text>*</xsl:text>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
       
    </xsl:template>
    
    <xsl:template match="tei:sic">
            <xsl:choose>
                <!-- <xsl:when test="ancestor::tei:w and following-sibling::tei:corr"></xsl:when>-->
                <xsl:when test="contains($visning, 'facs')">
                    <xsl:apply-templates/>
                    <!--<xsl:text>[sic]</xsl:text>-->
                </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- templates for transposition. New for Mentoat 3.0 by BS: show <orig> in facs and <reg> in dipl and norm (rendered in green). -->
    <xsl:template match="tei:orig">
        <xsl:choose>
            <xsl:when test="contains($visning, 'facs')">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:reg">
        <xsl:choose>
            <xsl:when test="contains($visning, 'facs')"/>
            <xsl:otherwise>
                <xsl:element name="SPAN">
                    <xsl:attribute name="style">
                        <xsl:text>display: inline; </xsl:text>
                        <xsl:text>color: green;</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

<!-- Templates for displaying the apparatus -->

<!-- This template refers to the way notes are displayed in the running text. Notes are counted from the top of the document and displayed as superscript numbers that are linked to footnotes. -->

<xsl:template match="tei:note">
    <xsl:param name="notes">
        <xsl:number from="/tei:text" level="any"/>
    </xsl:param>
    <xsl:if test="self::tei:note/attribute::type='explanation'"><BR/></xsl:if> <!-- new by BS for Menota 3.0: put in line breaks (to be seen in facs) before and after footnote for explanation and codicology notes -->
    <xsl:if test="self::tei:note/attribute::type='codicology'"><BR/></xsl:if>
    
    <xsl:choose>
        <xsl:when test="attribute::type='msLocation'"></xsl:when> <!-- Added exception for ADW markup -->
   <xsl:otherwise>
    <xsl:element name="A">
    <xsl:attribute name="name">in<xsl:value-of select="$notes"/></xsl:attribute>
    </xsl:element>
    <xsl:element name="A">
    <xsl:attribute name="href">#off<xsl:value-of select="$notes"/></xsl:attribute>
    <xsl:attribute name="class">note</xsl:attribute>
        <xsl:value-of select="$notes"/>
    </xsl:element>
   </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="self::tei:note/attribute::type='explanation'"><BR/></xsl:if>
    <xsl:if test="self::tei:note/attribute::type='codicology'"><BR/></xsl:if>
</xsl:template>

<!-- This template specifies the formatting of the foot notes. Foot notes are located at the bottom of the page; in HTML this means that there is no distinction between foot notes and end notes. -->

<xsl:template match="tei:note" mode="footer">
<xsl:param name="foot">
    <xsl:number from="/tei:text" level="any"/>
</xsl:param>
    <xsl:choose>
        <xsl:when test="attribute::type='msLocation'"></xsl:when> <!-- Added exception for ADW markup -->
        <xsl:otherwise>
    <xsl:element name="BR"></xsl:element>
    <xsl:element name="A">
    <xsl:attribute name="name">off<xsl:value-of select="$foot"/></xsl:attribute>
    </xsl:element>
    <xsl:element name="A">
    <xsl:attribute name="href">#in<xsl:value-of select="$foot"/></xsl:attribute>
    <xsl:attribute name="class">foot</xsl:attribute>
        <xsl:value-of select="$foot"/>
    </xsl:element>
    <xsl:element name="SPAN">
    <xsl:attribute name="class">footnote</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- This template specifies how quotation marks should be displayed. The actual type of marks are specified with entity references within the xsl:text element. 
        Note that nbsp entites are only used for spacing purposes. -->    
    
    <!-- BS: new by june 2017: Changed to process elements within q; updated to use tei:pc, but the older me:punct is left in stylesheet  --> 
    <!-- BS: new by December 2017:  adjusted to display single quotes when q inside of q-->
    <xsl:template match="tei:q | q">
        <xsl:choose>
            <xsl:when test="contains($visning, 'norm')">
                <xsl:if test="./preceding-sibling::*[1][descendant-or-self::tei:q]">
                    <xsl:text>&nbsp;</xsl:text>
                </xsl:if>
                
                <xsl:choose>
                    <xsl:when test="ancestor::tei:q|ancestor::q"> <!-- output single quotation marks if second level quote -->
                        <xsl:text>'</xsl:text>
                        <xsl:apply-templates/>
                        <xsl:text>'</xsl:text>
                    </xsl:when>
                    <xsl:otherwise> <!-- output double quotation marks if normal quote -->
                        <xsl:text>"</xsl:text>
                        <xsl:apply-templates/>
                        <xsl:text>"</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
               
                    <xsl:choose>
                        <xsl:when test="./following::*[1][self::node()][descendant-or-self::tei:pc]"></xsl:when>
                   <xsl:when test="./following::*[1][self::node()][descendant-or-self::me:punct]"></xsl:when>
                    <xsl:otherwise>
                        <xsl:text>&nbsp;</xsl:text></xsl:otherwise>
                </xsl:choose>
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>    
    
   
<!-- This template makes sure that quotes are displayed in italics in the normalized version of the text -->    
    
<xsl:template match="tei:quote">
    <xsl:choose>
        <xsl:when test="contains($visning, 'norm')">
            <xsl:element name="SPAN">
            <xsl:attribute name="style">font-style: italic;</xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>    
    
    <!-- BS: new for Menota 3.0: Introduced surplus and me:suppressed (but kept me:expunged) -->
    <xsl:template match="me:expunged|me:suppressed|tei:surplus">
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs')"> 
                <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
            
            <xsl:choose>
                <xsl:when test="attribute::rendition">  <!-- BS: new for Menota 3.0: rendition first/middle/last -->
                    <xsl:choose>
                        <xsl:when test="attribute::rendition='first'"><xsl:text>&#x007B;</xsl:text><xsl:apply-templates/></xsl:when>
                        <xsl:when test="attribute::rendition='last'"><xsl:apply-templates/><xsl:text>&#x007D;</xsl:text></xsl:when>
                        <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise> 
                    <xsl:text>&#x007B;</xsl:text>
                    <xsl:apply-templates/>
                    <xsl:text>&#x007D;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
           
        </xsl:otherwise>
    </xsl:choose>
        <!-- new by Jan 2020 by BS: add white space if a word follows -->
        <xsl:if test="following-sibling::*[1][self::tei:w]"><xsl:text>&nbsp;</xsl:text></xsl:if>
</xsl:template>  
    
    <!-- BS: new for Menota 3.0: Handling of space: using empty character (&#8194;) -->
    <xsl:template match="tei:space"> 
        <xsl:choose>
            <xsl:when test="attribute::dim='vertical'">&#8194;&#8194;&#8194;<xsl:element name="SPAN">
                <xsl:attribute name="style">color: Grey; font-size: 90%;</xsl:attribute>
                 [some vertical space]</xsl:element> &#8194;&#8194;&#8194;
                </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
            <xsl:when test="attribute::unit">
                <xsl:choose>
                    <xsl:when test="attribute::unit='line'">
                        <xsl:choose>
                            <xsl:when test="attribute::quantity">
                                    <xsl:choose>
                                        <xsl:when test="attribute::quantity='1'"><BR/></xsl:when>
                                        <xsl:when test="attribute::quantity='2'"><BR/><BR/></xsl:when>
                                        <xsl:when test="attribute::quantity='3'"><BR/><BR/><BR/></xsl:when>
                                        <xsl:when test="attribute::quantity='4'"><BR/><BR/><BR/><BR/></xsl:when>
                                        <xsl:when test="attribute::quantity='5'"><BR/><BR/><BR/><BR/><BR/></xsl:when>
                                        <xsl:when test="attribute::quantity='6'"><BR/><BR/><BR/><BR/><BR/><BR/></xsl:when>
                                        <xsl:when test="attribute::quantity='7'"><BR/><BR/><BR/><BR/><BR/><BR/><BR/></xsl:when>
                                        <xsl:when test="attribute::quantity='8'"><BR/><BR/><BR/><BR/><BR/><BR/><BR/><BR/></xsl:when>
                                        <xsl:when test="attribute::quantity='9'"><BR/><BR/><BR/><BR/><BR/><BR/><BR/><BR/><BR/></xsl:when>
                                        <xsl:when test="attribute::quantity='10'"><BR/><BR/><BR/><BR/><BR/><BR/><BR/><BR/><BR/><BR/></xsl:when>
                                        <xsl:otherwise>
                                            <BR/><BR/>
                                            <xsl:element name="SPAN">
                                                <xsl:attribute name="style">color: Grey; font-size: 90%;</xsl:attribute>
                                                [over ten lines space]
                                            </xsl:element>
                                            <BR/><BR/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <BR/><BR/>  <!-- otherwise display default -->
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="attribute::unit='char'">
                        <xsl:choose>
                            <xsl:when test="attribute::quantity">
                                    <xsl:choose>
                                        <xsl:when test="attribute::quantity='1'">&#8194;</xsl:when>
                                        <xsl:when test="attribute::quantity='2'">&#8194;&#8194;</xsl:when>
                                        <xsl:when test="attribute::quantity='3'">&#8194;&#8194;&#8194;</xsl:when>
                                        <xsl:when test="attribute::quantity='4'">&#8194;&#8194;&#8194;&#8194;</xsl:when>
                                        <xsl:when test="attribute::quantity='5'">&#8194;&#8194;&#8194;&#8194;&#8194;</xsl:when>
                                        <xsl:when test="attribute::quantity='6'">&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;</xsl:when>
                                        <xsl:when test="attribute::quantity='7'">&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;</xsl:when>
                                        <xsl:when test="attribute::quantity='8'">&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;</xsl:when>
                                        <xsl:when test="attribute::quantity='9'">&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;</xsl:when>
                                        <xsl:when test="attribute::quantity='10'">&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;</xsl:when>
                                        <xsl:otherwise>
                                            <xsl:element name="SPAN">
                                                <xsl:attribute name="style">color: Grey; font-size: 90%;</xsl:attribute>
                                            <xsl:text>&#8194;&#8194;&#8194; [big space] &#8194;&#8194;&#8194;</xsl:text> 
                                            </xsl:element>
                                        </xsl:otherwise>
                                    </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                    <xsl:text>&#x25CC;&#x25CC;&#x25CC;&#x25CC;</xsl:text> <!-- otherwise display four empty characters -->
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="attribute::unit='word'">
                        <xsl:choose>
                            <xsl:when test="attribute::quantity='1'">&#x25CC;&#x25CC;<xsl:element name="SPAN">
                                <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[space for one word]</xsl:element>&#x25CC;&#x25CC; </xsl:when>
                            <xsl:when test="attribute::quantity='2'">&#x25CC;&#x25CC;<xsl:element name="SPAN">
                                <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[space for two words]</xsl:element>&#x25CC;&#x25CC; </xsl:when>
                            <xsl:when test="attribute::quantity='3'">&#x25CC;&#x25CC;<xsl:element name="SPAN">
                                <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[space for three words]</xsl:element>&#x25CC;&#x25CC; </xsl:when>
                            <xsl:when test="attribute::quantity='4'">&#x25CC;&#x25CC;<xsl:element name="SPAN">
                                <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[space for four words]</xsl:element>&#x25CC;&#x25CC; </xsl:when>
                            <xsl:when test="attribute::quantity='5'">&#x25CC;&#x25CC;<xsl:element name="SPAN">
                                <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[space for five words]</xsl:element>&#x25CC;&#x25CC; </xsl:when>
                            <xsl:when test="attribute::quantity='6'">&#x25CC;&#x25CC;<xsl:element name="SPAN">
                                <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[space for six words]</xsl:element>&#x25CC;&#x25CC; </xsl:when>
                            <xsl:otherwise>
                                <xsl:element name="SPAN">
                                    <xsl:attribute name="style">color: Grey;</xsl:attribute>
                                    <xsl:text>&#8194;&#8194;&#8194; [big space] &#8194;&#8194;&#8194;</xsl:text> 
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                        
                    <xsl:otherwise> 
                        <xsl:text>&#8194;&#8194;&#8194;&#8194;</xsl:text> 
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#8194;&#8194;&#8194;&#8194;</xsl:text> <!-- if extent not determined by attributes, display four spaces -->
            </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>  
    

    <!-- BS: new for Menota 3.0: Handling of gap -->
    <xsl:template match="tei:gap"> 
      <xsl:choose>
          <xsl:when test="attribute::unit">
              <xsl:choose>
                  <xsl:when test="attribute::unit='line'">
                      <xsl:choose>
                          <xsl:when test="attribute::quantity">
                              <xsl:element name="SPAN">
                                  <xsl:attribute name="style">color: Grey;</xsl:attribute>
                                  <xsl:choose>
                                      <xsl:when test="attribute::quantity='1'">&#x25CC;&#x25CC;&#x25CC; <xsl:element name="SPAN">
                                          <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[one line gap]</xsl:element> &#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                      <xsl:when test="attribute::quantity='2'">&#x25CC;&#x25CC;&#x25CC; <xsl:element name="SPAN">
                                          <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[two lines gap]</xsl:element> &#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                      <xsl:when test="attribute::quantity='3'">&#x25CC;&#x25CC;&#x25CC; <xsl:element name="SPAN">
                                          <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[three lines gap]</xsl:element> &#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                      <xsl:when test="attribute::quantity='4'">&#x25CC;&#x25CC;&#x25CC; <xsl:element name="SPAN">
                                          <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[four lines gap]</xsl:element> &#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                      <xsl:when test="attribute::quantity='5'">&#x25CC;&#x25CC;&#x25CC; <xsl:element name="SPAN">
                                          <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[five lines gap]</xsl:element> &#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                      <xsl:when test="attribute::quantity='6'">&#x25CC;&#x25CC;&#x25CC; <xsl:element name="SPAN">
                                          <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[six lines gap]</xsl:element> &#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                      <xsl:when test="attribute::quantity='7'">&#x25CC;&#x25CC;&#x25CC; <xsl:element name="SPAN">
                                          <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[seven lines gap] </xsl:element>&#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                      <xsl:when test="attribute::quantity='8'">&#x25CC;&#x25CC;&#x25CC; <xsl:element name="SPAN">
                                          <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[eight lines gap]</xsl:element> &#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                      <xsl:when test="attribute::quantity='9'">&#x25CC;&#x25CC;&#x25CC;<xsl:element name="SPAN">
                                          <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[nine lines gap]</xsl:element> &#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                      <xsl:when test="attribute::quantity='10'">&#x25CC;&#x25CC;&#x25CC; <xsl:element name="SPAN">
                                          <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[ten lines gap]</xsl:element> &#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                      <xsl:otherwise>
                                          <xsl:text>&#x25CC;&#x25CC;&#x25CC; </xsl:text> <xsl:element name="SPAN">
                                              <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[several lines gap]</xsl:element><xsl:text> &#x25CC;&#x25CC;&#x25CC;</xsl:text> 
                                      </xsl:otherwise>
                                  </xsl:choose>
                              </xsl:element>
                          </xsl:when>
                          <xsl:otherwise>
                              <xsl:element name="SPAN">
                                  <xsl:attribute name="style">color: Grey;</xsl:attribute>
                                  <xsl:text>&#x25CC;&#x25CC;&#x25CC; [several leaves gap] &#x25CC;&#x25CC;&#x25CC;</xsl:text>  <!-- otherwise display default -->
                              </xsl:element>
                          </xsl:otherwise>
                      </xsl:choose>
                  </xsl:when>
                  <xsl:when test="attribute::unit='char'">
                      <xsl:choose>
                          <xsl:when test="attribute::quantity">
                              <xsl:element name="SPAN">
                                  <xsl:attribute name="style">color: Grey;</xsl:attribute>
                              <xsl:choose>
                              <xsl:when test="attribute::quantity='1'">&#x25CC;</xsl:when>
                              <xsl:when test="attribute::quantity='2'">&#x25CC;&#x25CC;</xsl:when>
                                  <xsl:when test="attribute::quantity='3'">&#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                  <xsl:when test="attribute::quantity='4'">&#x25CC;&#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                  <xsl:when test="attribute::quantity='5'">&#x25CC;&#x25CC;&#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                  <xsl:when test="attribute::quantity='6'">&#x25CC;&#x25CC;&#x25CC;&#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                   <xsl:otherwise>
                                      <xsl:text>&#x25CC;&#x25CC;&#x25CC; ... &#x25CC;&#x25CC;&#x25CC;</xsl:text> 
                                  </xsl:otherwise>
                              </xsl:choose>
                              </xsl:element>
                          </xsl:when>
                          <xsl:otherwise>
                              <xsl:element name="SPAN">
                                  <xsl:attribute name="style">color: Grey;</xsl:attribute>
                              <xsl:text>&#x25CC;&#x25CC;&#x25CC;</xsl:text> <!-- otherwise display default: 3 small dotted circles -->
                              </xsl:element>
                          </xsl:otherwise>
                      </xsl:choose>
                      <xsl:if test="following-sibling::*[1][self::tei:w]"><xsl:text>&nbsp;</xsl:text></xsl:if><!-- add white space if word following -->
                  </xsl:when>
                  <xsl:when test="attribute::unit='word'">
                      <xsl:element name="SPAN">
                          <xsl:attribute name="style">color: Grey;</xsl:attribute>
                      <xsl:text>&#x25CC;&#x25CC;&#x25CC;&#x25CC;&#x25CC;</xsl:text> 
                      </xsl:element>
                  </xsl:when>
                  <xsl:when test="attribute::unit='leaf'">
                      <xsl:choose>
                          <xsl:when test="attribute::quantity">
                              <xsl:element name="SPAN">
                                  <xsl:attribute name="style">color: Grey;</xsl:attribute>
                                  <xsl:choose>
                                      <xsl:when test="attribute::quantity='1'">&#x25CC;&#x25CC;&#x25CC; <xsl:element name="SPAN">
                                          <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[one leaf gap]</xsl:element> &#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                      <xsl:when test="attribute::quantity='2'">&#x25CC;&#x25CC;&#x25CC; <xsl:element name="SPAN">
                                          <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[two leaves gap]</xsl:element> &#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                      <xsl:when test="attribute::quantity='3'">&#x25CC;&#x25CC;&#x25CC; <xsl:element name="SPAN">
                                          <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[three leaves gap]</xsl:element> &#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                      <xsl:when test="attribute::quantity='4'">&#x25CC;&#x25CC;&#x25CC; <xsl:element name="SPAN">
                                          <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[four leaves gap]</xsl:element> &#x25CC;&#x25CC;&#x25CC;</xsl:when>
                                      <xsl:otherwise>
                                          <xsl:text>&#x25CC;&#x25CC;&#x25CC;</xsl:text> <xsl:element name="SPAN">
                                              <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[several leaves gap]</xsl:element> <xsl:text>&#x25CC;&#x25CC;&#x25CC;</xsl:text> 
                                      </xsl:otherwise>
                                  </xsl:choose>
                              </xsl:element>
                          </xsl:when>
                          <xsl:otherwise>
                              <xsl:element name="SPAN">
                                  <xsl:attribute name="style">color: Grey;</xsl:attribute>
                                  <xsl:text>&#x25CC;&#x25CC;&#x25CC; </xsl:text> <xsl:element name="SPAN">
                                              <xsl:attribute name="style">font-size: 90%;</xsl:attribute>[several leaves gap] </xsl:element><xsl:text>&#x25CC;&#x25CC;&#x25CC;</xsl:text>  <!-- otherwise display default -->
                              </xsl:element>
                          </xsl:otherwise>
                      </xsl:choose>
                      
                  </xsl:when>
                  <xsl:otherwise> 
                      <xsl:element name="SPAN">
                          <xsl:attribute name="style">color: Grey;</xsl:attribute>
                      <xsl:text>&#x25CC;&#x25CC;&#x25CC;</xsl:text> <!-- otherwise display default: 3 small dotted circles -->
                      </xsl:element>
                  </xsl:otherwise>
              </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
              <xsl:element name="SPAN">
                  <xsl:attribute name="style">color: Grey;</xsl:attribute>
              <xsl:text>&#x25CC;&#x25CC;&#x25CC;</xsl:text> <!-- if extent not determined by attributes, display default: 3 small dotted circles -->
              </xsl:element>
          </xsl:otherwise>
      </xsl:choose>
    </xsl:template>  
	
	<!-- 2008.06.12 TMB: Handle how textSpan elements shold be displayed.  -->
	<xsl:template match="me:textSpan">
		<xsl:choose>
			<xsl:when test="contains($visning, 'norm') or contains($visning, 'dipl')">
				<xsl:choose>
					<xsl:when test="attribute::category='add'">
						<xsl:text>`</xsl:text>
					</xsl:when>
					<xsl:when test="attribute::category='corr'">
						<xsl:text>*</xsl:text>
					</xsl:when>
					<xsl:when test="attribute::category='del'">
						<xsl:text>|-</xsl:text>
					</xsl:when>
					<xsl:when test="attribute::category='damage'">
						<xsl:text>[</xsl:text>
					</xsl:when>
					<xsl:when test="attribute::category='supplied'">
						<!--<xsl:text>&#x27E8;</xsl:text>-->
					    <xsl:text>&#x005B;</xsl:text> <!-- new by BS Nov 2019 -->
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>    
	
	<!-- 2008.06.12 TMB: Handle how textSpan elements shold be displayed.  -->
    <xsl:template match="tei:anchor">
        <xsl:choose>
            <xsl:when test="contains($visning, 'norm') or contains($visning, 'dipl')">
                <xsl:variable name="ref"><xsl:value-of select="attribute::xml:id"/></xsl:variable>
                <xsl:variable name="categ"><xsl:value-of select="preceding::me:textSpan[1][attribute::spanTo=$ref]/attribute::category"/></xsl:variable>
                <xsl:choose>
                    <!-- Have to look up the corresponding start element to see what kind of anchor element this is. -->
                    <xsl:when test="$categ='add'">
                        <xsl:text>´</xsl:text>
                    </xsl:when>
                    <xsl:when test="$categ='corr'">
                        <xsl:text></xsl:text>
                    </xsl:when>
                    <xsl:when test="$categ='del'">
                        <xsl:text>-|</xsl:text>
                    </xsl:when>
                    <xsl:when test="$categ='damage'">
                        <xsl:text>]</xsl:text>
                    </xsl:when>
                    <xsl:when test="$categ='supplied'">
                        <!--<xsl:text>&gt;</xsl:text>-->
                      <!--  <xsl:text>&#x27E9;</xsl:text> -->
                        <xsl:text>&#x005D;</xsl:text> <!-- new by BS Nov 2019-->
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="preceding-sibling::*[1][self::tei:w] and following-sibling::*[1][self::tei:w]">
            <xsl:text>&nbsp;</xsl:text>
        </xsl:if>
    </xsl:template>  
    
    
    <xsl:template match="tei:c"> <!-- template for initials changed by RKP, samller adjustements by BS --> 
        <!-- please note: Some of the intended implementation is not working yet (e.g. size and indention of surrounding lines). The flexible display of the main color is working. -->
        <xsl:choose>
            <xsl:when test="attribute::type='initial'">  <!-- for new markup according to Menota v.3-->
         
             <xsl:variable name="up">
                    <xsl:choose>
                        <xsl:when test="matches(@style, '(?:^|\s*)mu(\d+)')"> <!-- temporary fix for cases that start with "mu"  BS Nov 2019-->
                            <xsl:value-of select="0"/>
                        </xsl:when>
                        <xsl:when test="matches(@style, '(?:^|\s*)u(\d+)')">
                            <xsl:value-of select="replace(@style, '^(?:.+?\s+)?u(\d+).*?$', '$1')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="0"/>
                        </xsl:otherwise>
                    </xsl:choose>                    
                </xsl:variable>
                <xsl:variable name="down">
                    <xsl:choose>
                        <xsl:when test="matches(@style, '(?:^|\s*)md(\d+)')"> <!-- temporary fix for cases that start with "md"  BS Nov 2019-->
                            <xsl:value-of select="0"/>
                        </xsl:when>
                        <xsl:when test="matches(@style, '(?:^|\s*)d(\d+)')">
                            <xsl:value-of select="replace(@style, '^(?:.+?\s+)?d(\d+).*?$', '$1')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="0"/>
                        </xsl:otherwise>
                    </xsl:choose>                    
                </xsl:variable>
                <xsl:variable name="color">
                    <xsl:choose>
                        <xsl:when test="matches(@style, '(?:^|\s*)c(\w+|#[\dA-F]{6})')">
                            <xsl:value-of select="replace(@style, '^(?:.+?\s+)?c(\w+|#[\dA-F]{6}).*?$', '$1')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'Red'"/>
                        </xsl:otherwise>
                    </xsl:choose>                    
                </xsl:variable>
             
                <xsl:choose>
                    <xsl:when test="contains($visning, 'facs')">
                        <xsl:element name="SPAN">
                            <xsl:attribute name="style">
                                <xsl:value-of select="concat('color: ', $color, '; ')"/>
                                <xsl:text>font-weight: bold; </xsl:text>
                                <!-- RKP:
                                    OBS! The 'initial-letter' CSS property has not yet been implemented 
                                    (as of 10 Feb 2017),
                                    but Mozilla seems to be working on it:
                                    
                                    https://developer.mozilla.org/en-US/docs/Web/CSS/initial-letter
                                    
                                    (The styling used here follows the syntax suggested on this page.)
                                                                             
                                    ISSUE:
                                    In its present state 'initial-letter', when being
                                    used as "raised cap", does not allow for preceding lines
                                    to wrap around it (i.e. it is not possible for initials 
                                    to "sink in" upwards). Too bad!
                                    
                                    Cf.:
                                    https://drafts.csswg.org/css-inline/#sizing-drop-initials
                                -->
                                <xsl:text>initial-letter: </xsl:text>
                                <xsl:value-of select="$up + $down"/>
                                <xsl:if test="$down > 0">
                                    <xsl:value-of select="concat(' ', $down)"/>
                                </xsl:if>
                                <xsl:text>;</xsl:text>
                                
                                <!-- changed 25/4 2018 from (still not working though): -->
                                    
                             <!--    <xsl:text>initial-letter: </xsl:text>
                                <xsl:value-of select="$up + $down + 1"/>
                                <xsl:if test="$down > 0">
                                    <xsl:value-of select="concat(' ', $down + 1)"/>
                                </xsl:if>
                                <xsl:text>;</xsl:text>
                                -->
                                
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:when>
          
                    <xsl:otherwise>
                        <xsl:element name="B">
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:otherwise>
                    
                </xsl:choose>
            </xsl:when>
    
            
            <!-- for hyphenation encoding using c. BS: Note: not to be used anymore for supplied hyphens in Menota 3.0 -->
            <xsl:when test="@type='hyphen'"> 
                <xsl:choose>
                    <xsl:when test="contains($visning, 'norm') and following-sibling::tei:lb"></xsl:when> <!-- new: do not display on norm if immediately followed by lb -->
                    <xsl:when test="contains($visning, 'dipl') and following-sibling::tei:lb"></xsl:when> <!-- new: do not display on dipl if immediately followed by lb -->
                    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
                </xsl:choose>
                
            </xsl:when>
            
            
            <xsl:otherwise>
                <xsl:element name="SPAN">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="size">
        <xsl:param name="rend"/>
        <xsl:value-of select="substring-before($rend, '_')"/>
    </xsl:template>
    
    <xsl:template name="color">
        <xsl:param name="rend"/>
        <xsl:value-of select="substring-after($rend, '_')"/>
    </xsl:template>
    
    <xsl:template name="colorlist">
        <xsl:param name="color"/>
        <xsl:choose>
            <xsl:when test="$color='black'"> #000000;</xsl:when>
            <xsl:when test="$color='blue'"> #0000FF;</xsl:when>
            <xsl:when test="$color='green'"> #008000;</xsl:when>
            <xsl:when test="$color='red'"> #FF0000;</xsl:when>
            <xsl:otherwise> #000000;</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
