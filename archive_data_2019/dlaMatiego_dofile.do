  summarize rate reviewcount totalthingstodo interactive rank families couples solo business friends
  corr rate reviewcount totalthingstodo interactive rank families couples solo business friends
  tabulate interactive
  histogram rate
  hist reviewcount, name (g1)
  hist totalthingstodo, name(g2)
  hist rank, name(g3)
  hist families, name (g4)
  hist couples, name(g5)
  hist solo, name(g6)
  hist business, name(g7)
  hist friends, name(g8)
  graph combine g1 g2 g3 g4 g5 g6 g7 g8 
  regress  rate reviewcount totalthingstodo interactive rank families couples solo business friends
  test solo friends
  regress rate reviewcount totalthingstodo interactive rank families couples business
  test families interactive
  regress rate reviewcount totalthingstodo rank couples business
  test couples reviewcount
  regress rate totalthingstodo rank business
  drop if totalthingstodo <= 100
  regress rate totalthingstodo rank business
  test totalthingstodo rank business
  ovtest
  ovtest, rhs
  hettest
  imtest, white
  vif
  predict reszty, resid
  kdensity reszty, normal
  pnorm reszty
  sktest reszty
  
  