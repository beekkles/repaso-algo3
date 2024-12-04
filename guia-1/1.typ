#set heading(numbering: "1.a.")
#set text(
  font: "New Computer Modern"
)
#import "@preview/algo:0.3.4": algo, i, d, comment, code

=
=
=
=
= _SumaDinámica_

== $ "ss"'_C s(i,j) = cases(
  j = 0 &"si" i = 0,
  "ss"'_C (i-1,j) &"si" i != 0 and C[i] > j,
  "ss"'_C (i-1,j) or "ss"'_C (i-1,j-C[i]) &"c.c."
  ) $

Es igual al 1.f, nada más que acotar su señoría

$O(2^n)$ llamadas recursivas son suficientes ya que son todas las combinaciones :v

==
En papel
==
Convencido! Es $O((n+1) (k+1)) in O(n k)$

== 
$k >> 2^n ==> O(n k) >> O(2^n)$

$k << 2^n ==> O(n k) << O(2^n)$

==
Si

= _OptiPago_

== $ "cc" (B,c) = cases(

    (0,0) &"if" c = 0,
    (infinity,infinity) &"if" B={} and c > 0,
    (b_n,1) &"if" b_n = c,
    min_(c,q) ("cc"(B-{b_n},c-b_n) + (b_n,1),"cc"(B-{b_n},c)) & "c.c." ,
) $

Para $n=|B|$, solve con $"cc" (B,c,0)$

== 
Queda de ejercicio al lector

== $ "cc"_B (i,j) = cases(

    (0,0) &"if" j = 0,
    (infinity,infinity) &"if" i=0 and j > 0,
    (B[i],1) &"if" B[i] = j,
    min_(i,j) ("cc"_B (i-1,j-B[i]) + (B[i],1),"cc"_B (i-1,j)) & "c.c." ,
) $

solve con $"cc"_B (|B|,c) $

==
Una matriz $M$ de $n times c$, se crea en $O(n c)$

== 
Lo mismo que el *e.* pero antes de recursionar chequea si existe $M[i-1,j]$ y $M[i-1,j-B[i]]$, si no existe, lo calcula y guarda, luego lo retorna en ambos casos.

== 
$"cc"_B (|B|,c) $, la complejidad es $Omega(n c)$ y $O(n c)$, que es peor que $Omega(1)$ pero mejor que $O(2^n)$

==
Para $B, c$ y $n = |B|$:

#algo(
  title: "cc",
  parameters: ("i","j") 
)[
  $M[n times c] <- forall i,j:: M[i][j] = (infinity,infinity)$\ 
  let res $<- (infinity,infinity)$\
  if $j = 0$:#i\
    return $(0,0)$#d\
  for $i <- 1$ to $n$: #i\
        if $B[i-1]=c$:#i\
          return $(B[i-1],1)$#d\
      for $j <- 1$ to $c$: #i\
         $M[i][j] = min(M[i-1][j-B[i]]+(B[i],1),M[i-1][j])$#d#d\

  return M[n][c] 
] 

= AstroTrade


