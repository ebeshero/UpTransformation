<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <!-- TODO: Repeated rule for break duration should be consolidated-->
    <sch:pattern>
        <sch:rule context="slot[1]/@time">
            <sch:p>First (morning) slot should start at 10:30 a.m. on Monday and 9:00 on other
                days</sch:p>
            <sch:assert test="
                    if (ancestor::day/@d eq 'Monday, June 10') then
                        . eq '10:30:00'
                    else
                        . eq '09:00:00'">Monday starts at 10:30 a.m., other days at
                9:00</sch:assert>
        </sch:rule>
        <sch:rule context="slot[2]/@time">
            <sch:p>Second (afternoon) slot should start at 1:00, except that there is no second slot
                on Friday</sch:p>
            <sch:assert test="
                    if (ancestor::day/@d ne 'Friday, June 14') then
                        . eq '13:00:00'
                    else
                        0">Afternoon sessions Monday through Thursday start at 1:00
                p.m.</sch:assert>
            <sch:assert test="ancestor::day/@d ne 'Friday, June 9'">There is no afternoon session on
                Friday</sch:assert>
        </sch:rule>
        <sch:rule context="slot[1]">
            <sch:p>Duration of first (morning) slot is 1:30 hours Monday, 1:15 hours on Friday, and
                3:00 on other days</sch:p>
            <sch:let name="duration" value="sum(act/@time/xs:dayTimeDuration(.))"/>
            <sch:assert test="
                    if (../@d eq 'Monday, June 10') then
                        $duration eq xs:dayTimeDuration('PT1H30M')
                    else
                        if (../@d eq 'Friday, June 14') then
                            $duration eq xs:dayTimeDuration('PT1H15M')
                        else
                            $duration eq xs:dayTimeDuration('PT3H')">Duration of
                    <sch:value-of select="$duration"/> is incorrect; Monday should be PT1H30M and
                other days should be PT3H</sch:assert>
        </sch:rule>
        <sch:rule context="slot[2][../@d eq 'Monday, June 10']">
            <sch:p>Duration of second (afternoon) slot on Monday is 1:15.</sch:p>
            <sch:let name="duration" value="sum(act/@time/xs:dayTimeDuration(.))"/>
            <sch:assert test="$duration eq xs:dayTimeDuration('PT1H15M')">Duration of <sch:value-of
                    select="$duration"/> is incorrect; duration of Monday afternoon session should
                be PT1H15M</sch:assert>
        </sch:rule>
        <sch:rule context="slot[2][../@d ne 'Monday, June 10']">
            <sch:p>Duration of second (afternoon) slot is 2:45.</sch:p>
            <sch:let name="duration" value="sum(act/@time/xs:dayTimeDuration(.))"/>
            <sch:assert test="$duration eq xs:dayTimeDuration('PT2H45M')">Duration of <sch:value-of
                    select="$duration"/> is incorrect; duration should be PT2H45M</sch:assert>
        </sch:rule>
        <sch:rule context="title">
            <sch:p>title element must have non-whitespace content</sch:p>
            <sch:assert test="string-length(normalize-space(.)) gt 0">&lt;title&gt; element must
                have content</sch:assert>
        </sch:rule>
        <sch:rule context="slot[1]/act[desc eq 'Break']">
            <sch:let name="duration_before_break"
                value="sum(preceding-sibling::act/@time ! xs:dayTimeDuration(.))"/>
            <sch:assert test="$duration_before_break eq xs:dayTimeDuration('PT1H15M')">Morning break
                falls after <sch:value-of select="$duration_before_break"/>; must fall after
                PT1H15M</sch:assert>
            <sch:assert test="@time eq 'PT15M'">Morning break duration of <sch:value-of
                    select="@time"/> is incorrect; break duration must be PT15M</sch:assert>
        </sch:rule>
        <sch:rule context="slot[2]/act[desc eq 'Break']">
            <sch:let name="duration_before_break"
                value="sum(preceding-sibling::act/@time ! xs:dayTimeDuration(.))"/>
            <sch:assert test="$duration_before_break eq xs:dayTimeDuration('PT1H30M')">Afternoon
                break falls after <sch:value-of select="$duration_before_break"/>; must fall after
                PT1H30M</sch:assert>
            <sch:assert test="@time eq 'PT15M'">Afternoon break duration of <sch:value-of
                    select="@time"/> is incorrect; break duration must be PT15M</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
