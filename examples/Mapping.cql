typeside T = literal {
    types string
    constants o : string
    functions reverse : string -> string
    equations
        forall x:string. x.reverse.reverse = x
}

schema S = literal : T {
    entities E
    foreign_keys f : E -> E
    path_equations
        f.f = E
    attributes a1 a2 : E -> string
    observation_equations
        forall e:E.  e.a1 = e.a2
    options
        allow_empty_sorts_unsafe = true
        program_allow_nontermination_unsafe = true
}

mapping M = literal : S -> S {
    entity E -> E
    foreign_keys
        f -> f.f
    attributes
        a1 -> lambda x. x.a1.reverse.reverse
        a2 -> lambda x. x.a2
}

instance I = literal : S {
    generators
        e : E
    equations
        e.a1 = e.a2
    options
        program_allow_nontermination_unsafe = true
}

transform h = literal : I -> I {
    generators
        e -> e.f
}

mapping m2 = [ M ; M ]

transform h2 = [ h ; h ]
