% Filename: Sctm_combined.mp
% MetaPost script to draw selected glyphs with highlights and labels

prologues := 3;
outputtemplate := "%j-%c.pdf";
verbatimtex
%&latex
\documentclass{article}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{xcolor}
\begin{document}
etex;

% Global variables
numeric fig_ctr;
fig_ctr := 1;
boolean do_labels;
do_labels := true;   % Set to false to hide labels

% Define offset for red highlight boxes
numeric offset;
offset := 0.5;

%% --- Apostrophe (') ---
beginfig(fig_ctr);

  draw frame with_pen pencircle scaled 0.5cm;

  glyph Apostrophe;
  Apostrophe := get_glyph 39 from "cmssbx10";

  clear qv;
  qv := get_paths from Apostrophe;
  scale qv (10,10);

  Q33 := qv0;
  Q34 := qv1;

  p380 := origin;
  p389 := p380 shifted (6,0);
  p390 := (xpart get_point 4 Q33, ypart get_point 0 Q34);

  shift Q33 by (p389 - p390);
  shift Q34 by (p389 - p390);

  p390 := get_point 1 Q34;
  p391 := get_point 2 Q34;
  p392 := (xpart p389, ypart p391);
  Q34 := p389 -- p390 -- p391 -- p392 -- cycle;

  draw Q34 with_color gray;
  draw Q33;

  if do_labels:
    dotlabel.bot("$p_{389}$", p389);
    dotlabel.bot("$p_{390}$", p390);
    dotlabel.top("$p_{391}$", p391);
    dotlabel.top("$p_{392}$", p392);
  fi;

endfig;
fig_ctr := fig_ctr + 1;

%% --- Hash (#) ---
beginfig(fig_ctr);

  draw frame with_pen pencircle scaled 0.5cm;

  glyph Hash_mark;
  Hash_mark := get_glyph 35 from "cmssbx10";

  clear qv;
  qv := get_paths from Hash_mark;
  scale qv (10,10);

  Q35 := qv0;
  Q36 := qv1;
  Q37 := qv2;

  p10 := origin;
  p399 := p10 shifted (2, -2);
  p400 := (xpart get_point 20 Q35, ypart get_point 24 Q35);

  shift Q35 by (p399 - p400);
  shift Q36 by (p399 - p400);
  shift Q37 by (p399 - p400);

  p400 := get_point 1 Q37;
  p401 := get_point 2 Q37;
  p402 := (xpart p399, ypart p401);
  p403 := mediate(p399, p401);

  Q37 := p399 -- p400 -- p401 -- p402 -- cycle;

  draw Q37 with_color gray;
  draw Q35;
  draw Q36;

  if do_labels:
    dotlabel.bot("$p_{399}$", p399);
    dotlabel.bot("$p_{400}$", p400);
    dotlabel.top("$p_{401}$", p401);
    dotlabel.top("$p_{402}$", p402);
    dotlabel.bot("$p_{403}$", p403);
    label.ulft("$Q_{35}$", get_point 13 Q35);
    label.top("$Q_{36}$", p403);
    label.lrt("$Q_{37}$", p402) with_color darkgray;
  fi;

endfig;
fig_ctr := fig_ctr + 1;

%% --- At Sign (@) ---
beginfig(fig_ctr);

  draw frame with_pen pencircle scaled 0.5cm;

  glyph At_sign;
  At_sign := get_glyph 64 from "cmssbx10";

  clear qv;
  qv := get_paths from At_sign;
  scale qv (10,10);

  Q38 := qv0;
  Q39 := qv1;
  Q40 := qv2;

  p408 := p400 shifted (4,0);
  p409 := (xpart get_point 13 Q38, ypart get_point 14 Q38);

  shift Q38 by (p408 - p409);
  shift Q39 by (p408 - p409);
  shift Q40 by (p408 - p409);

  fill Q38 with_color gray;
  unfill Q39;

  p409 := get_point 1 Q40;
  p410 := get_point 2 Q40;
  p411 := (xpart p408, ypart p410);
  p412 := mediate(p408, p410);

  Q40 := p408 -- p409 -- p410 -- p411 -- cycle;

  draw Q40 with_color gray;
  draw Q38;
  draw Q39;

  if do_labels:
    dotlabel.bot("$p_{408}$", p408);
    dotlabel.bot("$p_{409}$", p409);
    dotlabel.top("$p_{410}$", p410);
    dotlabel.top("$p_{411}$", p411);
    dotlabel.bot("$p_{412}$", p412);
    label.bot("$Q_{39}$", p412 shifted (1.125, 1.5));
    label.top("$Q_{38}$", mediate(p411, p410));
  fi;

endfig;
fig_ctr := fig_ctr + 1;

%% --- Lowercase 'u' ---
beginfig(fig_ctr);

  draw frame with_pen pencircle scaled 0.5cm;

  glyph u_lc;
  u_lc := get_glyph 117 from "cmssbx10";

  clear qv;
  qv := get_paths from u_lc;
  scale qv (10,10);

  Q131 := qv0;
  Q132 := qv1;

  p632 := origin;
  p640 := p632 shifted (8,0);
  p641 := (xpart get_point 11 Q131, ypart get_point 12 Q131);

  shift Q131 by (p640 - p641);
  shift Q132 by (p640 - p641);

  p641 := get_point 1 Q132;
  p642 := get_point 2 Q132;
  p643 := (xpart p640, ypart p642);
  p644 := mediate(p640, p642);

  Q132 := p640 -- p641 -- p642 -- p643 -- cycle;
  draw Q132 with_color gray;
  draw Q131;

  p645 := p640 shifted (-offset, -offset);
  p646 := p641 shifted (offset, -offset);
  p647 := p642 shifted (offset, offset);
  p648 := p643 shifted (-offset, offset);

  Q133 := p645 -- p646 -- p647 -- p648 -- cycle;
  draw Q133 with_color red;

  if do_labels:
    dotlabel.bot("$p_{640}$", p640);
    dotlabel.bot("$p_{641}$", p641);
    dotlabel.top("$p_{642}$", p642);
    dotlabel.top("$p_{643}$", p643);
    dotlabel.bot("$p_{644}$", p644);
    dotlabel.bot("$p_{645}$", p645);
    dotlabel.bot("$p_{646}$", p646);
    dotlabel.top("$p_{647}$", p647);
    dotlabel.top("$p_{648}$", p648);
    label.lft("$Q_{131}$", mediate(p640, p643));
    label.top("$Q_{132}$", mediate(p643, p642)) with_color darkgray;
    label.top("$Q_{133}$", mediate(p647, p648)) with_color red;
  fi;

endfig;
fig_ctr := fig_ctr + 1;

verbatimtex
\end{document}
etex;
end
