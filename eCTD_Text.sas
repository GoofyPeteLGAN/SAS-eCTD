%macro eCTD_Text(Text,Style=BodyStyle,LNL=0,TNL=1,Header=xxx);

  * Puts text on the page                                                          *;

  * Parameters:                                                                    *;
  *   - Text     the text to put on the page                                       *;
  *   - Style    the style element in the current ODS style used to format the     *;
  *              text                                                              *;
  *   - LNL      leading new lines - blank lines put in before the text            *;
  *   - TNL      trailing new lines - blank lines to put in after the text         *;
  *   - Header   text to put as a header on a line above the text - the default    *;
  *              value of xxx is ignored.                                          *;

  *=== Change: 10/24/2022 - PJL ===================================================*;
  * Changed the default style to BodyStyle, so that it is easy to make study-      *;
  * specific.                                                                      *;

  *=== Change: 10/24/2022 - PJL ===================================================*;
  * Optional header - for now, use a style that inherits from BodyStyle and makes  *;
  * the text bold.  The header will be placed on a separate line and any lines     *;
  * between the header and the text (based on LNL) are taken away.                 *;
  *== NEEDS TO BE CHANGED: 10/24/2022 - PJL =======================================*;
  * Might need an option to add some space                                         *;

  * Setup {newline n} calls based on LNL and TNL values                            *;

  %if &LNL ne 0 %then %let LNL = ~{newline &lnl};
  %else %let LNL = %str();
  %if &TNL ne 0 %then %let TNL = ~{newline &tnl};
  %else %let TNL = %str();

  * If there is a header (not blank or xxx), put it here                           *;

  %if %quote(&Header) ne %str(xxx) and %quote(&Header) ne %str() %then
    %do;

  * If there is a header, the leading new line(s) need to go above the header...   *;

      %if %quote(&lnl) ne %str() %then %do; ods text="&LNL"; %end;
      proc odstext;
        p "&Header" / style=TextHeaderStyle;
      run;

  * ...and then LNL needs to be turned off, as it has already been done            *;

      %let LNL = %str();
    %end;

  * Display the text, with the leading and trailing new lines added                *;

  proc odstext;
    p "&LNL%superq(Text)&TNL" / style=&Style;
  run;
%mend;

