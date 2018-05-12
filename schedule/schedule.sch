<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="slot[1]/@time">
            <sch:p>First slot should start at 10 a.m. on Monday and 9:30 on other days</sch:p>
            <sch:assert
                test="
                    if (ancestor::day/@d eq 'Monday, June 11') then
                        . eq '10:00:00'
                    else
                        . eq '09:30:00'"
                >Monday starts at 10:00 a.m., other days at 9:30</sch:assert>
        </sch:rule>
        <sch:rule context="slot[2]/@time">
            <sch:p>Second slot should start at 1:15, except that there is no second slot on
                Friday</sch:p>
            <sch:assert
                test="
                    if (ancestor::day/@d ne 'Friday, June 15') then
                        . eq '13:15:00'
                    else
                        1"
                >Afternoon sessions Monday through Thursday start at 1:15 p.m.</sch:assert>
            <sch:assert test="ancestor::day/@d ne 'Friday, June 15'">There is no afternoon session
                on Friday</sch:assert>
        </sch:rule>
        <sch:rule context="slot[1]">
            <sch:p>Duration of first slot is 2 hours Monday and 2:30 on other days</sch:p>
            <sch:assert
                test="
                    if (../@d eq 'Monday, June 11') then
                        sum(act/@time/xs:dayTimeDuration(.)) eq xs:dayTimeDuration('PT2H')
                    else
                        sum(act/@time/xs:dayTimeDuration(.)) eq xs:dayTimeDuration('PT2H30M')"
                >Duration of <sch:value-of select="sum(act/@time/xs:dayTimeDuration(.))"/> is
                incorrect; Monday should be PT2H and other days should be PT2H30M</sch:assert>
        </sch:rule>
        <sch:rule context="slot[2]">
            <sch:p>Duration of second slot is 2:35</sch:p>
            <sch:assert
                test="
                    sum(act/@time/xs:dayTimeDuration(.)) eq xs:dayTimeDuration('PT2H35M')"
                >Duration of <sch:value-of select="sum(act/@time/xs:dayTimeDuration(.))"/> is
                incorrect; duration of all afternoon sessions should be PT2H35M</sch:assert>
        </sch:rule>
        <sch:rule context="title">
            <sch:p>title element must have non-whitespace content</sch:p>
            <sch:assert test="string-length(normalize-space(.)) gt 0">title must have
                content</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern> </sch:pattern>
</sch:schema>
