#import "@preview/pyrunner:0.1.0" as py

#set heading(numbering: "1.a.I.")
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

==
hecho xd

== $
"AT"_p (j,c) cases(
  -infinity &"if" c<0 or c>j,
  0 &"if" j=0 and c=0,
  max("AT"_p (j-1,c-1)-p_j,"AT"_p (j-1,c+1)+p_j,"AT"_p (j-1,c)) &"c.c.")
$

== $"AT"_p (n,0)$

==

```python
memo = [[None for _ in range(n+1)] for _ in range(n+1)]

def at(j, c):
    if memo[j][c] != None:
        return memo[j][c]
    
    if c < 0 or c > j:
        return float('-inf')

    if j == 0 and c == 0:
        return 0
    
    memo[j][c] = max(
                at(j-1, c-1) - p[j],
                at(j-1, c+1) + p[j],
                at(j-1, c)
            )
    
    return memo[j][c]

```

La complejidad espacial es $Theta(n^2)$ ya que en el peor caso, $c = n$ y debo memoizar para cada $i<=n$, la complejidad temporal será la misma que la espacial, lo que es una mejora a comparación de $O(3^n)$ en el caso sin memoizar.

== 

```python
memo = [[None for _ in range(n+1)] for _ in range(n+1)]

def atbt(p):
    memo[0][0] = 0

    for j in range(1, n+1):
        for c in range(0, j+1):
            if c < 0 or c > j:
                memo[j][c] = float('-inf')
            else:
                v1 = memo[j-1][c-1] if c-1 >= 0 else float('-inf')
                v2 = memo[j-1][c+1] if c+1 <= j-1 else float('-inf')
                v3 = memo[j-1][c]   if memo[j-1][c] else float('-inf')

                memo[j][c] = max(v1-p[j], v2+p[j], v3)

    return memo[n][0]

```

= CortesEconómicos

== 
convencido(?)

== $ "CE"(i,j,C) = cases(
  0 &"if" C = {},
  min("CE"(i,c,C-{c}),"CE"(c,j,C-{c}) | forall c in C, i <= c < j) + (j-i) & "c.c"
  )
$

Se explica por si misma, se resuelve con $"CE"(0,ell)$ donde $C$ son los cortes posibles

== 
```python
memo = {}

def ce(i, j, C):
    if (i, j) in memo:
        return memo[(i,j)]
    
    res = []
    if not C:
        return 0
    
    for c in C:
        s1= ce(i, c, [k for k in C if i <= k < c])
        s2 = ce(c, j, [k for k in C if c < k < j])
        res.append(s1+s2+(j-i))

    memo[(i,j)] = min(res)
    return memo[(i,j)]
```

Será $O(n^3)$ temporal y $O(n^3)$ espacial. Un bottom-up costaría lo mismo temporal y $(n^2)$ espacial ya que no memoizamos cada k

= Travesía Vital

== $ "TV"_A (i,j) cases(
  1 &"if" "TV"'_A (i,j) < 1,
  "TV"'_A (i,j) &"c.c."
  ) $

$ "TV"'_A (i,j) cases(
  A_(i,j) &"if" i=n and j=m,
  A_(i+1,j)+"TV"'_A (i+1,j) &"if" (A_(i+1,j) < A_(i,j+1) and i < n) or j=m,
  A_(j,i+1)+"TV"'_A (i,j+1) &"if" (A_(i+1,j) >= A_(i,j+1) and j < m) or i=n
) $

está mal pero bueno, a corregir por el lector!

==
si

== $ "TV"_A (i,j) cases(
  "TVmax"_A (1-A_(i,j)) &"if" i = n and j=m,
  "TVmax"_A ("TV"_A (i,j+1) - A_(i,j)) &"if" i = n,
  "TVmax"_A ("TV"_A (i+1,j) - A_(i,j)) &"if" j = m,
  "TVmax"_A (min("TV"_A (i+1,j),"TV"_A (i,j+1)) - A_(i,j))&"c.c." 
) $

$ "TVmax"_A (f) = max(1,f)$

Se resuelve con $"TV"_A (1,1)$

== 
```python
A=[
    [0,0,0,0],
    [0,-2,-3,3],
    [0,-5,-10,1],
    [0,10,30,-5]]

n = len(A[0])-1
m = len(A)-1

memo = {}

def TV(i, j):
    if (i,j) in memo:
        return memo[(i,j)]
    
    if i == n and j == m:
        memo[(i,j)] = TVmax(1-A[i][j])
        return memo[(i,j)]

    if i == n:
        memo[(i,j)] = TVmax(TV(i,j+1) - A[i][j])
        return memo[(i,j)]
    
    if j == m:
        memo[(i,j)] = TVmax(TV(i+1,j) - A[i][j])
        return memo[(i,j)]
    
    memo[(i,j)] = TVmax(min(TV(i+1,j), TV(i,j+1)) - A[i][j])
    return memo[(i,j)]

def TVmax(f):
    return max(1,f)
    
print(TV(1,1))
```

La complejidad temporal será $O(n m)$ y la espacial $O(n m)$, frente a un bottom-up que probablemente lo unico que cambiaría sería la recursión por dos bucles anidados hasta n y m respectivamente.

== 
No cumple con la complejidad pero una solución B-U. Una posible solución es usar un while hasta n,m e ir incrementando i o j en base a la desición
```python
A = [
    [0, 0, 0, 0],
    [0, -2, -3, 3],
    [0, -5, -10, 1],
    [0, 10, 30, -5]
]

n = len(A)-1
m = len(A[0])-1

memo = [[float('inf')] * (m+1) for _ in range(n+1)]

def TV(i, j):
    memo[n][m] = TVmax(1-A[n][m])

    for i in range(n-1, -1, -1):
        memo[i][m] = TVmax(memo[i+1][m] - A[i][m])

    for j in range(m-1, -1, -1):
        memo[n][j] = TVmax(memo[n][j+1] - A[n][j])

    for i in range(n-1, -1, -1):
        for j in range(m-1, -1, -1):
            memo[i][j] = TVmax(min(memo[i+1][j], memo[i][j+1]) - A[i][j])

    return memo[1][1]

def TVmax(f):
    return max(1,f)

print(TV(1, 1))

```

= PilaCauta


qvq $s_k-s_i >= 0 and s_k-s_i>=w_i$ cada paso, partiendo de $i=n and C={}$ para cada $k != i$ y en cada paso hacer $C=C union {i}$


Primero defino $n = |S|$
- Parto de $i=n and C={}$
- Devolver 1 si $|C| = n$
- $forall c not in C | 1<=c<=n :: 1 + max(C-{c}) $ tal que valga $s_c-s_i >=0 and s_c-s_i>=w_i$

$ "pc"(i,C) = cases(
  0 &"if" |C|=n,
  max(1+"pc"(c,C union {c}) | c not in C and S_c-S_i >= 0 and S_k-S_i>=w_i) &"if" |C|<n
  )

 $

== LA POSTA! (al final fracasé en el intento)

== 
$ "pc"_(W,S) (i,p) = cases(
  0 &"if" i < n,
  max("pc"(i+1,p)) &"if" s_i>=p and s_i-p>=w_i,
  "pc"(i+1,p) &"if" p > s_i

  ) $

Para $i=1, p=0$

La posta nada..

= OperacionesSeq

== 
$ "os"_("res") (i,w,C) = "reverse"("os"_v (i,w,C))$

$ "os"_v (i,w,C) = cases(
  emptyset &"if" |C| = n and v_i != w,
  C &"if" |C| = n and v_i = w,
  "any"(alpha,beta,gamma | "if" C != emptyset "else" emptyset) &"if" |C| != n
  ) $

$alpha = "os"(i-1,w-v_i,C xor [+])$

$beta = "os"(i-1,w/v_i,C xor [x])$

$gamma = "os"(i-1,root(v_i,w),C xor [↑])$

Esto se resuelve para $"os"_("res") (n,w,emptyset)$

== 
```python
v = [0,3,1,5,2,1]
n = len(v)-1
C = ""
memo = {}
def os(i,w,C):
    if (i,w) in memo:
        return memo[(i,w)]
    
    if len(C) == n-1 and w != v[i]:
        return ""
    
    if len(C) == n-1 and w == v[i]:
        return C
    
    res1 = os(i-1,w-v[i],C + "+")
    res2 = os(i-1,w/v[i],C + "x")
    res3 = os(i-1,w**(1/v[i]),C + "↑")

    if res1:
        memo[(i,w)] = res1
    elif res2:
        memo[(i,w)] = res2
    elif res3:
        memo[(i,w)] = res3
    else:
        memo[(i,w)] = ""

    return memo[(i,w)]
    
def os_res(i,w,C):
    return os(i,w,C)[::-1] #sale al revés porque obviamente es recursivo

print(os_res(n,400,C))
```

Tenemos 3 recursiones, es claramente $O(3^n)$ tanto temporal como espacial sin memo, $O(n w))$ tanto espacial como temporal con memo, esto es porque hacemos $O(n w)$ llamadas recursivas

Si fuese bottom-up sería iterando de 1 a n y para cada uno, de 1 a w, con complejidad tanto espacial como temporal idéntica a la top-down

== 