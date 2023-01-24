%macro BulletedList(BulletType=circle,ListText=,NestAfter=,NestThru=,Header=,HeaderWeight=medium);

  * Parameters:                                                                    *;
  *   - BulletType types include circle (default), disc, decimal                   *;
  *   - ListText   a caret (^) delimited string of the items to be displayed in    *;
  *                the list                                                        *;
  *   - NestAfter  the item number after which rows should be nested               *;
  *   - NestThru   the last item that should be nested                             *;
  *   - Header     text that should precede the list                               *;
  *   - HeaderWeight  weight of the header text (medium or bold)                   *;

  * Find the number of carets in the text - add 1 and will resolve to the number   *;
  * of items in the list                                                           *;

  

  %let n = %eval(%sysfunc(count(&ListText,%str(^)))+1);

  %if &Header ne %str() %then
    %do;
      ods text="~{style BodyStyle[fontweight=&HeaderWeight] &Header}";
    %end;

  proc odslist;
    style={liststyletype=&BulletType};

  * Loop through all the list items and create ITEM and/or P statements.           *;

    %do i = 1 %to &n;
      %let LineText = %left(%qscan(&ListText,&i,^));

  * If this is the line where nesting starts, start a new paragraph which contains *;
  * the new nested list.  Otherwise, just display the item.                        *;

      %if &i eq &NestAfter %then %str(item; p "&LineText"; list;);
      %else %str(item "&LineText";);

  * If this is the end of the nested items, end the list and the paragraph.        *;

      %if &i eq &NestThru %then %str(end; end;);
    %end;
  run;
%mend;
