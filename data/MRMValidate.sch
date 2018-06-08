<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2">
    <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>   
 
    <pattern>
        <rule context="tei:TEI//@ref | tei:TEI//@who | tei:TEI//@corresp | tei:TEI//@wit">
            <assert test="starts-with(., '#')">
                Attributes @ref, @who, @corresp and @wit must begin with a hashtag.
            </assert>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="tei:TEI//@wit">
        <let name="tokens" value="for $w in tokenize(., '\s+') return substring-after($w, '#')"/>
            <assert test="every $token in $tokens satisfies $token = //tei:TEI//tei:listWit//@xml:id">
                Every reading witness (@wit) after the hashtag must match an xml:id defined in the list of witnesses in this file!
          </assert>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="tei:TEI//@xml:id">
            <report test="matches(., '\s+')">
                @xml:id values may NOT contain white spaces!
            </report>        
        </rule>
    </pattern>
    
   <pattern>
       <rule context="tei:TEI//tei:rs">
           <assert test="@type[matches(., 'person')] | @type[matches(., 'org')] | @type[matches(., 'place')] | @type[matches(., 'event')] |  @type[matches(., 'letter')] | @type[matches(., 'title')] | @type[matches(., 'plant')] | @type[matches(., 'animal')]">
               The value of the @type on rs must be one of the following: person, org, place, event, letter, title, plant, animal. 
           </assert>
       </rule>
   </pattern>
   
        <let name="si" value="doc('http://mitford.pitt.edu/si.xml')//@xml:id"/>
        <let name="siFile" value="doc('http://mitford.pitt.edu/si.xml')"/>
    
    
        <pattern>
           <rule
                context="@ref | @corresp | @who">
               <let name="tokens" value="for $i in tokenize(., '\s+') return substring-after($i,'#')"/>
               <assert test="every $token in $tokens satisfies $token = $si">The attribute (after the hashtag, #) must match a defined @xml:id in the Site Index file!</assert>
                
            </rule>
        
           <!-- ebb: I discover that the rule below is not necessary. The tokenizing doesn't disrupt multiple values, so long as the token variable is set within each distinct rule (that is, as long as it's not set as a global variable). 
               <rule context="tei:TEI//@ref[not(matches(., '\s+'))] | tei:TEI//@corresp[not(matches(., '\s+'))] | tei:TEI//@who[not(matches(., '\s+'))]">            
               
                <assert test="substring-after(., '#') = $si">
                    The attribute (after the hashtag, #) must match a defined @xml:id in the site index file. 
                </assert>
        </rule>-->
    </pattern>
     
        <pattern>   
            <rule context="tei:TEI//tei:persName/@ref | tei:TEI//tei:rs[@type='person']/@ref | tei:TEI//@who">
                <let name="tokens" value="for $i in tokenize(., '\s+') return substring-after($i,'#')"/>
                <assert test="every $token in $tokens satisfies $token = $siFile//tei:text//tei:listPerson//@xml:id | $siFile//tei:text//tei:listOrg//@xml:id">
                    <!--<assert test="substring-after(., '#') = $siFile//tei:text//tei:listPerson//@xml:id | $siFile//tei:text//tei:listOrg//@xml:id">-->
                    The @ref or @who on People / Characters must match an appropriate xml:id on our site index's lists of persons, fictional characters or mythical entities.
                </assert>
            </rule> 
              
           <!--ebb: Again, I find this rule to isolate the singular attributes isn't really necessary. 
               <rule context="tei:TEI//tei:persName/@ref[not(matches(., '\s+'))] | tei:TEI//tei:rs[@type='person']/@ref[not(matches(., '\s+'))] | tei:TEI//@who[not(matches(., '\s+'))]">
                <assert test="substring-after(., '#') = $siFile//tei:text//tei:listPerson//@xml:id | $siFile//tei:text//tei:listOrg//@xml:id">
                    The @ref or @who on People / Characters must match an appropriate xml:id on our site index's lists of persons, fictional characters or mythical entities.
                </assert>   
                
            </rule>-->
        
            <rule context="tei:TEI//tei:orgName/@ref | tei:TEI//tei:rs[@type='org']/@ref">
                <let name="tokens" value="for $i in tokenize(., '\s+') return substring-after($i,'#')"/>
                <assert test="every $token in $tokens satisfies $token = $siFile//tei:text//tei:listOrg//@xml:id">
               <!-- <assert test="substring-after(., '#') = $siFile//tei:text//tei:listOrg//@xml:id">-->
                    The @ref on Organizations (orgName and rs[@type="org"] must match an appropriate xml:id on our site index's lists of persons, fictional characters or mythical entities.
                </assert>
            </rule>
            
            <rule context="tei:TEI//tei:placeName/@ref | tei:TEI//tei:rs[@type='place']/@ref">
                <let name="tokens" value="for $i in tokenize(., '\s+') return substring-after($i,'#')"/>
                <assert test="every $token in $tokens satisfies $token = $siFile//tei:text//tei:listPlace//@xml:id">
                    The @ref on Places (placeName and rs[@type="place"] must match an appropriate xml:id on our site index's lists of places.
                </assert> 
            </rule>
            
            <rule context="tei:TEI//tei:title/@ref | tei:TEI//tei:rs[@type='title']/@ref | tei:TEI//tei:bibl/@corresp">
                <let name="tokens" value="for $i in tokenize(., '\s+') return substring-after($i,'#')"/>
                <assert test="every $token in $tokens satisfies $token = $siFile//tei:text//tei:listBibl//@xml:id | $siFile//tei:text//tei:list[@type='art']//@xml:id">
                    The @ref on Titles (or the @corresp on bibl) must match an appropriate xml:id on our site index's lists of books or works of art.
                </assert> 
            </rule>
            
            <rule context="tei:TEI//name/@ref | tei:TEI//name[@type='event']/@ref | tei:TEI//tei:rs[@type='event']/@ref">
                <let name="tokens" value="for $i in tokenize(., '\s+') return substring-after($i,'#')"/>
                <assert test="every $token in $tokens satisfies $token = $siFile//tei:text//tei:listEvent//@xml:id">
                    The @ref on Events (name[@type="event"] and rs[@type="event"] must match an appropriate xml:id on our site index's lists of events.
                </assert> 
            </rule>
            
            
    </pattern>
    
    
</schema>