; Base de conocimiento para recomendar estrategias de estudio.

(deftemplate situacion-estudio
  (slot proximidad
    (type SYMBOL)
    (allowed-values muy-cercano cercano lejano))
  (slot dificultad
    (type SYMBOL)
    (allowed-values alta baja))
  (slot tiempo-disponible
    (type SYMBOL)
    (allowed-values poco mucho)))

(deftemplate recomendacion
  (slot regla (type SYMBOL))
  (slot mensaje (type STRING)))

(defrule R01-estudio-intensivo
  (situacion-estudio (proximidad muy-cercano) (dificultad alta))
  =>
  (assert (recomendacion
    (regla R01)
    (mensaje "Realizar un estudio intensivo de los temas más importantes."))))

(defrule R02-priorizar-conceptos
  (situacion-estudio (proximidad cercano) (tiempo-disponible poco))
  =>
  (assert (recomendacion
    (regla R02)
    (mensaje "Priorizar los conceptos clave y los ejercicios principales."))))

(defrule R03-plan-progresivo
  (situacion-estudio (proximidad lejano) (tiempo-disponible mucho))
  =>
  (assert (recomendacion
    (regla R03)
    (mensaje "Seguir un plan de estudio progresivo y constante."))))

(defrule R04-repaso-general
  (situacion-estudio (proximidad cercano) (dificultad baja))
  =>
  (assert (recomendacion
    (regla R04)
    (mensaje "Realizar un repaso general y resolver ejercicios de práctica."))))
