#set heading(numbering: "1.a)")
#set text(
  font: "New Computer Modern"
)

= SumaSubconjuntosBT

== Todos los subconjuntos

== {{6,6},{12}}

== {{},{6},{6,6},{12}}

== ni en pedo

== $ "ss"({c_1, ... , c_n}, k) = cases(
  k = 0 &"si" n = 0,
  "ss"({c_1, ... , c_(n−1)}, k) or "ss"({c_1, ... , c_(n−1)}, k − c_n) &"si" n > 0,
) $

