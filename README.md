# rats
[![Build Status](https://travis-ci.org/attack/rats.png)](https://travis-ci.org/attack/rats)

a.k.a. Ruby Alberta Township System

A ruby class to help with using the Alberta Township System.  This class will allow
you to create and represent townships, sections and quarter sections.

#### Status

This gem is not under active development, but is still maintained.

## ATS

Alberta Township system is a land survey grid used in Alberta, Canada that
divides the whole province into addressable locations.

A typical location looks like: NE 1-2-3 W4

Which can be broken down as follows ...

### Meridian

from above example: [= W4] or West of the 4th Meridian

The Meridian is a constant line running perpendicular to the line of longitude,
and increments approx. every 4th line of longitude, from East to West.

Alberta contains 3 of these Meridians, W4 through W6.

### Range
a.k.a Range Lines

from above example: [= 3]

The Range is the x-axis within the given Meridian.  It increases East to West and
resets at the next Meridian.  Each increase is approx. every 6 miles.

NOTE: The longitude lines are closer together the further North you get, so as
you go North, there is less Ranges from East to West.

### Township
a.k.a. Township Lines

from above example: [= 2]

The Township is the y-axis within the Meridian.  It increases South to North and
never resets, running from the Alberta-US border to the Northern border of Alberta.
Each increase is approx. every 6 miles.

NOTE: The 6x6 mile "square" indicated by the Township (line) + Range (line) +
Meridian is confusingly called a Township.  So you have the Township line and
the 6x6 mile Township "square".

### Section

from above example: [= 1]

The Section represents a 1x1 mile "square" within the 6x6 mile Township.
There can be up to a maximum of 36 Sections in a township.  The number starts with
1 in the South-East corner and travels West to number 6.  It then increases to 7
North of number 6 and counts up West-to-East until the number 12.  It snakes back
and forth until it finishes at number 36 in the North-East corner.

### Multi
a.k.a. Multi Quarters

from above example: [= N or = North]

The Half Section represents a 1/2 x 1 mile area within the 1x1 mile Section.
They are identified by "N", "E", "S" and "W".

from above example: [= NSE]

The Multi Quarter Section represents a 1/2 x 1 mile + 1/2 x 1/2 mile area within the
1x1 mile Section (or basically 3 of the 4 quarters).
They are identified by "NSE", "NSW", "ENW", "ESW", "SNE", "SNW", "WNE" and "WSE",
"NWS", "NES", "SEN", "SWN", "NWE", "NEW", "SEW", "SWE".

### Quarter
a.k.a. Quarter Section

from above example: [= NE]

The Quarter represents a 1/2 x 1/2 mile square within the 1x1 mile Section.
There can be 4 Quarters in a Section.  They are identified by "NE", "NW", "SE"
and "SW".

## Purpose

The purpose of Rats is to make it easier to deal with location described using
the Alberta Township System, at the Quarter, Section or Township level.

### Validation

Included is validations, only allowing you to describe locations that actually
exist.

For example, Range-line 30 is valid for Township-lines 1-18, but not 18-126.

NOTE: At the moment, invalid quarters within valid sections are not currently
identified.

### Parsing

Included is string parsing, allowing you to extract and separate the different
fields from multiple string representations of the location.

For example, NE 1-2-3 W4 and 40300201NE are both recognized and parsed, representing
the same location.

### Expansion/Division

Townships, Sections and Half Sections can be divided into multiple Quarter Sections.
1 Half Section = 2 Quarter Sections
1 Multi Quarter Section = 2-3 Quarter Sections
1 Section = 4 Quarter Sections
1 Township = 144 Quarter Sections

For example, the Half Section N 1-2-3 W4 has the Quarter Sections NE 1-2-3 W4 and
NW 1-2-3 W4.

### Display

Included is string creation that can create common representations of the
location.

# Usage

Parse a location

```ruby
quarter_section = Rats.new("NE 1-2-3 W4")
```

Print the location

```ruby
quarter_section.location
quarter_section.location(:padded)
quarter_section.location(:short)
quarter_section.location(:long)
```

Read the attributes

```ruby
quarter_section.quarter
quarter_section.section
quarter_section.township
quarter_section.range
quarter_section.meridian
```

Divide into multiple Quarter Sections

```ruby
half_section = Rats.new("N 1-2-3 W4")
half_section.is_divisible?
quarter_sections = half_section.divide
# quarter_sections == [Rats.new("NE 1-2-3 W4"), Rats.new("NW 1-2-3 W4")]

multi_section = Rats.new("NSE 1-2-3 W4")
multi_section.is_divisible?
quarter_sections = multi_section.divide
# quarter_sections == [Rats.new("NE 1-2-3 W4"), Rats.new("NW 1-2-3 W4"), Rats.new("SE 1-2-3 W4")]
```

# Information

## links

http://en.wikipedia.org/wiki/Alberta_Township_System

## Road Map

Future:
* either correct the assumption that all quarters are valid in a valid
  section, or remove validation completely (re: all or none)
* add support for Saskatchewan (no timeline, need to find data)

## Assumptions

As currently written, I assume that within every valid section, all four quarters
are valid. I know this to be incorrect, but I can not correct this until I know which
cases this assumption breaks down.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2009-2014 Mark Gangl. See LICENSE for details.
