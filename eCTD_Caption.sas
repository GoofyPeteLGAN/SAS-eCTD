%macro eCTD_Caption(CaptionText,CaptionType=Table,LeadingLines=1,TrailingLines=1);
  %local _i;

  %if &LeadingLines gt 0 %then
    %do;
      ods text="~{newline %eval(&LeadingLines-1)}";
    %end; 

  proc odstext;
      p "~{run &CaptionType {SEQ &CaptionType \* ARABIC}: &CaptionText}"/style={fontweight=bold just=l};
  run;

  %if &TrailingLines gt 0 %then
    %do;
      ods text="~{newline %eval(&TrailingLines-1)}";
    %end;
%mend;
