#import "@preview/pyrunner:0.1.0" as py

#set heading()
#set text(
  font: "New Computer Modern"
)

= IzquierdaDominante

== versión 1

```python
def izqdom(A, low=0, high=len(inp)):
    if low == high-1: #O(1)
        return True
    
    mid = low + (high-low)//2 #O(1)

    sumaizq = sum(A[low:mid]) #O(n/2)
    sumader = sum(A[mid:high]) #O(n/2)

    if sumaizq > sumader:
        return izqdom(A, low, mid) and izqdom(A, mid, high) #a=2, c=2
    else:
        return False
```

== versión 2

```python
def izqdom(A):
    high = len(A) #O(1)
    low = 0 #O(1)
    mid = high//2 #O(1)

    if high-1 == low: #O(1)
        return True

    sumaizq = sum(A[low:mid]) #O(n/2)
    sumader = sum(A[mid:high]) #O(n/2)

    if sumaizq > sumader:
        return izqdom(A[low:mid]) and izqdom(A[mid:high]) #a=2, c=2
    else:
        return False
```
== Complejidad

$T(n) = 2 T(n/2) + O(n)$ y por teorema maestro, notamos que $O(n) = O(n^(log_2 2)) => T(n) = Theta(n^(log_2 2) log n) = Theta(n log n)$

= IndiceEspejo

```python
def indiceEspejo(A,low,high):

    mid = low + (high-low) //2 #O(1)

    if A[mid] == mid: #O(1)
        return mid
    elif len(A) == 1: #O(1)
        return -1
    
    elif A[mid] < mid:
        return indiceEspejo(A,mid+1,high) #a=1,c=2
    elif A[mid] > mid:
        return indiceEspejo(A,low,mid-1) #a=1,c=2
```

== Complejidad

$T(n)=1T(n/2)+O(1)$, por teorema maestro $O(n^(log_2 1)) = O(n^0) = O(1) => T(n) = O(n^(log_2 1) log n) = O(1 log n) = O(log n)$

= ComplexityQuest

== $T(n)=T(n/2)+n$

$f(n) = n = O(n), a=1, c = 2$ luego, 

$ O(n) = Omega(n^(log_2 1 +epsilon)) =>
O(n^1) = Omega(n^(0+epsilon)) "tomo" epsilon = 1 =>
O(n^1) = Omega(n^(1))\
"y tenemos que verificar que"  a f(n/c) = n/2 < k f(n) "para" k<1\ "lo cual es cierto, ya que" n/2 < k n "por ejemplo para" k = 2/3:\
1/2 n < 2/3 n and O(n) = Omega(n^epsilon) =>\
T(n) = Theta(f(n)) = Theta(n)
$

== $T(n)=2T(n/2)+log n$

$f(n) = log n in O(n^(1/2)), a= 2, c = 2$

$ f(n) = O(n^(1/2)) = O(n^(log_2 2 - epsilon)) = O(n^(1-epsilon))\
"tomo" epsilon = 1/2 => f(n) = O(n^(1/2)) =>\
T(n) = Theta(n^(log_c a)) = Theta(n) $

= SubBúsqueda

== Algoritmo
```python
def ubicar(A,e,low,high):
    
    mid = low + (high-low) // 2 #O(1)
    if len(A) == 1 and e not in A: #O(1)
        return False
    if A[mid] == e: #O(1)
        return True
    
    if aparece(A,low,mid,e): #O(raiz(mid-low+1)) = O(raiz(n/2))
        return ubicar(A,e,low,mid) #a=1, c=2
    else:
        return ubicar(A,e,mid+1,high)

```

== Complejidad

$T(n)=a T(n/c) + f(n) = T(n/2)+O(sqrt(n/2))$ o sea, $f(n) = O(n^(0,5)) and O(n^(log_c a)) = O(n^0)$ y tenemos por teorema maestro:
$O(n^(0,5)) = O(n^(log_2 1 + epsilon)) = O(n^epsilon)$ y si tomo $epsilon = 0,5:$

$f(n) = O(n^((log_c a) + epsilon))$ y tenemos que ver que:

$a f(n/c)) > k f(n) equiv sqrt(n) > k sqrt(n/2), k<1$ y esto es cierto $forall k$

Concluimos que $T(n) = Theta(sqrt(n))$