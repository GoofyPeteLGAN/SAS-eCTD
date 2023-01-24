%macro eCTD_Heading(HeadingText1,HeadingText2,hfs=,Tabs=1,Indent=auto,TrailingLine=1,Header=,HeaderWeight=bold);

  * Parameters:                                                                    *;
  *   HeadingText1 - the heading section (usually like 2.1)                        *;
  *   HeadingText2 - the heading text                                              *;
  *   HFS          - the heading font size, in points - if not specified, it will  *;
  *                  be based on the number of periods in HeadingText1             *;
  *   Tabs         - the number of tabs between HeadingText1 and HeadingText2      *;
  *   Indent       - the number of spaces to indent the heading from the left edge *;
  *                  of the page.  Default is auto, which will base the value on   *;
  *                  the number of periods in HeadingText1.                        *;
  *   TrailingLine - the number of lines to put after the heading text - default=1 *;

  %local NumPeriods TabString IndentString _i;

  *=== Change: 10/24/2022 - PJL ===================================================*;
  * Added indent option - if set to auto will add as many tabs to the beginning of *;
  * the text as there are periods in it.  An exposed trailing period (e.g., 1.) is *;
  * not included in the count (will be 0).                                         *;
  * If not auto, the number of Indents specified will be use.                      *;
  *== NEEDS TO BE CHANGED: 10/24/2022 - PJL =======================================*;
  * Might need to change tabs to spaces, if a tab is too much.                     *;

  * Get the number of periods in the section header.  If the last character is a   *;
  * period (e.g., 1.), do not count that.                                          *;

  %let NumPeriods = %sysfunc(count(%substr(&HeadingText1,1,%length(&HeadingText1)-1),%str(.)));

  * Set the font size based on the number of periods.  The more there are, the     *;
  * smaller the font size.  For example, 1. would have a size of 16pt and 2.6.1    *;
  * would have a size of 12pt.                                                     *;

  %if &hfs eq %str() %then
    %do;
      %if &NumPeriods eq 0 %then %let hfs = 16;
      %else %if &NumPeriods eq 1 %then %let hfs = 13;
      %else %if &NumPeriods eq 2 %then %let hfs = 12;
    %end;

  * Also base the indentation of the header and the header type (h1, h2, h3) on    *;
  * the number of periods.                                                         *;

  %if &NumPeriods eq 0 %then %do; %let numIndent = 0;  %let HeaderLevel = h1; %end;
  %else %if &NumPeriods eq 1 %then %do; %let numIndent = 3; %let HeaderLevel = h2; %end;
  %else %if &NumPeriods eq 2 %then %do; %let numIndent = 5; %let HeaderLevel = h3; %end;
  %if %lowcase(&Indent) ne auto %then %let numIndent = &Indent;

  * Create a string of blank spaces (AOx), set to the number of spaces to indent.  *;

  %if &numIndent eq 0 %then %let IndentString = %str();
  %else 
    %do _i = 1 %to &numIndent;
      %let IndentString = "A0"x,&IndentString;
    %end;

  * Create a string to put between HeadingText1 and HeadingText2.  It will either  *;
  * be a single blank space (A0x) or a series of tabs (09x) - based on the Tabs    *;
  * parameter.                                                                     *;

  %if &Tabs eq 0 %then %let TabString = %str(,"A0"x);
  %else 
    %do _i = 1 %to &Tabs;
      %let TabString = &TabString%str(,)'09'x;
    %end;

  proc odstext;
    %put &HeaderLevel catt(&IndentString"&HeadingText1"&TabString,"&HeadingText2") / style=[fontweight=bold fontsize=&hfs.pt color=cx000000];
    &HeaderLevel catt(&IndentString"&HeadingText1"&TabString,"&HeadingText2") / style=[fontweight=bold fontsize=&hfs.pt color=cx000000];
  run;

  * Put a blank line(s) after the header.  NOTE: newline works like the REPEAT     *;
  * function.  There will alway be a line and the number following will add that   *;
  * many more lines.  So, subtract one from the TrailingLine value.                *;

  %if &TrailingLine gt 0 %then 
    %do;
      ods text="~{newline %eval(&TrailingLine-1)}";
    %end;

%mend;
