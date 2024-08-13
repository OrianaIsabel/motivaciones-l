% Aquí va el código.

% La Piramide

necesidad(respiracion, fisiologia).
necesidad(alimento, fisiologia).
necesidad(descanso, fisiologia).
necesidad(reproduccion, fisiologia).

necesidad(integridad, seguridad).
necesidad(empleo, seguridad).
necesidad(salud, seguridad).

necesidad(amistad, social).
necesidad(afecto, social).
necesidad(intimidad, social).

necesidad(confianza, reconocimiento).
necesidad(respeto, reconocimiento).
necesidad(exito, reconocimiento).

necesidad(talento, autorrealizacion).
necesidad(creatividad, autorrealizacion).
necesidad(libertad, autorrealizacion).

nivelSuperior(autorrealizacion, reconocimiento).
nivelSuperior(reconocimiento, social).
nivelSuperior(social, seguridad).
nivelSuperior(seguridad, fisiologia).

% Punto 2

esSuperior(Nivel, Nivel).

esSuperior(Nivel1, Nivel2):-
    nivelSuperior(Superior, Nivel2),
    esSuperior(Nivel1, Superior).

listaIntermedios(Nivel, Nivel, []):-
    necesidad(_, Nivel).

listaIntermedios(Inferior, Superior, [Superior]):-
    necesidad(_, Inferior),
    necesidad(_, Superior),
    nivelSuperior(Superior, Inferior).

listaIntermedios(Inferior, Superior, [Nivel|Niveles]):-
    necesidad(_, Inferior),
    necesidad(_, Superior),
    nivelSuperior(Nivel, Inferior),
    listaIntermedios(Nivel, Superior, Niveles).

nivelesIntermedios(Necesidad1, Necesidad2, CantNiveles):-
    necesidad(Necesidad1, Nivel1),
    necesidad(Necesidad2, Nivel2),
    esSuperior(Nivel1, Nivel2),
    listaIntermedios(Nivel2, Nivel1, Lista),
    length(Lista, CantNiveles).

nivelesIntermedios(Necesidad1, Necesidad2, CantNiveles):-
    necesidad(Necesidad1, Nivel1),
    necesidad(Necesidad2, Nivel2),
    esSuperior(Nivel2, Nivel1),
    listaIntermedios(Nivel1, Nivel2, Lista),
    length(Lista, CantNiveles).

% Punto 3

necesita(carla, alimento).
necesita(carla, descanso).
necesita(carla, empleo).

necesita(juan, afecto).
necesita(juan, exito).

necesita(roberto, amistad).

necesita(manuel, libertad).

necesita(charly, intimidad).

necesidadSup(Persona, Necesidad):-
    necesita(Persona, Necesidad),
    necesidad(Necesidad, Nivel),
    forall((necesita(Persona, OtraNecesidad), necesidad(OtraNecesidad, OtroNivel)), esSuperior(Nivel, OtroNivel)).

satisfacida(Persona, Necesidad):-
    necesita(Persona,_),
    necesidad(Necesidad,_),
    not(necesita(Persona, Necesidad)).

nivelSatisfacido(Persona, Nivel):-
    necesita(Persona,_),
    necesidad(_, Nivel),
    forall(necesidad(Necesidad, Nivel), satisfacida(Persona, Necesidad)).

% Motivacion

atiende(Persona, Nivel):-
    necesidad(_, Nivel),
    necesita(Persona,_),
    not(nivelSuperior(Nivel,_)),
    not(nivelSatisfacido(Persona, Nivel)).

atiende(Persona, Nivel):-
    necesidad(_, Nivel),
    necesita(Persona,_),
    nivelSuperior(Nivel, NivelInf),
    nivelSatisfacido(Persona, NivelInf),
    not(atiende(Persona, NivelInf)).