from pathlib import Path

import clips


RULES_PATH = Path(__file__).with_name("reglas_estudio.clp")


def recomendar(proximidad: str, dificultad: str, tiempo_disponible: str) -> list[dict[str, str]]:
    """Execute the CLIPS knowledge base and return every matching recommendation."""
    entorno = clips.Environment()
    entorno.load(str(RULES_PATH))
    entorno.reset()

    situacion = entorno.find_template("situacion-estudio")
    situacion.assert_fact(
        proximidad=clips.Symbol(proximidad),
        dificultad=clips.Symbol(dificultad),
        **{"tiempo-disponible": clips.Symbol(tiempo_disponible)},
    )
    entorno.run()

    recomendaciones = []
    for hecho in entorno.facts():
        if hecho.template.name == "recomendacion":
            recomendaciones.append(
                {"regla": str(hecho["regla"]), "mensaje": str(hecho["mensaje"])}
            )

    return sorted(recomendaciones, key=lambda item: item["regla"])


if __name__ == "__main__":
    resultado = recomendar("cercano", "baja", "poco")
    for recomendacion in resultado:
        print(f"{recomendacion['regla']}: {recomendacion['mensaje']}")
