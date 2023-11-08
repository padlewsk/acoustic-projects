Mathieu Padlewski
25.07.2023
simulations done with 50 cells

- L: linear coupling
- NL: nonlinear

- topo: Topological Interface (pulse)
	v.A.L  = 0;    %segment A
	w.A.L  = 0.8;
	v.B.L  = 0.8;  %segment B
    w.B.L  = 0;

- triv: dimerization (pulse)
	v.A.L  = 0;    %segment A
	w.A.L  = 0.8;
	v.B.L  = 0;    %segment B
    w.B.L  = 0.8;

- ref: passive system for reference:
	v.A.L  = 0;    %segment A
	w.A.L  = 0;
	v.B.L  = 0;    %segment B
    w.B.L  = 0;