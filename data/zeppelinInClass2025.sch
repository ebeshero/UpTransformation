<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
   <sch:pattern>
       <!-- I think I want to check for possibly unfinished chordLine elements. -->
      <sch:rule context="chordLine" role="warn"> 
          <sch:report test="count(chord) lt 3">
           There are less than three chord elements here. Is this correct? 
           At this point we see only <sch:value-of select="count(chord)"/>.
       </sch:report>
      </sch:rule>
       
       <sch:rule context="chord[@num='4/6']" role="info">
           <sch:assert test="text() ! normalize-space() = 'A/C#'"/>
       </sch:rule>
       
       
   </sch:pattern>
    
    
</sch:schema>